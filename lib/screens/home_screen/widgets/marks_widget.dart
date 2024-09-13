import 'package:autoverse/exports.dart';

const double containerSize = 75;
const double spacing = 25;

class MarksWidget extends StatelessWidget {
  const MarksWidget({super.key});

  void _navigateToMarksScreen() => Get.toNamed("/marks");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _marksWidgetTitle(),
        SizedBox(height: 15.h),
        _marksView(),
      ],
    );
  }

  Widget _marksView() => Obx(
        () => HomeShimmerWidget(
          shimmer: _marksLoadingWidget(),
          successCondition:
              MarksController.to.state.value == MarksState.success,
          child: buildPopularMarksList(),
        ),
      );

  Widget _marksWidgetTitle() => GestureDetector(
        onTap: _navigateToMarksScreen,
        child: Padding(
          padding: EdgeInsets.only(left: spacing.w),
          child: Row(
            children: [
              Text("Бренды",
                  style: TextStyle(
                      fontSize: 18.fs,
                      color: primaryColor,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 13.w),
              const Icon(Icons.arrow_forward_ios_rounded, color: primaryColor),
            ],
          ),
        ),
      );

  Widget _popularMarksList() => GetBuilder<MarksController>(
        builder: (controller) => Row(
          children: [
            //для того, чтобы при скролле виджет красиво выходил за границы экрана
            Container(width: spacing.w),
            buildPopularMarksList(),
            _moreMarks()
          ],
        ),
      );

  Widget buildPopularMarksList() => GetBuilder<MarksController>(
        builder: (controller) => SizedBox(
          height: containerSize.h + 10.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.popularMarks.length,
            itemBuilder: (context, index) {
              Mark mark = controller.popularMarks[index];
              return Row(
                children: [
                  index == 0
                      ? SizedBox(
                          width: spacing.w,
                        )
                      : Container(),
                  _image(mark),
                  index == controller.popularMarks.length - 1
                      ? _moreMarks()
                      : Container()
                ],
              );
            },
          ),
        ),
      );

  Widget _image(Mark mark) {
    return ImageContainer(
      imageData: ImageData.mark(id: mark.id ?? ""),
      function: () => ModelsController.to.openModelsPage(mark),
      margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
      padding: const EdgeInsets.all(5),
      loadingWidget: const MarkLoadingWidget(),
    );
  }

  Widget _markContainer({Widget? child}) => Container(
        width: containerSize.h,
        height: containerSize.h,
        margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5.h) // changes position of shadow
                  )
            ]),
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
            ((Get.width / (75 + 12) + 1)).floor(),
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
}

// class MarkLogo extends StatelessWidget {
//   const MarkLogo({super.key, required this.mark});

//   final Mark mark;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//       future: FirebaseController.to.loadImage("logos", mark.id, type: "png"),
//       builder: (context, snapshot) {
//         return snapshot.data != null
//             ? _logo(snapshot.data!)
//             : const MarkLoadingWidget();
//       },
//     );
//   }

//   Widget _logo(String url) => GestureDetector(
//         onTap: () => ModelsController.to.openModelsPage(mark),
//         child: _markContainer(
//           child: CachedNetworkImage(
//             imageUrl: url,
//             fit: BoxFit.contain,
//           ),
//         ),
//       );

//   Widget _markContainer({Widget? child}) => Container(
//         width: containerSize.h,
//         height: containerSize.h,
//         margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.15),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: Offset(0, 5.h), // changes position of shadow
//             ),
//           ],
//         ),
//         child: child,
//       );
// }

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
