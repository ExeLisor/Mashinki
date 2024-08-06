import 'package:autoverse/exports.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //alpabet gets smaller if resize set to true
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
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

  Widget _marksScreenBody() => GetBuilder<MarksSearchController>(
        builder: (controller) => controller.query.isNotEmpty
            ? _searchingResults(controller.results)
            : const AlphabetWidget(),

        // : _recentSearch(),
      );

  Widget _searchingResults(List<Mark> result) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: MarksGrid(brands: result),
          ),
        ),
      );

  Widget _recentSearch() => ListView.builder(
        shrinkWrap: true,
        itemCount: MarksSearchController.to.recentSearch.length,
        itemBuilder: (context, index) =>
            _recentSearchTile(MarksSearchController.to.recentSearch[index]),
      );

  Widget _recentSearchTile(String request) => GestureDetector(
        onTap: () => MarksSearchController.to.startSearchFromRecent(request),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _recentTitle(request),
                    SvgPicture.asset(
                      crossIcon,
                      color: primaryColor,
                      height: 20.h,
                      width: 20.h,
                    )
                  ],
                ),
                const Divider(
                  color: Color(0xff7974FF),
                )
              ],
            ),
          ),
        ),
      );
  Widget _recentTitle(String request) => Row(
        children: [
          SvgPicture.asset(
            recentIcon,
            color: primaryColor,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(
            width: 17.h,
          ),
          Text(
            request,
            style: TextStyle(
                fontSize: 16.fs,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ],
      );
}
