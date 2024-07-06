import 'package:mashinki/exports.dart';

//Делает проверку на стейт главной страницы

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({
    super.key,
    required this.shimmer,
    required this.child,
  });

  final Widget child;
  final Widget shimmer;

  @override
  Widget build(BuildContext context) => GetBuilder<HomeScreenController>(
        builder: (home) {
          if (home.state == HomeState.done) return child;

          return shimmer;
        },
      );
}
