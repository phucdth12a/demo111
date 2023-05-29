import 'package:black_hole/custom_widget.dart/gradient_containers.dart';
import 'package:black_hole/gen/assets.gen.dart';
import 'package:black_hole/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Positioned(
              left: Get.width / 1.85,
              child: SizedBox(
                width: Get.width,
                height: Get.width,
                child: Assets.images.iconWhiteTrans.image(),
              ),
            ),
            const GradientContainer(opacity: true),
            Column(
              children: [
                widgetHeader(),
                widgetContent(context, controller),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetHeader() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: controller.restoreAction,
            child: Text('restore'.tr),
          ),
          TextButton(
            onPressed: controller.skipAction,
            child: Text(
              'skip'.tr,
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetContent(BuildContext context, LoginController controller) {
    return Expanded(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 30, right: 30),
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Black\nHold\n',
                        style: TextStyle(
                          height: 0.97,
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Music',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 80,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 80,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.1),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      height: 57,
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
                      child: TextField(
                        controller: controller.textEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.transparent,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          border: InputBorder.none,
                          hintText: 'enterName'.tr,
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onSubmitted: (value) => controller.onSubmitAction(),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onSubmitAction,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.secondary,
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
                            "getStarted".tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('disclaimer'.tr),
                            ],
                          ),
                          Text(
                            'disclaimerText'.tr,
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
