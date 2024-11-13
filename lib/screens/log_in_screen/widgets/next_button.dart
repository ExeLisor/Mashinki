import 'package:autoverse/exports.dart';

class NextButton extends StatelessWidget {
  final Function() onTap;
  final ButtonController controller =
      Get.put(ButtonController()); // Создаем экземпляр контроллера

  NextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 55.h,
        width: 342.w,
        decoration: BoxDecoration(
            color:
                controller.isEnabled.value == true ? primaryColor : paleColor,
            borderRadius: BorderRadius.circular(20)),
        child: const Center(
            child: Text("Далее",
                style: TextStyle(color: whiteColor, fontSize: 14))),
      ),
    );
  }
}
