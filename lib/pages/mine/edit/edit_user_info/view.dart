part of edit_user_info;

class EditUserInfoPage extends GetView<EditUserInfoController> {
  String type;
  String value;

  EditUserInfoPage({
    Key? key,
    this.type = "",
    this.value = "",
  }) : super(key: key);

  Map titleMap = {
    '1': '修改名字',
    '2': '修改简介',
    '3': '修改抖音号',
  };

  Map typeMap = {
    '1': '我的名字',
    '2': '个人简介',
    '3': '我的抖音号',
  };

  Map hintTextMap = {
    '1': '填写名字',
    '2': '介绍喜好、个性或@你的亲友',
    '3': '',
  };

  Map tipsMap = {
    '1': '名字30天内可修改4次，2024-08-31前还可修改4次',
    '2': '',
    '3': '最多16个字，只允许包含字母、数字、下划线和点，180天内仅能修改1次',
  };

  // 主视图
  Widget _buildView(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            typeMap[controller.type],
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
          ),
          SizedBox(height: 15.h),
          TextField(
            controller: controller.eventNameController,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
            ),
            maxLines: controller.type == "2" ? 10 : 1,
            minLines: controller.type == "2" ? 10 : 1,
            decoration: InputDecoration(
              hintText: hintTextMap[controller.type],
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                overflow: TextOverflow.clip,
              ),
              filled: controller.type == "2",
              fillColor: const Color(0xff1f2534),
              contentPadding: controller.type == "2"
                  ? const EdgeInsets.all(15)
                  : const EdgeInsets.fromLTRB(0, 15, 0, 15),
            ),
          ),
          if (tipsMap[controller.type] != null) ...[
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 75.w,
                  child: Text(
                    tipsMap[controller.type],
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12.sp,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '0/20',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12.sp,
                  ),
                )
              ],
            )
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditUserInfoController>(
      init: EditUserInfoController(type, value),
      id: "edit_user_info",
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(titleMap[controller.type]),
            leading: IconButton(
              icon: Icon(Icons.chevron_left, size: 24.sp),
              onPressed: () {
                if (controller.value == controller.eventNameController.text) {
                  Get.back();
                } else {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('是否保存修改'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          isDefaultAction: true,
                          child: const Text('放弃'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            Get.back();
                            controller.submit();
                          },
                          child: const Text('保存'),
                        )
                      ],
                    ),
                  );
                }
                // Get.back();
              },
            ),
            actions: [
              TextButton(
                onPressed: controller.submit,
                child: Text(
                  '完成',
                  style: TextStyle(
                    color: const Color.fromRGBO(252, 47, 86, 0.5),
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
