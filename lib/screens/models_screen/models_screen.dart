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
            SizedBox(
              height: 20.h,
            ),
            CarsSearchBar(
              controller: ModelsSearchController.to,
              filterAction: _showModelFilters,
              searchIconColor: primaryColor,
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
        () => ListView.builder(
          itemCount: models.length,
          padding: EdgeInsets.only(bottom: 25.h),
          itemBuilder: (context, index) => Column(
            children: [
              Text(
                models[index].name ?? "",
                style: TextStyle(fontSize: 24.fs, fontWeight: FontWeight.bold),
              ),
              _generations(models[index]),
            ],
          ),
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
          child: Padding(
            padding: EdgeInsets.only(left: 15.0.w),
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                generation.configurations?.length ?? 0,
                (index) {
                  Configuration configuration =
                      generation.configurations![index];

                  return ModelTile(
                    model: model,
                    generation: generation,
                    configuration: configuration,
                  );
                },
              ),
            ),
          ),
        ),
        (generation.configurations?.length ?? 0) == 1
            ? Container()
            : SmoothPageIndicator(
                controller: pageController,
                count: generation.configurations?.length ?? 0,
                effect: WormEffect(
                    dotColor: unactiveColor,
                    activeDotColor: primaryColor,
                    dotHeight: 9.h,
                    dotWidth: 9.h),
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
