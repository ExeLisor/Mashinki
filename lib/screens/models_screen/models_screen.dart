import 'package:autoverse/exports.dart';

class ModelsScreen extends StatelessWidget {
  ModelsScreen({super.key});

  final containerHeight = 125.h;
  final containerWidth = 362.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopBar(title: 'Модельный ряд'),
          _brandsTitle(),
          _modelsView(),
        ],
      ),
    );
  }

  Widget _brandsTitle() => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Center(
          child: Obx(
            () => Text(
              ModelsController.to.markId.value,
              style: TextStyle(
                  fontSize: 20.fs,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );

  Widget _modelsList() => Obx(
        () => Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                _modelTile(ModelsController.to.models[index]),
            itemCount: ModelsController.to.models.length,
          ),
        ),
      );

  //GRID
  // Widget _modelsView() => Obx(
  //   () => Expanded(
  //     child: GridView.builder(
  //       padding: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 20.h),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2, // Две колонки
  //         crossAxisSpacing:
  //             18.w, // Расстояние между элементами по горизонтали
  //         mainAxisSpacing: 15.h, // Расстояние между элементами по вертикали
  //         childAspectRatio: 172.w / 62.h,
  //       ),
  //       itemCount: ModelsController.to.models.length,
  //       itemBuilder: (context, index) =>
  //           _modelTile(ModelsController.to.models[index]),
  //     ),
  //   ),
  // );

  Widget _modelTile(Model model) => Container(
        height: containerHeight,
        width: containerWidth,
        margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _modelImage(""),
            _modelName(model.name ?? ""),
          ],
        ),
      );

  Widget _modelImage(String url) => SizedBox(
        height: containerHeight,
        width: containerWidth / 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: CachedNetworkImage(
            imageUrl:
                "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?cs=srgb&dl=pexels-mikebirdy-170811.jpg&fm=jpg",
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _modelName(String name) => Expanded(
        flex: 1,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(25.h),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 18.fs,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

  Widget _modelsView() => Expanded(
        child: Obx(
          () => HomeShimmerWidget(
            shimmer: _modelsLoadingWidget(),
            successCondition: ModelsController.to.models.isNotEmpty,
            child: _modelsList(),
          ),
        ),
      );

  Widget _modelsLoadingWidget() => Expanded(
        child: ListView.builder(
          itemCount: ((Get.height / (containerHeight + 12.h))).floor(),
          shrinkWrap: true,
          itemBuilder: (context, index) => ShimmerWidget(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      );
}
