import 'package:autoverse/exports.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _body(),
      ),
    );
  }

  PreferredSize _topBar() => PreferredSize(
        preferredSize: Size.fromHeight(82.h),
        child: const TopBar(
          title: "Фильтры",
          isHomeScreen: false,
          disableVerticalPadding: true,
          showShadow: false,
          showAccount: false,
        ),
      );

  Widget _body() => Stack(children: [
        ListView(
          padding: EdgeInsets.only(bottom: 25.h),
          children: const [
            ModelSelectorWidget(),
            MainOptionsWidget(),
            AddOptionsWidget()
          ],
        ),
        _applyWidget(),
      ]);

  Widget _applyWidget() => false
      // ignore: dead_code
      ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            width: 165.w,
            height: 44.h,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: paleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 15,
                  offset: Offset(-1, 10),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 15,
                  offset: Offset(1, 1),
                  spreadRadius: 2,
                )
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Применить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        )
      : Container();
}
