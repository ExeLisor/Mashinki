import 'package:autoverse/exports.dart';

const double containerSize = 58;
const double spacing = 25;

void _navigateToMarksScreen() {
  MarksSearchController.to.clearSearch();
  Get.toNamed("/marks");
}

class MarksWidget extends GetView<MarksController> {
  const MarksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_title(), SizedBox(height: 10.h), _marks()],
    );
  }

  Widget _title() => GestureDetector(
        onTap: _navigateToMarksScreen,
        child: Padding(
          padding: EdgeInsets.only(left: spacing.w),
          child: Row(
            children: [
              Obx(() => Text('marks'.tr,
                  style: TextStyle(
                      fontSize: 16.fs,
                      fontFamily: "Inter",
                      color: AppThemeController.to.isDarkTheme
                          ? Colors.white
                          : primaryColor,
                      fontWeight: FontWeight.w600))),
              SizedBox(width: 13.w),
              Obx(() => SvgPicture.asset(
                    "assets/svg/arrow_right.svg",
                    color: AppThemeController.to.isDarkTheme
                        ? Colors.white
                        : primaryColor,
                  )),
            ],
          ),
        ),
      );

  Widget _marks() => Obx(
        () => controller.state.value == MarksState.loading
            ? _marksLoadingWidget()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(spacing.w, 10.h, spacing.w, 20.w),
                  child: Wrap(
                    spacing: 25.w,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [..._popularMarks(), _moreMarks()],
                  ),
                ),
              ),
      );

  List<Widget> _popularMarks() => List.generate(controller.popularMarks.length,
      (index) => _markContainer(child: _image(controller.popularMarks[index])));

  Widget _image(Mark mark) {
    return ImageContainer(
      width: containerSize.h,
      height: containerSize.h,
      imageData: ImageData.mark(id: mark.id ?? ""),
      function: () => ModelsController.to.openModelsPage(mark),
      loadingWidget: const MarkLoadingWidget(),
    );
  }

  Widget _markContainer({Widget? child}) => Obx(
        () => Container(
          clipBehavior: Clip.antiAlias,
          width: containerSize.h,
          height: containerSize.h,
          decoration: BoxDecoration(
            color: AppThemeController.to.isDarkTheme
                ? const Color(0xff292929)
                : whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: boxShadowColor,
                blurRadius: 15,
                offset: Offset(-1, 10),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: boxShadowColor,
                blurRadius: 15,
                offset: Offset(1, 1),
                spreadRadius: 2,
              )
            ],
          ),
          child: child,
        ),
      );

  Widget _moreMarks() => GestureDetector(
        onTap: _navigateToMarksScreen,
        child: _markContainer(
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              size: 40.h,
              color: primaryColor,
            ),
          ),
        ),
      );

  Widget _marksLoadingWidget() => Padding(
        padding: EdgeInsets.fromLTRB(spacing.w, 10.h, spacing.w, 10.h),
        child: SizedBox(
          height: (containerSize + 10).h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Wrap(
              spacing: 25.w,
              children: List.generate(
                ((Get.width / (75 + 12) + 2)).floor(),
                (int index) => const MarkLoadingWidget(),
              ),
            ),
          ),
        ),
      );
}

class ImageData {
  final String path;
  final String id;
  final String type;

  const ImageData.mark(
      {this.path = "logos", required this.id, this.type = "png"});

  const ImageData.photo(
      {this.path = "photos", required this.id, this.type = "jpg"});
}

class MarkLoadingWidget extends StatelessWidget {
  const MarkLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        width: containerSize.h - 0.5,
        height: containerSize.h - 0.5,
        decoration: BoxDecoration(
          color: AppThemeController.to.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
