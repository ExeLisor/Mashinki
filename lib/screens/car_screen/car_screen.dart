import 'package:autoverse/exports.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

  static ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return GetBuilder<CarController>(
      initState: (state) => CarAppbarController.to.startListen(controller),
      builder: (carController) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xffEEEEEE),
        appBar: _appBar(),
        body: Obx(() => CarController.to.state.value == Status.success
            ? _carBody()
            : _loadingWidget()),
      ),
    );
  }

  Widget _carBody() => Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _carImage(),
                _carTitleWidget(),
                _carModifications(),
                _carDetails(),
              ],
            ),
          ),
          const CarsFloatBar(),
        ],
      );

  AppBar _appBar() => AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      );

  Widget _loadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _carDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _selectorWidget(),
          SpecsSelectorController.to.showOptions
              ? OptionsWidget()
              : CharacteristicsWidget()
        ],
      );

  Widget _carModifications() => const ModificationsWidget();

  Widget _selectorWidget() => Obx(
        () => Row(
          children: [
            _selectorTile(
                "Характеристики", SpecsSelectorController.to.changeToSpecs,
                isSelected: !SpecsSelectorController.to.showOptions),
            _selectorTile("Опции", SpecsSelectorController.to.changeToOptions,
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
              color: isSelected ? Colors.white : const Color(0xffE8E8E8),
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
          margin: EdgeInsets.only(top: 22.h, bottom: 44.h),
          padding: EdgeInsets.only(left: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carTitle(),
              SizedBox(
                height: 14.h,
              ),
              _tagsWidget()
            ],
          ),
        ),
      );

  Widget _tagsWidget() => Wrap(
        runSpacing: 6.h,
        children: [
          _tag(CarController.to.configuration.bodyType ?? ""),
          _tag(
              "${CarController.to.generation.yearStart} - ${CarController.to.generation.yearStop ?? "н.в."}"),
          _tag("2.0 CVT"),
          _tag("вариатор"),
          CarController.to.generation.isRestyle
              ? _tag("Рейстайлинг")
              : Container(),
        ],
      );

  Widget _tag(String text) => UnconstrainedBox(
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
    String brandName = CarController.to.mark.name ?? "";
    String modelName = CarController.to.model.name ?? "";
    String generationName = CarController.to.generation.name ?? "";
    return Text(
      "$brandName $modelName $generationName",
      style: TextStyle(
          fontSize: 25.fs, fontWeight: FontWeight.bold, color: primaryColor),
    );
  }

  Widget _carImage() => Stack(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: "$baseUrl/image/${CarController.to.configuration.id}",
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

  Widget _backIcon() => _iconWidget(Icons.arrow_back_ios_new_rounded, Get.back);

  Widget _iconBlock() => Wrap(
        children: [
          _addToCompIcon(),
          SizedBox(
            width: 15.w,
          ),
          _likeWidget()
        ],
      );

  Widget _addToCompIcon() => _iconWidget(Icons.copy, () {});

  Widget _likeWidget() => _iconWidget(Icons.heart_broken, () {});

  Widget _iconWidget(IconData icon, VoidCallback function) => GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3), shape: BoxShape.circle),
          height: 45.h,
          width: 45.h,
          child: Center(
            child: Icon(icon, color: Colors.white),
          ),
        ),
      );
}
