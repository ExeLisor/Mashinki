import 'package:autoverse/exports.dart';

class MarksWidget extends StatelessWidget {
  MarksWidget({super.key});

  void _navigateToBrandScreen() =>
      Get.to(() => const MarksScreen(), transition: Transition.cupertino);

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
        _marksView()
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
        onTap: _navigateToBrandScreen,
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
      );

  Widget _popularMarksList() => SizedBox(
        height: _containerSize,
        child: GetBuilder<MarksController>(
          builder: (controller) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.popularMarks.length + 1,
            itemBuilder: (context, index) =>
                index == controller.popularMarks.length
                    ? _moreMarks()
                    : _markTile(controller.popularMarks[index]),
          ),
        ),
      );

  Widget _moreMarks() => GestureDetector(
        onTap: _navigateToBrandScreen,
        child: Container(
            width: _containerSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Center(
              child: Icon(
                Icons.arrow_forward,
                size: 40.h,
                color: primaryColor,
              ),
            )),
      );

  Widget _marksLoadingWidget() => SizedBox(
        height: _containerSize,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            //screen width is divided by the tile width and his margin then plus one for making it more similar to the marks widget
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

  Widget _markTile(Mark mark) => Container(
        width: _containerSize,
        margin: EdgeInsets.only(
          right: 12.h,
        ),
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
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8.h),
            child: CachedNetworkImage(
              imageUrl: "$baseUrl/marks/${mark.id}/logo",
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
}
