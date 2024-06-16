import 'package:mashinki/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.h,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: _body(),
      ),
    );
  }

  Widget _body() => Column(
        children: [
          const TopBar(title: "Каталог"),
          SizedBox(
            height: 25.h,
          ),
          const CarsSearchBar(),
          SizedBox(
            height: 20.h,
          ),
          const WeeklySelectionWidget(),
          SizedBox(
            height: 20.h,
          ),
          const HomeScreenAdsWidget()
        ],
      );
}
