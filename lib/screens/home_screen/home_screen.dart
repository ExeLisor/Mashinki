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

  Widget _body() => const Column(
        children: [TopBar(title: "Каталог")],
      );
}
