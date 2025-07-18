part of 'index.dart';

class CommentPage extends GetView<CommentController> {
  const CommentPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < controller.commitlist.length; i++) {
      list.add(_comment(controller.commitlist[i], index: i, context: context));
    }
    return list.toColumn();
  }

  Widget _comment(item, {int? index, required BuildContext context}) {
    return Column(
      children: [
        _commentWidget(item, index: index, context: context),
        if (item['children'] != null)
          Column(
            children: _repeatCommentWidget(item, context: context),
          ).marginOnly(left: 55.w),
        if (int.parse(item['sub_comment_count']) > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '─  ',
                    style: TextStyle(color: AppColors.text_3, fontSize: 14.sp),
                  ),
                  TextSpan(
                    text: item['showChildren'] != null
                        ? '展开更多回复'
                        : '展开${item['sub_comment_count']}条回复',
                    style: TextStyle(color: AppColors.text_2, fontSize: 14.sp),
                  ),
                ])),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.text_2,
                  size: 18.sp,
                ),
              ],
            ).marginOnly(top: 5.h, bottom: 5.h, left: 47.w).onTap(() {
              controller.showChildrenComment(item);
            }),
          )
      ],
    );
  }

  List<Widget> _repeatCommentWidget(dynamic item,
      {required BuildContext context}) {
    List<Widget> ws = [];
    for (int j = 0; j < item['children'].length; j++) {
      dynamic childItem = item['children'][j];
      ws.add(
        _commentWidget(
          childItem,
          avatarSize: 20,
          index: j,
          context: context,
        ).marginOnly(top: 10.h),
      );
    }
    return ws;
  }

  Widget _commentWidget(dynamic item,
      {double avatarSize = 37.5, int? index, required BuildContext context}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(
          item['avatar'],
          width: avatarSize.w,
          height: avatarSize.w,
        ).clipRRect(all: (avatarSize / 2).r),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['nickname'],
                style: TextStyle(
                  color: AppColors.text_3,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                item['user_buried'] ? '该评论已折叠' : item['content'],
                style: TextStyle(
                  color: item['user_buried']
                      ? Context(context).theme.textColor2
                      : Context(context).theme.textColor,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${Unit.formatTime(item['create_time'])} · ${item['ip_location']}',
                        style: TextStyle(
                          color: AppColors.text_3,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '回复',
                        style: TextStyle(
                          color: AppColors.text_2,
                          fontSize: 14.sp,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      LikeButton(
                        size: 17.sp,
                        isLiked: index! % 6 == 0,
                        onTap: (bool isLiked) async {
                          if (!isLiked) Vibration.vibrate();
                          return !isLiked;
                        },
                        likeCount: int.parse(item['digg_count']),
                        likeCountAnimationType:
                            int.parse(item['digg_count']) < 1000
                                ? LikeCountAnimationType.part
                                : LikeCountAnimationType.none,
                        countBuilder: (int? count, bool isLiked, String text) {
                          final color =
                              isLiked ? Colors.pinkAccent : AppColors.text_3;
                          Widget result = Text(
                            count! >= 1000
                                ? '${(count / 1000.0).toStringAsFixed(1)}k'
                                : text,
                            style: TextStyle(color: color, fontSize: 14.sp),
                          );
                          return result;
                        },
                        likeCountPadding: EdgeInsets.only(left: 4.w),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        IconFont.dislike,
                        color: AppColors.text_3,
                        size: 17.sp,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      init: CommentController(),
      id: "comment",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
