import 'package:autoverse/exports.dart';

class MarksWidget extends StatelessWidget {
  const MarksWidget({super.key});

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

  Widget _marksView() =>
      HomeShimmerWidget(shimmer: _marksLoadingWidget(), child: _marksList());

  Widget _marksWidgetTitle() => Row(
        children: [
          GetBuilder<MarksController>(
            builder: (controller) => Text(
              "Бренды (${controller.marks.length})",
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
      );

  Widget _marksList() => SizedBox(
        height: 75.h,
        child: GetBuilder<MarksController>(
          builder: (controller) => ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.marks.length,
            itemBuilder: (context, index) => Container(),
          ),
        ),
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

  Widget _markTile(String imageUrl) => Container(
        width: 75.h,
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
        child: Container(
          padding: EdgeInsets.all(8.h),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      );
}
