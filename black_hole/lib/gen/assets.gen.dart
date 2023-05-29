/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/GitHub_Logo.png
  AssetGenImage get gitHubLogo =>
      const AssetGenImage('assets/images/GitHub_Logo.png');

  /// File path: assets/images/GitHub_Logo_White.png
  AssetGenImage get gitHubLogoWhite =>
      const AssetGenImage('assets/images/GitHub_Logo_White.png');

  /// File path: assets/images/album.png
  AssetGenImage get album => const AssetGenImage('assets/images/album.png');

  /// File path: assets/images/artist.png
  AssetGenImage get artist => const AssetGenImage('assets/images/artist.png');

  /// File path: assets/images/black-button.png
  AssetGenImage get blackButton =>
      const AssetGenImage('assets/images/black-button.png');

  /// File path: assets/images/cover.jpg
  AssetGenImage get cover => const AssetGenImage('assets/images/cover.jpg');

  /// File path: assets/images/gpay-black.png
  AssetGenImage get gpayBlack =>
      const AssetGenImage('assets/images/gpay-black.png');

  /// File path: assets/images/gpay-white.png
  AssetGenImage get gpayWhite =>
      const AssetGenImage('assets/images/gpay-white.png');

  /// File path: assets/images/header-dark.jpg
  AssetGenImage get headerDark =>
      const AssetGenImage('assets/images/header-dark.jpg');

  /// File path: assets/images/header.jpg
  AssetGenImage get header => const AssetGenImage('assets/images/header.jpg');

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  /// File path: assets/images/icon-white-trans.png
  AssetGenImage get iconWhiteTrans =>
      const AssetGenImage('assets/images/icon-white-trans.png');

  /// File path: assets/images/lyrics.png
  AssetGenImage get lyrics => const AssetGenImage('assets/images/lyrics.png');

  /// File path: assets/images/song.png
  AssetGenImage get song => const AssetGenImage('assets/images/song.png');

  /// File path: assets/images/ytCover.png
  AssetGenImage get ytCover => const AssetGenImage('assets/images/ytCover.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        gitHubLogo,
        gitHubLogoWhite,
        album,
        artist,
        blackButton,
        cover,
        gpayBlack,
        gpayWhite,
        headerDark,
        header,
        icLauncher,
        iconWhiteTrans,
        lyrics,
        song,
        ytCover
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
