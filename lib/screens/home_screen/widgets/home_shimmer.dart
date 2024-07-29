import 'package:autoverse/exports.dart';

//Делает проверку на стейт главной страницы

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({
    super.key,
    required this.shimmer,
    required this.child,
    this.successCondition = false,
  });

  final Widget child;
  final Widget shimmer;
  final bool successCondition;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: successCondition ? child : shimmer,
      );
}
