import 'package:autoverse/exports.dart';

class ModelsScreen extends StatelessWidget {
  ModelsScreen({super.key});

  final containerHeight = 250.h;
  final containerWidth = 362.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Obx(
        () => ModelsController.to.state.value == Status.success
            ? _modelsScreenBody()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _modelsScreenBody() => Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: ModelsController.to.mark.name ?? ""),
            CarsSearchBar(
              controller: ModelsSearchController.to,
              filterAction: _showModelFilters,
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

  Widget _modelsListView() =>
      Obx(() => ModelsSelectorController.to.selectedModels.isEmpty
          ? _models(ModelsController.to.models)
          : _filtredModels());

  Widget _models(List<Model> models) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: models.length,
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

  Widget _configuration(Model model, Generation generation) => Column(
        children: [
          generation.name == null || generation.name!.isEmpty
              ? Container()
              : Text(
                  generation.name ?? "",
                  style:
                      TextStyle(fontSize: 20.fs, fontWeight: FontWeight.w500),
                ),
          SizedBox(
            height: 250.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                generation.configurations?.length ?? 0,
                (index) {
                  Configuration configuration =
                      generation.configurations![index];
                  bool isSingle = generation.configurations?.length == 1;
                  return _configurationTile(model, generation, configuration,
                      isSingle: isSingle);
                },
              ),
            ),
          )
        ],
      );

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

  Widget _modelTile(Model model) => GestureDetector(
        child: Container(
          height: containerHeight,
          width: containerWidth,
          margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
          child: Stack(
            children: [
              _modelImage(ModelsController.to.getGenerationImage(model)),
              _modelDetails(model)
            ],
          ),
        ),
      );

  Widget _configurationTile(
          Model model, Generation generation, Configuration configuration,
          {bool isSingle = true}) =>
      GestureDetector(
        onTap: () => Get.toNamed(
          "/models/${configuration.id}",
          arguments: {
            "mark": ModelsController.to.mark,
            "model": model,
            "generation": generation,
            "configuration": configuration,
          },
        ),
        child: Container(
          height: containerHeight,
          width: isSingle ? containerWidth : containerWidth - 30.w,
          margin: EdgeInsets.fromLTRB(25.w, 15.h, 10.w, 15.h),
          child: Stack(
            children: [
              _modelImage(configuration.id ?? ""),
              _configurationText(configuration)
            ],
          ),
        ),
      );

  Widget _configurationText(Configuration configuration) => Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.all(14.h),
          width: 120.w,
          height: 32.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.h),
            ),
          ),
          child: Center(
            child: Text(
              configuration.configurationName ?? "",
              style: TextStyle(
                  fontSize: 20.fs,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

  Widget _modelImage(String url) => SizedBox(
        height: containerHeight,
        width: containerWidth,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: CachedNetworkImage(
            imageUrl: "$baseUrl/image/$url",
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _modelDetails(Model model) => Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.all(14.h),
          width: 298.w,
          height: 52.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: _modelName(model),
        ),
      );

  String _formatModelNameWithBrand(Mark mark, Model model) {
    final name = model.name ?? "";
    final brand = mark.name;

    if (RegExp(r'\d').hasMatch(name)) {
      return "$brand $name";
    } else {
      return name;
    }
  }

  Widget _modelName(Model model) => Text(
        _formatModelNameWithBrand(ModelsController.to.mark, model),
        style: TextStyle(
            fontSize: 20.fs, fontWeight: FontWeight.w500, color: Colors.black),
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );

  Widget _modelsView() => Obx(
        () => ModelsController.to.state.value == Status.success
            ? _modelsList()
            : _modelsLoadingWidget(),
      );

  Widget _modelsLoadingWidget() => Expanded(
        child: ListView.builder(
            itemCount: ((Get.height / (containerHeight + 12.h))).floor(),
            shrinkWrap: true,
            itemBuilder: (context, index) => _loadingModel()),
      );

  Widget _loadingModel() => ShimmerWidget(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
}
