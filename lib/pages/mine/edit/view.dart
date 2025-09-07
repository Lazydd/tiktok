part of 'index.dart';

class EditPage extends GetView<EditController> {
  const EditPage({super.key});

  // 主视图
  Widget _buildView(context) {
    late final FormController formController = FormController();
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
            ).onTap(() async {
              _showPhotoActionSheet();
            }),
            CustomCell(
              title: const Text.rich(
                TextSpan(
                  children: [
                    // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                    TextSpan(
                      text: "名字",
                      style: TextStyle(color: Color(0xffbababb)),
                    ),
                  ],
                ),
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
                TextSpan(
                  children: [
                    // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                    TextSpan(
                      text: "简介",
                      style: TextStyle(color: Color(0xffbababb)),
                    ),
                  ],
                ),
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
                TextSpan(
                  children: [
                    // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                    TextSpan(
                      text: "性别",
                      style: TextStyle(color: Color(0xffbababb)),
                    ),
                  ],
                ),
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
                      ),
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
                TextSpan(
                  children: [
                    // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                    TextSpan(
                      text: "生日",
                      style: TextStyle(color: Color(0xffbababb)),
                    ),
                  ],
                ),
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
                DataPicker.datetime(context: context).show().then((items) {});
              },
            ),
            CustomCell(
              title: const Text.rich(
                TextSpan(
                  children: [
                    // TextSpan(text: "*  ", style: TextStyle(color: Colors.red)),
                    TextSpan(
                      text: "抖音号",
                      style: TextStyle(color: Color(0xffbababb)),
                    ),
                  ],
                ),
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
            ),
            // FormInput(
            //   controller: formController,
            //   showErrors: true,
            //   validateOnInput: true,
            //   children: [
            //     Input.leading("标题名称"),
            //     Input.text(
            //       name: 'name2',
            //       label: "label2",
            //       placeholder: "请输入用户名",
            //       required: true,
            //     ),
            //     Input.text(
            //       name: 'name5',
            //       label: "label5",
            //       placeholder: "请输入用户名",
            //       required: true,
            //       validator: [
            //         Validator.limited(2, 10),
            //         Validator.equals(() => formController.form, "name2"),
            //       ],
            //     ),
            //     Input.switcher(
            //       name: "kai",
            //       label: "开关",
            //       subtitle: "是否起",
            //       onChanged: (value) => print(value),
            //     ),
            //     Input.numberStepper(
            //       name: "pice",
            //       label: "数量",
            //       minValue: 1,
            //       maxValue: 50,
            //       suffix: "个",
            //     ),
            //     Input.regional(name: "address", label: "地址", required: true),
            //     // Input.datetime(
            //     //   name: "date",
            //     //   label: "生日",
            //     //   placeholder: "请选择时间",
            //     //   renderer: (value) => Dates.format('yyyy', value),
            //     //   formatter: DateTimeFormatter.YYYY_MM_DD,
            //     // ),
            //     // Input.number(
            //     //   name: "height",
            //     //   label: "身高",
            //     //   minValue: 0,
            //     //   maxValue: 120,
            //     //   suffix: "cm",
            //     //   placeholder: "请选择身高",
            //     // ),
            //     // Input.select(
            //     //   name: "gender",
            //     //   label: "性别",
            //     //   options: [
            //     //     Option(label: "男", value: "male"),
            //     //     Option(label: "女", value: "female"),
            //     //   ],
            //     // ),
            //     // Input.selectList(
            //     //   name: "multiple",
            //     //   label: "多选",
            //     //   options: [
            //     //     Option(label: "男1", value: "male1"),
            //     //     Option(label: "男2", value: "male2"),
            //     //     Option(label: "男21", value: "male255"),
            //     //     Option(label: "男222", value: "male24"),
            //     //     Option(label: "男2333", value: "male23"),
            //     //     Option(label: "男24444", value: "male22"),
            //     //   ],
            //     // ),
            //   ],
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     print("${formController.form}");
            //     if (formController.validate()) {
            //       print("验证通过了！！！！！！！！！！！！！！！！！");
            //     } else {
            //       final errors = formController.getErrors();
            //       print("------------------- errors -------------------");
            //       errors.forEach((k, v) => print("$k : $v"));
            //       print("----------------------------------------------");
            //     }
            //   },
            //   child: const Text('验证'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     print("--------------------- FromValue ---------------------");
            //     formController.getValue().forEach((k, v) => print("$k : $v"));
            //     print("-----------------------------------------------------");
            //   },
            //   child: const Text('获取表单值'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     formController.reset();
            //   },
            //   child: const Text('重置'),
            // ),
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
              child: Text("拍摄照片", style: TextStyle(fontSize: 20.sp)),
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
              child: Text("从手机相册选择", style: TextStyle(fontSize: 20.sp)),
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
      },
    );
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

  formatImage(dynamic imageFileItem, {bool isPath = false, String? api}) async {
    if (imageFileItem != null) {
      File? file = await UtilsFunc.compressImage(
        imageFileItem['file'],
        rotate: imageFileItem["rotate"] ?? 0,
      );
      file ??= imageFileItem['file'];
      if (isPath) {
        Map<String, dynamic> params = {"path": 'devicetype'};
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
              ),
            ],
          ),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
