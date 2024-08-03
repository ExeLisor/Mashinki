import 'package:autoverse/exports.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _carImage(), // Replace with your image
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_appBarRow()],
          ),
        ],
      ),
    );
  }

  Widget _carImage() => SizedBox(
        height: 412.h,
        width: Get.width,
        child: ClipRRect(
          child: CachedNetworkImage(
            imageUrl:
                "$baseUrl/image/${CarController.to.configuration.value?.id}",
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _appBarRow() => Container(
        margin: EdgeInsets.fromLTRB(25.w, 45.h, 25.w, 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _backIcon(),
            _iconBlock(),
          ],
        ),
      );

  Widget _backIcon() => _iconWidget(Icons.arrow_back_ios_new_rounded, Get.back);

  Widget _iconBlock() => Wrap(
        children: [
          _addToCompIcon(),
          SizedBox(
            width: 15.w,
          ),
          _likeWidget()
        ],
      );

  Widget _addToCompIcon() => _iconWidget(Icons.copy, () {});

  Widget _likeWidget() => _iconWidget(Icons.heart_broken, () {});

  Widget _iconWidget(IconData icon, VoidCallback function) => GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          height: 45.h,
          width: 45.h,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      );
}
