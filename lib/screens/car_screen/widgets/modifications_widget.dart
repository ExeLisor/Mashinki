import 'package:autoverse/exports.dart';

class ModificationsWidget extends StatelessWidget {
  const ModificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 25.w,
            ),
            _groups(),
            SizedBox(
              width: 25.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _groups() {
    List<GlobalKey> keys = List.generate(
      ModsGroupContoller.to.groups.length,
      (index) => GlobalKey(),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        for (var key in keys) {
          final context = key.currentContext;
          if (context != null) {
            final size = context.size;

            ModsGroupContoller.to.addSize(size ?? Size(215.w, 0));
          }
        }
      },
    );

    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          ModsGroupContoller.to.groups.length,
          (index) {
            String groupName =
                ModsGroupContoller.to.groups.keys.toList()[index];
            List<dynamic> modifications =
                ModsGroupContoller.to.groups[groupName] ?? [];
            return ModificationGroupTile(
              key: keys[index],
              widgetIndex: index,
              groupName: groupName,
              modifications: modifications,
            );
          },
        ),
      ),
    );
  }
}

class ModificationGroupTile extends StatelessWidget {
  const ModificationGroupTile(
      {super.key,
      required this.groupName,
      required this.modifications,
      required this.widgetIndex});
  final String groupName;
  final List modifications;
  final int widgetIndex;

  @override
  Widget build(BuildContext context) => Obx(
        () => groupName == ModsGroupContoller.to.openedGroupName
            ? _openedMods()
            : _header(),
      );

  Widget _header() => Obx(
        () => GestureDetector(
          onTap: () => groupName == ModsGroupContoller.to.openedGroupName
              ? ModsGroupContoller.to.close()
              : ModsGroupContoller.to.open(groupName),
          child: Container(
            height: 36.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: groupName == ModsGroupContoller.to.openedGroupName
                  ? BorderRadius.vertical(top: Radius.circular(25.h))
                  : BorderRadius.circular(25.h),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text(),
                  SizedBox(
                    width: 7.w,
                  ),
                  _arrowIcon()
                ],
              ),
            ),
          ),
        ),
      );

  Widget _text() => Text(
        groupName,
        style: TextStyle(
          color: whiteColor,
          fontSize: 18.fs,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _arrowIcon() => Obx(
        () => RotatedBox(
          quarterTurns:
              groupName == ModsGroupContoller.to.openedGroupName ? 1 : 3,
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: whiteColor,
          ),
        ),
      );

  Widget _openedMods() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          _modsList(),
        ],
      );

  Widget _modsList() {
    return Container(
      constraints: BoxConstraints(minWidth: 215.w),
      width: ModsGroupContoller.to.headerSizes[widgetIndex].width + 25.w,
      decoration: BoxDecoration(
        color: AppThemeController.to.isDarkTheme
            ? const Color(0xff4d4d4d)
            : whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(27.h),
          bottomLeft: Radius.circular(27.h),
          bottomRight: Radius.circular(27.h),
        ),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          modifications.length,
          (index) {
            Modification modification = modifications[index];

            Size sizeWidget = ModsGroupContoller.to.headerSizes[widgetIndex];

            return _modsTile(
              modification,
              sizeWidget,
              isFirst: index == 0,
              isLast: index == modifications.length - 1,
            );
          },
        ),
      ),
    );
  }

  Widget _modsTile(
    Modification modification,
    Size size, {
    bool isLast = false,
    bool isFirst = false,
  }) {
    return Obx(
      () {
        bool isSelected =
            CarController.to.car.selectedModification == modification;

        List<String> title = modification.title!.split(" ");
        return GestureDetector(
          onTap: () {
            CarController.to.selectModification(modification);
            ModsGroupContoller.to.close();
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(isFirst ? 26.h : 0),
                bottomLeft: Radius.circular(isLast ? 26.h : 0),
                bottomRight: Radius.circular(isLast ? 26.h : 0),
              ),
              color: isSelected ? paleColor : Colors.transparent,
            ),
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      Color selectedColor = whiteColor;
                      Color unselectedColor = AppThemeController.to.isDarkTheme
                          ? whiteColor
                          : primaryColor;
                      return Text(
                        //volume-litres transmission
                        "${title[0]} ${title[1]}",
                        style: TextStyle(
                          color: isSelected ? selectedColor : unselectedColor,
                          fontSize: 18.fs,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                    SizedBox(
                      width: 23.w,
                    ),
                    Obx(() {
                      Color selectedColor = whiteColor;
                      Color unselectedColor = AppThemeController.to.isDarkTheme
                          ? const Color(0xffA6A6A6)
                          : primaryColor;
                      return Text(
                        // horse power
                        "${title[2]} ${"л.с.".tr}",
                        style: TextStyle(
                          color: isSelected ? selectedColor : unselectedColor,
                          fontSize: 18.fs,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                isLast || isSelected ? Container() : _divider()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _divider() => Container(
        width: 168.w,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: paleColor,
            ),
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

class ModsGroupContoller extends GetxController {
  static ModsGroupContoller get to => Get.find();

  final RxMap _groups = {}.obs;
  final RxString _openedGroupName = "".obs;
  final RxList<Size> _headerSizes = <Size>[].obs;

  Map get groups => _groups;
  String get openedGroupName => _openedGroupName.value;
  List<Size> get headerSizes => _headerSizes;

  void addSize(Size size) {
    if (_headerSizes.contains(size)) return;
    _headerSizes.add(size);
  }

  void open(String groupName) => _openedGroupName.value = groupName;

  void close() => _openedGroupName.value = "";

  @override
  void onInit() {
    _groups.value = groupBy(CarController.to.car.modifications,
        (mod) => mod.groupName ?? "Базовая".tr);
    super.onInit();
  }
}

class ModsGroupBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModsGroupContoller());
}
