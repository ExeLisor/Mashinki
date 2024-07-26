import 'package:autoverse/exports.dart';

class MarksWidget extends StatelessWidget {
  const MarksWidget({super.key});

  void _navigateToBrandScreen() =>
      Get.to(() => const MarksScreen(), transition: Transition.cupertino);

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

  Widget _marksView() => HomeShimmerWidget(
      shimmer: _marksLoadingWidget(), child: _popularMarksList());

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
        height: 75.h,
        child: GetBuilder<MarksController>(
          builder: (controller) => controller.popularMarks.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.popularMarks.length + 1,
                  itemBuilder: (context, index) =>
                      index == controller.popularMarks.length
                          ? _moreMarks()
                          : _markTile(controller.popularMarks[index]),
                )
              : Container(),
        ),
      );

  Widget _moreMarks() => GestureDetector(
        onTap: _navigateToBrandScreen,
        child: Container(
            width: 75.h,
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

  Widget _marksLoadingWidget() => ShimmerWidget(
        child: SizedBox(
          width: Get.width,
          child: Container(
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
          ),
        ),
      );

  Widget _markTile(Mark mark) => Container(
        width: 75.h,
        margin: EdgeInsets.only(right: 12.h),
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
