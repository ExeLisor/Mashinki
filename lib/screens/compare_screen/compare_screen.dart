import 'package:autoverse/exports.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: appBar(), body: _body());

  Widget _body() => Obx(
        () => Center(
          child: Text(
              "машин в сравнеии ${CompareController.to.comparedCars.length}"),
        ),
      );
}
