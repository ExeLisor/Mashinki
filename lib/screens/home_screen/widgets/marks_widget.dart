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
          child: _popularMarksList(),
        ),
      );

  Widget _marksWidgetTitle() => GestureDetector(
        onTap: _navigateToMarksScreen,
        child: Padding(
          padding: EdgeInsets.only(left: 25.0.w),
          child: Row(
            children: [
              GetBuilder<MarksController>(
                builder: (controller) => Text(
                  "Бренды",
                  style: TextStyle(
                      fontSize: 18.fs,
                      color: primaryColor,
                      fontWeight: FontWeight.w600),
                ),
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
        builder: (controller) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GetBuilder<MarksController>(
            builder: (controller) => Row(
              children: [
                //для того, чтобы при скролле виджет красиво выходил за границы экрана
                Container(
                  width: 25.w,
                ),
                ...List.generate(
                  controller.popularMarks.length,
                  (index) => _markTile(
                    controller.popularMarks[index],
                  ),
                ),
                _moreMarks()
              ],
            ),
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

  Widget _markTile(Mark mark) => _markContainer(
        child: GestureDetector(
          onTap: () => MarksController.to.goToModels(mark),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8.h),
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/marks/${mark.id}/logo",
                fit: BoxFit.contain,
              ),
            ),
          ),
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

  Widget _marksLoadingWidget() => SizedBox(
        height: _containerSize,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 25.h),
          children: List.generate(
            ((Get.width / (_containerSize + 12.h) + 1)).floor(),
            (int index) => ShimmerWidget(
              child: Container(
                margin: EdgeInsets.only(right: 12.h),
                width: _containerSize,
                height: _containerSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
      );
}
