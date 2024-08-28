import 'package:autoverse/exports.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffEEEEEE),
      appBar: _appBar(),
      body: Obx(() => CarController.to.state.value == Status.success
          ? _carBody()
          : _loadingWidget()),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
    );
  }

  Widget _carBody() {
    ScrollController controller = ScrollController();
    return GetBuilder<CarController>(
      initState: (state) => CarAppbarController.to.startListen(controller),
      builder: (carController) => Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _carImage(),
                _carTitleWidget(),
                _carDetails(),
              ],
            ),
          ),
          FloatBar(
            controller: CarAppbarController.to,
            child: const CarsFloatBar(),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() => AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      );

  Widget _loadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _carDetails() => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 45.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selectorWidget(),
                Obx(() => SpecsSelectorController.to.showOptions
                    ? OptionsWidget()
                    : const CharacteristicsWidget())
              ],
            ),
          ),
          _carModifications(),
        ],
      );

  Widget _carModifications() => const ModificationsWidget();

  Widget _selectorWidget() => Obx(
        () => Row(
          children: [
            _selectorTile(
                "Характеристики", SpecsSelectorController.to.changeToSpecs,
                isSelected: !SpecsSelectorController.to.showOptions),
            _selectorTile(
                "Комплектация", SpecsSelectorController.to.changeToOptions,
                isSelected: SpecsSelectorController.to.showOptions)
          ],
        ),
      );

  Widget _selectorTile(String text, VoidCallback func,
          {bool isSelected = true}) =>
      GestureDetector(
        onTap: func,
        child: Container(
          height: 46.h,
          width: Get.width / 2,
          decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xffE2E2E2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.h))),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18.fs,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? primaryColor : const Color(0xff7974FF)),
            ),
          ),
        ),
      );

  Widget _carTitleWidget() => Container(
        width: Get.width,
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.h))),
        child: Container(
          margin: EdgeInsets.only(top: 22.h, bottom: 28.h),
          padding: EdgeInsets.only(left: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carTitle(),
              _carSubTitle(),
              SizedBox(
                height: 25.h,
              ),
              _carDescription()
            ],
          ),
        ),
      );

  Widget _carDescription() => Container(
        margin: EdgeInsets.only(right: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Описание",
              style: TextStyle(
                color: const Color(0xFF4038FF),
                fontSize: 18.fs,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              CarController.to.car.getDescription(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.fs,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
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
              color: const Color(0xffF3F3F3),
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
                      color: Colors.black),
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

    return Container(
      margin: EdgeInsets.only(right: 25.0.w),
      child: Text(
        "$brandName $modelName ${year ?? ""}",
        style: TextStyle(
            fontSize: 25.fs, fontWeight: FontWeight.bold, color: primaryColor),
      ),
    );
  }

  Widget _carSubTitle() {
    String subtitle = CarController.to.car.generation.name ?? "";
    if (subtitle.isEmpty) return Container();
    return Text(
      subtitle,
      style: TextStyle(
          fontSize: 20.fs, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _carImage() => Stack(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl:
                  "$baseUrl/image/${CarController.to.car.configuration.id}",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          _appBarRow(),
        ],
      );

  Widget _appBarRow() => Container(
        margin: EdgeInsets.fromLTRB(15.w, 45.h, 25.w, 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _backIcon(),
            _iconBlock(),
          ],
        ),
      );

  Widget _backIcon() => _iconSvg(backIcon, Get.back);

  Widget _iconBlock() => Wrap(
        children: [
          _addToCompIcon(),
          SizedBox(
            width: 15.w,
          ),
          _likeWidget()
        ],
      );

  Widget _addToCompIcon() => Obx(
        () {
          CompareController controller = CompareController.to;

          Car car = CarController.to.car.copyWith();
          bool isCarCompared = controller.isCarCompared(car);

          return _iconWidget(
            Icons.copy,
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
          return _iconSvg(
            isCarFavorite ? activeFavoriteIcon : favoriteIcon,
            () => isCarFavorite
                ? controller.removeFromFavorite(car)
                : controller.addToFavorite(car),
          );
        },
      );

  Widget _iconWidget(IconData icon, VoidCallback function,
          {bool condition = false}) =>
      GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              color: condition ? primaryColor : Colors.black.withOpacity(0.3),
              shape: BoxShape.circle),
          height: 45.h,
          width: 45.h,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget _iconSvg(String path, VoidCallback function,
          {bool condition = false}) =>
      GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3), shape: BoxShape.circle),
          height: 45.h,
          width: 45.h,
          child: Center(
            child: SvgPicture.asset(
              path,
            ),
          ),
        ),
      );
}
