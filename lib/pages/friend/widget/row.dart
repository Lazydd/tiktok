import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class BuildRow extends StatelessWidget {
  final String? text;
  final String? icon;

  const BuildRow({Key? key, this.text = '', this.icon = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xff3a3a43),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: VectorGraphic(
                  loader: AssetBytesLoader(icon!),
                  width: 20.sp,
                  height: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              text ?? '',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            )
          ],
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16.w,
          color: Colors.white,
        )
      ],
    );
  }
}
