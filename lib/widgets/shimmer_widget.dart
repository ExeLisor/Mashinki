import 'package:autoverse/exports.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.blueGrey.withOpacity(0.05),
        highlightColor: primaryColor.withOpacity(0.5),
        child: child);
  }
}
