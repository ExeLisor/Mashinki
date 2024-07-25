import 'package:autoverse/exports.dart';

Widget brandCard(Mark mark) => Column(
      children: [
        Container(
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
        SizedBox(
          height: 10.h,
        ),
        // Text(
        //   mark.name ?? "",
        //   style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 14.fs,
        //       fontWeight: FontWeight.w600),
        // )
      ],
    );
