part of slidebar;

Widget _title(
  String title, {
  String? subtTitle,
  bool more = false,
  Function()? onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (more)
        Row(
          children: [
            Text(
              subtTitle ?? '全部',
              style: TextStyle(
                color: const Color(0xff808080),
                fontSize: 12.sp,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xff808080),
              size: 12.sp,
            )
          ],
        ).onTap(onTap)
    ],
  );
}
