part of app_update;

class AppUpdateController extends GetxController {
  AppUpdateController();
  bool isUpdating = false;
  double progressValue = 0;
  String progressLabel = "0B / 0B";

  downloadAndroid() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    String url =
        VersionFunc.versionModel.android!.path ?? Constants.androidDownloadURL;
    if (deviceInfo.version.sdkInt >= 30) {
      final permissions = await Permission.manageExternalStorage.status;
      if (!permissions.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    } else {
      final permissions = await Permission.storage.status;
      if (!permissions.isGranted) {
        await Permission.storage.request();
      }
    }
    isUpdating = true;
    update(["app_update"]);
    startDownLoad(url);
  }

  ///开始下载
  startDownLoad(String url) async {
    /// 创建存储文件
    Directory? storageDir = await getExternalStorageDirectory();
    String storagePath = "";
    if (storageDir != null) {
      storagePath = storageDir.path;
    }
    final path = '$storagePath/digital.apk';

    try {
      var dio = Dio();
      await dio.download(url, path,
          onReceiveProgress: (int received, int total) {
        if (total == -1) {
          progressValue = 0.01;
        } else {
          progressValue = received / total.toDouble();
        }
        progressLabel =
            "${CacheFunc.formatSize(received.toDouble())} / ${CacheFunc.formatSize(total.toDouble())}";
        update(["app_update_progress"]);
        if (progressValue == 1) {
          //下载完成，跳转到程序安装界面
          update(["app_update_progress"]);
          Future.delayed(const Duration(milliseconds: 1500), () {
            isUpdating = false;
            update(["app_update"]);
            openApk(path);
          });
        }
      });
    } catch (e) {
      isUpdating = false;
      progressValue = 0;
      update(["app_update"]);
    }
  }

  //打开apk 开始安装
  openApk(String path) {
    final FlutterAppInstaller flutterAppInstaller = FlutterAppInstaller();
    flutterAppInstaller.installApk(
      filePath: path,
    );
  }

  _initData() {
    update(["app_update"]);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
