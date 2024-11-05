part of edit;

class EditPage extends GetView<EditController> {
  const EditPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              margin: EdgeInsets.only(bottom: 30.h),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: controller.headFile != ''
                  ? ImageWidget(controller.headFile)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                          size: 24.sp,
                        ).marginOnly(bottom: 5.w),
                        Text(
                          '更换头像',
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        )
                      ],
                    ),
            ).onTap(() async {
              _showPhotoActionSheet();
            }),
            CustomCell(
              title: const Text.rich(
                TextSpan(children: [
                  // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                  TextSpan(
                    text: "名字",
                    style: TextStyle(
                      color: Color(0xffbababb),
                    ),
                  ),
                ]),
              ),
              value: Text(
                controller.name != '' ? controller.name : "填写名字",
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.start,
              ).width(220.w),
              showArrow: true,
              onTap: () => Get.toNamed(
                RouteNames.editUserInfoRoute,
                parameters: {"type": "1", "value": controller.name},
              ),
            ),
            CustomCell(
              title: const Text.rich(
                TextSpan(children: [
                  // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                  TextSpan(
                      text: "简介",
                      style: TextStyle(
                        color: Color(0xffbababb),
                      )),
                ]),
              ),
              value: const Text(
                "介绍喜好、个性或@你的亲友",
                style: TextStyle(color: Color(0xffbababb)),
                textAlign: TextAlign.start,
              ).width(220.w),
              showArrow: true,
              onTap: () => Get.toNamed(
                RouteNames.editUserInfoRoute,
                parameters: {"type": "2", "value": "简介1"},
              ),
            ),
            CustomCell(
              title: const Text.rich(
                TextSpan(children: [
                  // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                  TextSpan(
                      text: "性别",
                      style: TextStyle(
                        color: Color(0xffbababb),
                      )),
                ]),
              ),
              value: Text(
                controller.getSex(),
                style: const TextStyle(color: Color(0xffbababb)),
                textAlign: TextAlign.start,
              ).width(220.w),
              showArrow: true,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Get.back();
                          controller.changeSex('1');
                        },
                        child: const Text('男'),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Get.back();
                          controller.changeSex('2');
                        },
                        child: const Text('女'),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Get.back();
                          controller.changeSex('3');
                        },
                        child: const Text('不展示'),
                      )
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('取消'),
                    ),
                  ),
                );
              },
            ),
            CustomCell(
              title: const Text.rich(
                TextSpan(children: [
                  // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                  TextSpan(
                      text: "生日",
                      style: TextStyle(
                        color: Color(0xffbababb),
                      )),
                ]),
              ),
              value: Text(
                controller.birthday != ''
                    ? controller.birthday
                    : "生日当天会受到火山的祝福",
                style: const TextStyle(color: Color(0xffbababb)),
                textAlign: TextAlign.start,
              ).width(220.w),
              showArrow: true,
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(0, 1, 1),
                  maxTime: DateTime(10000, 12, 31),
                  onChanged: (date) {},
                  onConfirm: controller.changeBirthday,
                  currentTime: DateTime.now(),
                  locale: LocaleType.zh,
                );
              },
            ),
            CustomCell(
              title: const Text.rich(
                TextSpan(children: [
                  // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                  TextSpan(
                    text: "抖音号",
                    style: TextStyle(
                      color: Color(0xffbababb),
                    ),
                  ),
                ]),
              ),
              value: Text(
                controller.userUniqueId != ''
                    ? controller.userUniqueId
                    : "我的抖音号",
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.start,
              ).width(220.w),
              showArrow: true,
              onTap: () => Get.toNamed(
                RouteNames.editUserInfoRoute,
                parameters: {"type": "3", "value": controller.userUniqueId},
              ),
            )
          ],
        ),
      ),
    );
  }

  _showPhotoActionSheet() async {
    var result = await showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "拍摄照片",
                  style: TextStyle(fontSize: 20.sp),
                ),
                onPressed: () async {
                  Access.openCamera(
                    context,
                    onCameraGranted: () {
                      Get.back(result: AccessEnum.takePhoto);
                    },
                    isNavigatorPop: true,
                  );
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "从手机相册选择",
                  style: TextStyle(fontSize: 20.sp),
                ),
                onPressed: () {
                  Get.back(result: AccessEnum.photoLibrary);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                "取消",
                style: TextStyle(color: Colors.red, fontSize: 20.sp),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          );
        });
    if (result == AccessEnum.takePhoto) {
      dynamic fileObj = await Access.showTakePhoto(Get.context!);
      // controller.addProfileImgFile(fileObj);
      var path = formatImage(fileObj);
    }
    if (result == AccessEnum.photoLibrary) {
      dynamic fileObj = await Access.showPhotoLibrary(Get.context!);
      // controller.addProfileImgFile(fileObj);
      var path = formatImage(fileObj);
    }
  }

  formatImage(
    dynamic imageFileItem, {
    bool isPath = false,
    String? api,
  }) async {
    if (imageFileItem != null) {
      File? file = await UtilsFunc.compressImage(
        imageFileItem['file'],
        rotate: imageFileItem["rotate"] ?? 0,
      );
      file ??= imageFileItem['file'];
      if (isPath) {
        Map<String, dynamic> params = {
          "path": 'devicetype',
        };
        // String url = await OtherAPI.uploadFile(file!, params, api: api);
        // if (url.isNotEmpty) {
        //   return url;
        // }
      } else {
        final bytes = await file!.readAsBytes();
        final encodedBytes = base64Encode(bytes);
        return encodedBytes;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditController>(
      init: EditController(),
      id: "edit",
      builder: (_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: Get.back,
                icon: Icon(Icons.chevron_left, size: 24.sp),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  dynamic fileObj = await Access.showPhotoLibrary(context);
                  controller.addProfileImgFile(fileObj);
                },
                icon: Icon(Icons.photo_camera, size: 24.sp),
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
