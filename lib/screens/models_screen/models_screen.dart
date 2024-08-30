import 'package:autoverse/exports.dart';

class ModelsScreen extends StatelessWidget {
  ModelsScreen({super.key});

  final containerHeight = 250.h;
  final containerWidth = 362.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
      body: Obx(() => ModelsController.to.state.value == Status.success
          ? _modelsScreenBody()
          : _loadingWidget()),
    );
  }

  Widget _loadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );
  Widget _modelsScreenBody() => Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(
              title: "Модельный ряд",
              subtitle: ModelsController.to.mark.name ?? "",
            ),
            ModelsSearchController.to.query.isNotEmpty
                ? _searchingResults()
                : _modelsListView()
          ],
        ),
      );
  void _showModelFilters() => Get.bottomSheet(
        isScrollControlled: true,
        const ModelsFiltersWidget(),
      );

  Widget _searchingResults() => _models(ModelsSearchController.to.results);

  Widget _modelsListView() => Obx(() => FiltersController.to.isFiltesApplied
      ? _models(FiltersController.to.models)
      : _models(ModelsController.to.models));

  Widget _models(List<Model> models) {
    return Expanded(
      child: Obx(
        () => ListView(
          padding: EdgeInsets.only(bottom: 25.h),
          children: [
            SizedBox(
              height: 20.h,
            ),
            CarsSearchBar(
              controller: ModelsSearchController.to,
              filterAction: _showModelFilters,
              searchIconColor: primaryColor,
            ),
            ...List.generate(
              models.length,
              (index) => Column(
                children: [
                  Text(
                    "${ModelsController.to.mark.name} ${models[index].name ?? ""}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20.fs,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  _generations(models[index]),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filtredModels() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.only(bottom: 25.h),
          itemCount: ModelsSelectorController.to.selectedModels.length,
          itemBuilder: (context, index) => Column(
            children: [
              Text(
                ModelsSelectorController.to.selectedModels[index].name ?? "",
                style: TextStyle(fontSize: 24.fs, fontWeight: FontWeight.bold),
              ),
              _generations(ModelsSelectorController.to.selectedModels[index]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generations(Model model) => Column(
      children: List.generate(model.generations?.length ?? 0,
          (index) => _configuration(model, model.generations![index])));

  Widget _configuration(Model model, Generation generation) {
    PageController pageController = PageController(viewportFraction: 0.95);
    return Column(
      children: [
        SizedBox(
          height: 250.h,
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              generation.configurations?.length ?? 0,
              (index) {
                Configuration configuration = generation.configurations![index];

                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 15.0.w : 0),
                  child: ModelTile(
                    model: model,
                    generation: generation,
                    configuration: configuration,
                  ),
                );
              },
            ),
          ),
        ),
        (generation.configurations?.length ?? 0) == 1
            ? Container()
            : Container(
                height: 12.h,
                padding: EdgeInsets.all(3.w),
                decoration: ShapeDecoration(
                  color: const Color(0xFFA19EFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: generation.configurations?.length ?? 0,
                  effect: WormEffect(
                      dotColor: Colors.white,
                      activeDotColor: primaryColor,
                      dotHeight: 6.h,
                      dotWidth: 6.h,
                      spacing: 4.w),
                ),
              )
      ],
    );
  }

  Widget _brandsTitle() => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Center(
          child: Obx(
            () => Text(
              ModelsController.to.mark.name ?? "",
              style: TextStyle(
                  fontSize: 20.fs,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}
