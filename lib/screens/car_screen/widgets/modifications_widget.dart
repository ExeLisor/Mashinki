import 'package:autoverse/exports.dart';

class ModificationsWidget extends StatelessWidget {
  const ModificationsWidget({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.0.h),
          child: Row(
            children: [
              SizedBox(
                width: 25.w,
              ),
              ...List.generate(
                CarController.to.modifications.length,
                (index) {
                  Modification modification =
                      CarController.to.modifications[index];
                  CarSpecifications specification =
                      modification.carSpecifications!;
                  String transmission =
                      getTransmissionAbb(specification.transmission);

                  String power = specification.horsePower;
                  String privod = specification.drive == "полный" ? "4WD" : "";

                  return GestureDetector(
                    onTap: () =>
                        CarController.to.selectModification(modification),
                    child: Obx(
                      () => Container(
                        margin: EdgeInsets.only(right: 10.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 11.h, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: CarController.to.selectedModification ==
                                    modification
                                ? primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        child: Text(
                          "$transmission $power $privod",
                          style: TextStyle(
                              color: CarController.to.selectedModification ==
                                      modification
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

String getTransmissionAbb(String value) {
  String abbreviature = value;
  switch (value) {
    case "вариатор":
      return "CVT";
    case "автоматическая":
      return "AT";
    case "механическая":
      return "MT";
    case "робот":
      return "AMT";

    default:
  }
  return abbreviature;
}
