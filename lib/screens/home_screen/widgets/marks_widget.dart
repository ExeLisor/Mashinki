import 'package:autoverse/exports.dart';

class MarksWidget extends StatelessWidget {
  MarksWidget({super.key});

  void _navigateToMarksScreen() => Get.toNamed("/marks");

  final double _containerSize = 75.h;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _marksWidgetTitle(),
        SizedBox(
          height: 15.h,
        ),
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
          padding: EdgeInsets.only(left: 25.0.w),
          child: Row(
            children: [
              Text(
                "Бренды",
                style: TextStyle(
                    fontSize: 18.fs,
                    color: primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 13.w,
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
              ),
            ],
          ),
        ),
      );

  Widget _popularMarksList() => GetBuilder<MarksController>(
        builder: (controller) => Row(
          children: [
            //для того, чтобы при скролле виджет красиво выходил за границы экрана
            Container(
              width: 25.w,
            ),
            buildPopularMarksList(),
            _moreMarks()
          ],
        ),
      );

  Widget buildPopularMarksList() => GetBuilder<MarksController>(
        builder: (controller) => SizedBox(
          height: _containerSize + 10.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.popularMarks.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                    ),
                    MarkLogo(mark: controller.popularMarks[index])
                  ],
                );
              }
              if (index == controller.popularMarks.length) {
                return Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                    ),
                    _moreMarks()
                  ],
                );
              }
              return MarkLogo(mark: controller.popularMarks[index]);
            },
          ),
        ),
      );

  Widget _markContainer({Widget? child}) => Container(
        width: _containerSize,
        height: _containerSize,
        margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5.h), // changes position of shadow
            ),
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
        height: 85.h,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 25.h),
          children: List.generate(
            ((Get.width / (75 + 12) + 1)).floor(),
            (int index) => const MarkLoadingWidget(),
          ),
        ),
      );
}

class MarkLogo extends StatelessWidget {
  const MarkLogo({super.key, required this.mark});

  final Mark mark;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: FirebaseController.to.loadImage("logos", mark.id, type: "png"),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? _logo(snapshot.data!)
            : const MarkLoadingWidget();
      },
    );
  }

  Widget _logo(String url) => GestureDetector(
        onTap: () => ModelsController.to.openModelsPage(mark),
        child: _markContainer(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
          ),
        ),
      );

  Widget _markContainer({Widget? child}) => Container(
        width: 75.h,
        height: 75.h,
        margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5.h), // changes position of shadow
            ),
          ],
        ),
        child: child,
      );
}

class MarkLoadingWidget extends StatelessWidget {
  const MarkLoadingWidget({super.key});

  final double _containerSize = 75;

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
        width: _containerSize.h,
        height: _containerSize.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
