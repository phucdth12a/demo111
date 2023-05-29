import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:black_hole/helpers/config.dart';
import 'package:black_hole/helpers/countrycodes.dart';
import 'package:black_hole/routes/routes.dart';
import 'package:black_hole/screens/player/component/audioplayer.dart';
import 'package:black_hole/services/audio_service.dart';
import 'package:black_hole/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'helpers/logging.dart';
import 'localization/localiztion.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('BlackHole');
  } else {
    await Hive.initFlutter();
  }
  await openHiveBox('settings');
  await openHiveBox('downloads');
  await openHiveBox('stats');
  await openHiveBox('Favorite Songs');
  await openHiveBox('cache', limit: true);
  await openHiveBox('ytlinkcache', limit: true);

  if (Platform.isAndroid) {
    await setOptimalDisplayMode();
  }

  await startServices();
  runApp(const MyApp());
}

Future<void> setOptimalDisplayMode() async {
  await FlutterDisplayMode.setHighRefreshRate();
}

Future<void> startServices() async {
  await initializeLogging();
  final AudioPlayerHandler audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.shadow.blackhole.channel.audio',
      androidNotificationChannelName: 'BlackHole',
      androidNotificationIcon: 'drawable/ic_stat_music_note',
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: false,
      notificationColor: Colors.grey[900],
    ),
  );

  GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
  GetIt.I.registerSingleton<MyTheme>(MyTheme());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    Logger.root.severe('Failed to open $boxName Box', error, stackTrace);
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/BlackHole/$boxName.hive');
      lockFile = File('$dirPath/BlackHold/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });

  /// clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // static _MyAppState of(BuildContext context) =>
  //     context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');
  late StreamSubscription _intentTextStreamSubscription;
  late StreamSubscription _intentDataStreamSubscription;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final String systemLangCode = Platform.localeName.substring(0, 2);
    if (ConstantCodes.languageCodes.values.contains(systemLangCode)) {
      _locale = Locale(systemLangCode);
    } else {
      final String lang =
          Hive.box('settings').get('lang', defaultValue: 'English');
      _locale = Locale(ConstantCodes.languageCodes[lang] ?? 'en');
    }

    AppTheme.currentTheme.addListener(() {
      setState(() {});
    });

    _intentTextStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((value) {
      Logger.root.info('Received intent on stream: $value');
      // handleSharedText(value, navigatorKey);
    }, onError: (err) {
      Logger.root.severe('ERROR in getTextStream', err);
    });

    ReceiveSharingIntent.getInitialText().then((value) {
      Logger.root.info('Received intent on stream: $value');
      // if (value != null) handleSharedText(value, navigatorKey);
    }, onError: (err) {
      Logger.root.severe('ERROR in getTextStream', err);
    });

    _intentDataStreamSubscription =
        ReceiveSharingIntent.getMediaStream().listen((value) {
      if (value.isNotEmpty) {
        for (final file in value) {
          if (file.path.endsWith('.json')) {
            final List playListNames =
                Hive.box('settings').get('playListNames')?.toList() as List;
            // importFilePlayList(null, playListNames,
            //         path: file.path, pickFile: false)
            //     .then((value) {
            //   Get.toNamed('/playlists');
            // });
          }
        }
      }
    }, onError: (err) {
      Logger.root.severe('ERROR in getDataStream', err);
    });

    ReceiveSharingIntent.getInitialMedia().then((value) {
      if (value.isNotEmpty) {
        for (final file in value) {
          if (file.path.endsWith('.json')) {
            final List playListNames =
                Hive.box('settings').get('playListNames')?.toList() as List;
            // importFilePlayList(null, playListNames,
            //         path: file.path, pickFile: false)
            //     .then(
            //   (value) {
            //     Get.toNamed('/playlists');
            //   },
            // );
          }
        }
      }
    });
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void dispose() {
    _intentTextStreamSubscription.cancel();
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppTheme.themeMode == ThemeMode.dark
            ? Colors.black38
            : Colors.white,
        statusBarBrightness: AppTheme.themeMode == ThemeMode.dark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarIconBrightness: AppTheme.themeMode == ThemeMode.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return GetMaterialApp(
      title: 'BlackHole',
      // restorationScopeId: 'blackhole',
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.themeMode,
      theme: AppTheme.lightTheme(
        context: context,
      ),
      darkTheme: AppTheme.darkTheme(
        context: context,
      ),
      translations: Localization(),
      locale: _locale,
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        print("settings.name == ${settings.name}");
        if (settings.name == '/player') {}
      },
      initialRoute: Hive.box('settings').get('userId') != null
          ? Routes.home
          : Routes.login,
      getPages: Routes.getPages,
    );
  }
}
