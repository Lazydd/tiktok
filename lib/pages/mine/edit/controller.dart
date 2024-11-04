part of edit;

class EditController extends GetxController {
  EditController();

  TextEditingController eventNameController = TextEditingController();
  String headFile = '';
  String name = '';
  String sex = '3';
  String birthday = '';
  String userUniqueId = '';

  void changeSex(String type) {
    sex = type;
    update(["edit"]);
  }

  void changeBirthday(DateTime date) {
    birthday = DateFormat('yyyy-MM-dd').format(date);
    update(["edit"]);
  }

  String getSex() {
    String str = '选择性别表达自我';
    switch (sex) {
      case '1':
        str = '男';
        break;
      case '2':
        str = '女';
        break;
      case '3':
        str = '不展示';
        break;
    }
    return str;
  }

  addHeadImgFile(dynamic imgFileItem) async {
    if (imgFileItem != null) {
      File? file = await UtilsFunc.compressImage(imgFileItem['file']);
      // debugPrint(file);
      // Map<String, dynamic> params = {
      //   "path": 'devicetype',
      // };
      // String url = await OtherAPI.uploadFile(file!, params);
      // if (url.isNotEmpty) {
      //   updateProfileInfo(UserProfileModel(profilePicture: url));
      // }
    }
  }

  addProfileImgFile(dynamic imgFileItem) async {
    if (imgFileItem != null) {
      File? file = await UtilsFunc.compressImage(imgFileItem['file']);
      // file ??= imgFileItem['file'];
      // Map<String, dynamic> params = {
      //   "path": 'devicetype',
      // };
      // String url = await OtherAPI.uploadFile(file!, params);
      // if (url.isNotEmpty) {
      //   updateProfileInfo(UserProfileModel(profilePicture: url));
      // }
    }
  }

  _initData() {
    update(["edit"]);
  }

  void onTap() {}

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
