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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CarController.to.debug();
        },
      ),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => CarController.to.state.value == Status.success
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    _carImage(),
                    _carTitleWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    _carDetails(),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _carDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_selectorWidget(), CharacteristicsWidget()],
      );

  Widget _selectorWidget() => Row(
        children: [
          _selectorTile("Характеристики"),
          _selectorTile("Опции", isSelected: false)
        ],
      );

  Widget _selectorTile(String text, {bool isSelected = true}) => Container(
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
      );

  Widget _carTitleWidget() => Container(
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

  Widget _tagsWidget() => Column(
        children: [
          Row(
            children: [
              _tag("IX (XV80) China Market"),
              _tag("Седан"),
              _tag("2023 — н.в."),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            children: [
              _tag("Комплектация Deluxe"),
              _tag("2.0 CVT"),
              _tag("вариатор"),
            ],
          ),
        ],
      );

  Widget _tag(String text) => Container(
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
          SizedBox(
            height: 412.h,
            width: Get.width,
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/image/${CarController.to.configuration.id}",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
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
              color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
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
}
