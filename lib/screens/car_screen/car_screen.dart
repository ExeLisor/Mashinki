import 'package:autoverse/exports.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppThemeController.to.isDarkTheme
            ? const Color(0xff292929)
            : greyBackground,
        appBar: _appBar(),
        body: Obx(() => CarController.to.state.value == Status.success
            ? _carBody()
            : _loadingWidget()),
        bottomNavigationBar: HomeScreenBottomBarWidget(),
      ),
    );
  }

  Widget _carBody() {
    ScrollController controller = ScrollController();
    return GetBuilder<CarController>(
      initState: (state) => CarAppbarController.to.startListen(controller),
      builder: (carController) => Stack(
        children: [
          _body(controller),
          _floatBar(),
        ],
      ),
    );
  }

  Widget _floatBar() => FloatBar(
        controller: CarAppbarController.to,
        child: const CarsFloatBar(),
      );

  Widget _body(ScrollController controller) => SingleChildScrollView(
      controller: controller,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_carImage(), _carTitleWidget(), _carDetails()]));

  AppBar _appBar() => AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      );

  Widget _loadingWidget() => const Center(child: CircularProgressIndicator());

  Widget _carDetails() => Stack(
        children: [
          _details(),
          _modifications(),
        ],
      );

  Widget _details() => Padding(
        padding: EdgeInsets.only(top: 65.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _selectorWidget(),
            _specs(),
          ],
        ),
      );

  Widget _specs() => Obx(() => !SpecsSelectorController.to.showOptions
      ? const CharacteristicsWidget()
      : OptionsWidget());

  Widget _modifications() => Container(
      margin: EdgeInsets.only(top: 10.h), child: const ModificationsWidget());

  Widget _selectorWidget() => Obx(
        () => Row(
          children: [
            _selectorTile(
                "specifications".tr, SpecsSelectorController.to.changeToSpecs,
                isSelected: !SpecsSelectorController.to.showOptions),
            _selectorTile(
                "group-name".tr, SpecsSelectorController.to.changeToOptions,
                isSelected: SpecsSelectorController.to.showOptions)
          ],
        ),
      );

  Widget _selectorTile(String text, VoidCallback func,
          {bool isSelected = true}) =>
      GestureDetector(
        onTap: func,
        child: Obx(() {
          Color selectedColor = AppThemeController.to.isDarkTheme
              ? const Color(0xff19191B)
              : whiteColor;

          Color unselectedColor = AppThemeController.to.isDarkTheme
              ? const Color(0xff232323)
              : greySurface;
          return Container(
            height: 46.h,
            width: Get.width / 2,
            decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedColor,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24.h))),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18.fs,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    color: isSelected ? primaryColor : paleColor),
              ),
            ),
          );
        }),
      );

  Widget _carTitleWidget() => Obx(
        () => Container(
          width: Get.width,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
              color: AppThemeController.to.isDarkTheme
                  ? const Color(0xff19191B)
                  : whiteColor,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(24.h))),
          child: Container(
            margin: EdgeInsets.only(top: 22.h, bottom: 30.h),
            padding: EdgeInsets.only(left: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _carTitle(),
                _carSubTitle(),
                SizedBox(height: 20.h),
                _carDescription()
              ],
            ),
          ),
        ),
      );

  Widget _carDescription() => Container(
        margin: EdgeInsets.only(right: 25.w),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "description".tr,
                style: TextStyle(
                  color: AppThemeController.to.isDarkTheme
                      ? Colors.white
                      : primaryColor,
                  fontSize: 18.fs,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                CarController.to.car.description,
                style: TextStyle(
                  color: AppThemeController.to.isDarkTheme
                      ? unactiveColor
                      : blackColor,
                  fontSize: 14.fs,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );

  // Widget _tagsWidget() => Wrap(
  //       runSpacing: 6.h,
  //       children: [
  //         _tag(CarController.to.car.generation.name),
  //         _tag(CarController.to.car.configuration.bodyType),
  //         _tag(
  //             "${CarController.to.car.generation.yearStart} - ${CarController.to.car.generation.yearStop ?? "н.в."}"),
  //         _tag(CarController
  //             .to.car.selectedModification.carSpecifications?.transmission),
  //         _tag(CarController
  //             .to.car.selectedModification.carSpecifications?.engineType),
  //         CarController.to.car.generation.isRestyle
  //             ? _tag("Рейстайлинг")
  //             : Container(),
  //       ],
  //     );

  Widget _tag(String? text) => text == null
      ? Container()
      : UnconstrainedBox(
          child: Container(
            height: 32.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: unactiveColor,
              borderRadius: BorderRadius.circular(20.h),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 11.w),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 13.fs,
                      fontWeight: FontWeight.w400,
                      color: blackColor),
                ),
              ),
            ),
          ),
        );

  String _formatModelNameWithBrand(Mark mark, Model model) {
    final name = model.name ?? "";
    final brand = mark.name;

    if (RegExp(r'\d').hasMatch(name)) {
      return "$brand $name";
    } else {
      return name;
    }
  }

  Widget _carTitle() {
    String brandName = CarController.to.car.mark.name ?? "";
    String modelName = CarController.to.car.model.name ?? "";
    int? year = CarController.to.car.generation.yearStart;

    return Obx(
      () => Container(
        margin: EdgeInsets.only(right: 25.0.w),
        child: Text(
          "$brandName $modelName ${year ?? ""}",
          style: TextStyle(
            fontSize: 25.fs,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color:
                AppThemeController.to.isDarkTheme ? Colors.white : primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _carSubTitle() {
    String subtitle = CarController.to.car.generation.name ?? "";
    if (subtitle.isEmpty) return Container();
    return Obx(
      () => Text(
        subtitle,
        style: TextStyle(
          fontSize: 20.fs,
          fontWeight: FontWeight.bold,
          color: AppThemeController.to.isDarkTheme ? paleColor : blackColor,
          fontFamily: "Inter",
        ),
      ),
    );
  }

  Widget _carImage() => Stack(
        children: [
          ImageContainer(
            imageData: ImageData.photo(
              id: CarController.to.car.configuration.id ?? "",
            ),
            borderRaduis: 0,
            height: 348.h,
            width: double.infinity,
          ),
          _appBarRow(),
        ],
      );

  Widget _appBarRow() => Container(
        margin: EdgeInsets.fromLTRB(25.w, 48.h, 25.w, 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _backIcon(),
            _favoriteAndCompareIcons(),
          ],
        ),
      );

  Widget _backIcon() => _iconSvg(backIcon, Get.back);

  Widget _favoriteAndCompareIcons() =>
      Row(children: [_addToCompIcon(), SizedBox(width: 15.w), _likeWidget()]);

  Widget _addToCompIcon() => Obx(
        () {
          CompareController controller = CompareController.to;

          Car car = CarController.to.car.copyWith();
          bool isCarCompared = controller.isCarCompared(car);

          return IconWidget(
            "assets/svg/comp.svg",
            "assets/svg/comp_active.svg",
            () => !isCarCompared
                ? controller.addToCompare(car)
                : controller.deleteFromCompare(car),
            condition: CompareController.to.isCarCompared(car),
          );
        },
      );

  Widget _likeWidget() => Obx(
        () {
          FavoriteController controller = FavoriteController.to;
          Car car = CarController.to.car.copyWith();
          bool isCarFavorite = controller.isCarFavorite(car);
          return IconWidget(
            "assets/svg/favorite.svg",
            "assets/svg/favorite_active.svg",
            () => isCarFavorite
                ? controller.removeFromFavorite(car)
                : controller.addToFavorite(car.copyWith()),
            condition: isCarFavorite,
          );
        },
      );

  Widget _iconSvg(String path, VoidCallback function,
          {bool condition = false}) =>
      GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              color: blackColor.withOpacity(0.3), shape: BoxShape.circle),
          height: 33.h,
          width: 33.h,
          child: Center(
            child: SvgPicture.asset(
              path,
            ),
          ),
        ),
      );
}

class IconWidget extends StatelessWidget {
  final String iconPath;
  final String activeIconPath;
  final VoidCallback function;
  final bool condition;
  final double size;

  const IconWidget(this.iconPath, this.activeIconPath, this.function,
      {super.key, this.condition = false, this.size = 33});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
            color: blackColor.withOpacity(0.3), shape: BoxShape.circle),
        height: size.h,
        width: size.h,
        child: Center(
          child: SvgPicture.asset(condition ? activeIconPath : iconPath),
        ),
      ),
    );
  }
}
