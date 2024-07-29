import 'package:autoverse/exports.dart';

class ModelsScreen extends StatelessWidget {
  const ModelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopBar(title: 'Модельный ряд'),
          _brandsTitle(),
          _modelsView(),
        ],
      ),
    );
  }

  Widget _brandsTitle() => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Center(
          child: Text(
            Get.parameters["mark"] ?? "",
            style: TextStyle(
                fontSize: 20.fs,
                color: primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      );

  Widget _modelsView() => ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(),
        itemCount: 0,
      );

  Widget _modelTile() => Container();
}
