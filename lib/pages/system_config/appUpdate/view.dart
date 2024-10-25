part of app_update;

class AppUpdatePage extends GetView<AppUpdateController> {
  const AppUpdatePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return controller.isUpdating ? _buildUpdateWidget() : _buildTextWidget();
  }

  _buildTextWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget.title1(VersionFunc.isSameVersion() ? "当前暂无新版本" : "当前有新版本"),
          SizedBox(height: 20.w),
          if (VersionFunc.androidKeySeries != Constants.androidKeySeries)
            const Text(
              "由于签名修改，需卸载重新安装，复制右上角链接至浏览器下载。",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ).paddingBottom(20.w).paddingHorizontal(20.w),
          if (VersionFunc.androidKeySeries == Constants.androidKeySeries)
            ButtonWidget.primary(
              VersionFunc.isSameVersion() ? "继续更新" : "立即更新",
              onTap: () => controller.downloadAndroid(),
              borderRadius: 5,
              backgroundColor: Colors.green.shade500,
              height: 45,
              width: 0.7 * ScreenFunc.screenWidth,
            ),
        ],
      ),
    );
  }

  _buildUpdateWidget() {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            AssetsLotties.liquidLoaderJson,
            width: 200.w,
            height: 200.w,
          ).paddingVertical(60.w),
          SizedBox(height: 50.w),
          GetBuilder<AppUpdateController>(
            id: 'app_update_progress',
            builder: (_) => SizedBox(
              width: 0.9 * ScreenFunc.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.progressLabel),
                      Text("${(controller.progressValue * 100).toInt()}%"),
                    ],
                  ).paddingHorizontal(5.w),
                  SizedBox(height: 5.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // 圆角半径
                    child: LinearProgressIndicator(
                      value: _.progressValue, // 进度的值（0.0 到 1.0）
                      minHeight: 8, // 进度条的最小高度（可选）
                      backgroundColor: Colors.grey.shade200, // 进度条背景颜色（可选）
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green.shade500), // 进度条颜色（可选）
                    ),
                  ),
                  // ),
                  SizedBox(height: 5.w),
                  Text(
                    _.progressValue == 1 ? "即将更新完成，进行安装！" : "正在更新中，请勿退出App！",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ).paddingLeft(5.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppUpdateController>(
      init: AppUpdateController(),
      id: "app_update",
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            //此方法会导致iOS的右滑手势失效
            return false;
          },
          child: CustomScaffold(
            appBar: CustomAppBar(
              leading: controller.isUpdating
                  ? const SizedBox()
                  : const Icon(Icons.close).onTap(() => Get.back()),
              actions: [
                IconWidget.svg(
                  AssetsSvgs.browserDownloadSvg,
                  color: AppColors.primary,
                ).onTap(() async {
                  String? androidPath = VersionFunc.versionModel.android!.path;
                  final uri =
                      Uri.parse(androidPath ?? Constants.androidDownloadURL);
                  Clipboard.setData(ClipboardData(text: uri.toString()));
                  Loading.toast("安装包下载链接已复制");
                  // if (await canLaunchUrl(uri)) {
                  //   await launchUrl(uri, mode: LaunchMode.externalApplication);
                  // }
                })
              ],
            ),
            body: SafeArea(
              child: _buildView(),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VectorGraphic(
                  loader: const AssetBytesLoader(AssetsSvgs.tikTokSvg),
                  width: 32.w,
                  height: 32.w,
                ),
                SizedBox(width: 10.w),
                Text(
                  "Tiktok",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ).paddingBottom(20.w),
          ),
        );
      },
    );
  }
}
