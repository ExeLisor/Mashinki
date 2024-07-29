import 'package:autoverse/exports.dart';

class MarkGridTile extends StatelessWidget {
  const MarkGridTile({super.key, required this.mark});

  final Mark mark;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _markLogo(),
          SizedBox(
            height: 5.h,
          ),
          _markName(),
        ],
      );

  Widget _markLogo() => GestureDetector(
        onTap: () {},
        child: Container(
          height: 75.h,
          width: 75.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: CachedNetworkImage(
              filterQuality: FilterQuality.medium,
              imageUrl: "$baseUrl/marks/${mark.id}/logo",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      );

  Widget _markName() => Text(
        mark.name ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 12.fs, fontWeight: FontWeight.w600),
      );
}
