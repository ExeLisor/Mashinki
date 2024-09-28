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
      children: List.generate(model.generations.length ?? 0,
          (index) => _configuration(model, model.generations[index])));

  Widget _configuration(Model model, Generation generation) {
    PageController pageController = PageController(viewportFraction: 0.95);
    return Column(
      children: [
        Container(
          height: 250.h,
          padding: EdgeInsets.only(left: 20.0.w),
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              generation.configurations.length,
              (index) {
                Configuration configuration = generation.configurations[index];

                return Padding(
                  padding: EdgeInsets.only(right: 15.0.w),
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
        (generation.configurations.length) == 1
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
                  count: generation.configurations.length,
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

class ModelsList extends StatefulWidget {
  const ModelsList({super.key});

  @override
  State<ModelsList> createState() => _ModelsListState();
}

class _ModelsListState extends State<ModelsList> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModelsController.to.state.value == Status.success
        ? _modelsList()
        : _loadingWidget());
  }

  Widget _modelsList() {
    return ListView.builder(
      itemCount: ModelsController.to.models.length,
      padding: EdgeInsets.all(25.w),
      itemBuilder: (context, index) => ModelWidget(
        model: ModelsController.to.models[index],
      ),
    );
  }

  Widget _loadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );
}

class ModelWidget extends StatelessWidget {
  const ModelWidget({super.key, required this.model});
  final Model model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_model(), ..._generations()],
    );
  }

  Widget _model() => Text(
        "${ModelsController.to.mark.name} ${model.name ?? ""}",
        style: TextStyle(
          color: primaryColor,
          fontSize: 20.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      );

  List<Widget> _generations() => List.generate(model.generations.length ?? 0,
      (index) => GenerationWidget(generation: model.generations[index]));
}

class GenerationWidget extends StatelessWidget {
  const GenerationWidget({super.key, required this.generation});
  final Generation generation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _textContainer(generation.name ?? ""),
        _configurations(),
      ],
    );
  }

  Widget _textContainer(String text,
          {bool setMinWidth = true,
          double fontSize = 18,
          FontWeight fontWeight = FontWeight.w600}) =>
      text.isEmpty
          ? Container()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 7.w),
              constraints: BoxConstraints(maxWidth: 180.w, minHeight: 38.h),
              margin: EdgeInsets.all(15.h),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize.fs,
                  fontFamily: 'Inter',
                  fontWeight: fontWeight,
                ),
              ),
            );

  Widget _configurations() =>
      ConfigurationsWidget(configurations: generation.configurations);
}

class ConfigurationsWidget extends StatelessWidget {
  const ConfigurationsWidget({super.key, required this.configurations});

  final List<Configuration> configurations;

  final containerHeight = 250;
  final containerWidth = 362;

  @override
  Widget build(BuildContext context) {
    return _configurationsList();
  }

  Widget _configurationsList() => SizedBox(
        height: 250.h,
        child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: configurations.isEmpty ? null : configurations.length,
            itemBuilder: (context, index) {
              return configurations.isEmpty
                  ? _loadingWidget()
                  : _configuraiton(configurations[index]);
            }),
      );

  Widget _configuraiton(Configuration configuration) => configuration.isLoaded
      ? _configurationImage(configuration.id ?? "")
      : _loadingWidget();

  Widget _loadingWidget() => ShimmerWidget(
        child: Container(
          height: containerHeight.h,
          width: containerWidth.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
        ),
      );

  Widget _configurationImage(String id) =>
      ImageContainer(imageData: ImageData.photo(id: id));
}
