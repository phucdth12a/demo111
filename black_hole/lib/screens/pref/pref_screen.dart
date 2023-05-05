import 'package:black_hole/custom_widget.dart/gradient_containers.dart';
import 'package:black_hole/helpers/countrycodes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pref_controller.dart';

class PrefScreen extends GetView<PrefController> {
  const PrefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: Get.width / 1.85,
              child: SafeArea(
                child: Image.asset(
                  'assets/icon-white-trans.png',
                  width: Get.width,
                  height: Get.width,
                ),
              ),
            ),
            const GradientContainer(opacity: true),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: controller.skipAction,
                        child: Text(
                          'skip'.tr,
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '${'welcome'.tr}\n',
                                      style: TextStyle(
                                        fontSize: 65,
                                        height: 1.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'aboard'.tr,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 75,
                                            color: Colors.white,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '!\n',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 70,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'prefReq'.tr,
                                          style: const TextStyle(
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ListTile(
                                  title: Text(
                                    'langQue'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      left: 10,
                                      right: 10,
                                    ),
                                    height: 57,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[900],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          controller.preferredLanguage.isEmpty
                                              ? 'None'
                                              : controller.preferredLanguage
                                                  .join(', '),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                  ),
                                  dense: true,
                                  onTap: () => showListLanguage(context),
                                ),
                                const SizedBox(height: 30),
                                ListTile(
                                  title: Text(
                                    'countryQue'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      left: 10,
                                      right: 10,
                                    ),
                                    height: 57,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[900],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          controller.region.value,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                  ),
                                  dense: true,
                                  onTap: () => showListRegion(context),
                                ),
                                const SizedBox(height: 30),
                                GestureDetector(
                                  onTap: controller.skipAction,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.tealAccent[400],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'finish'.tr,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showListLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        controller.checked = controller.preferredLanguage;
        final listLanguages = controller.languages;
        return BottomGradientContainer(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  itemCount: listLanguages.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CheckboxListTile(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value:
                            controller.checked.contains(listLanguages[index]),
                        title: Text(listLanguages[index]),
                        onChanged: (value) {
                          value!
                              ? controller.checked.add(listLanguages[index])
                              : controller.checked.remove(listLanguages[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => Get.back(),
                    child: Text('cancel'.tr),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: controller.saveLanguage,
                    child: Text(
                      'ok'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  showListRegion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        const codes = ConstantCodes.localChartCodes;
        final countries = codes.keys.toList();
        return BottomGradientContainer(
          borderRadius: BorderRadius.circular(20),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return ListTileTheme(
                selectedColor: Theme.of(context).colorScheme.secondary,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  title: Text(countries[index]),
                  trailing: controller.region.value == countries[index]
                      ? const Icon(Icons.check_rounded)
                      : const SizedBox.shrink(),
                  selected: controller.region.value == countries[index],
                  onTap: () => controller.saveRegion(countries[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
