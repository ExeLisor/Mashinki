import 'package:autoverse/exports.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //alpabet gets smaller if resize set to true
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopBar(title: 'Бренды'),
          const CarsSearchBar(
            isActiveButton: false,
          ),
          _marksScreenBody()
        ],
      ),
    );
  }

  AppBar _appBar() => AppBar(
        toolbarHeight: 0.h,
      );

  Widget _marksScreenBody() => GetBuilder<MarksSearchController>(
        builder: (controller) => controller.query.isNotEmpty
            ? _searchingResults(controller.results)
            : const AlphabetWidget(),
      );

  Widget _searchingResults(List<Mark> result) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: BrandGrid(brands: result),
          ),
        ),
      );
}
