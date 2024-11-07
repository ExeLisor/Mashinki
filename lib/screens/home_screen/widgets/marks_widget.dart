import 'package:autoverse/exports.dart';

const double containerSize = 58;
const double spacing = 25;

class MarksWidget extends GetView<MarksController> {
  const MarksWidget({super.key});

  void _navigateToMarksScreen() => Get.toNamed("/marks");

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
              Text("Бренды",
                  style: TextStyle(
                      fontSize: 16.fs,
                      color: primaryColor,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 13.w),
              SvgPicture.asset("assets/svg/arrow_right.svg"),
            ],
          ),
        ),
      );

  Widget _marks() => controller.popularMarks.isEmpty
      ? _marksLoadingWidget()
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.fromLTRB(spacing.w, 10.h, spacing.w, 20.w),
            child: Wrap(
              spacing: 25.w,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [..._popularMarks(), _moreMarks()],
            ),
          ),
        );

  List<Widget> _popularMarks() => List.generate(controller.popularMarks.length,
      (index) => _markContainer(child: _image(controller.popularMarks[index])));

  Widget _image(Mark mark) {
    return ImageContainer(
      imageData: ImageData.mark(id: mark.id ?? ""),
      loadingWidget: const MarkLoadingWidget(),
    );
  }

  Widget _markContainer({Widget? child}) => Container(
        width: containerSize.h,
        height: containerSize.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 15,
              offset: Offset(-1, 10),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 15,
              offset: Offset(1, 1),
              spreadRadius: 2,
            )
          ],
        ),
        child: child,
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

  Widget _marksLoadingWidget() => SizedBox(
        height: (containerSize + 10).h,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: spacing.h),
          children: List.generate(
            ((Get.width / (75 + 12) + 2)).floor(),
            (int index) => const MarkLoadingWidget(),
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
        margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
        width: containerSize.h,
        height: containerSize.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
