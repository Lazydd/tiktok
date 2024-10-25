import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheFunc {
  /// 获取缓存
  static Future<double> loadApplicationCache() async {
    // 获取文件夹
    Directory directory = await getTemporaryDirectory();
    // 获取缓存大小
    double value = await getTotalSizeOfFilesInDir(directory);
    return value;
  }

  /// 循环计算文件的大小（递归）
  static Future<double> getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      try {
        if (file.existsSync()) {
          final List<FileSystemEntity> children = file.listSync();
          double total = 0;
          if (children.isNotEmpty) {
            for (final FileSystemEntity child in children) {
              total += await getTotalSizeOfFilesInDir(child);
            }
          }
          return total;
        }
      } catch (e) {
        // Loading.toast("异常");
        return 0;
      }
    }
    return 0;
  }

  /// 缓存大小格式转换
  static String formatSize(double value) {
    List<String> unitArr = ['B', 'KB', 'MB', 'GB'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return '$size ${unitArr[index]}';
  }

  /*
  *
  * 删除缓存
  * 参数：Directory directory = await getTemporaryDirectory();
  * */
  static Future<void> delDir(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      final List<FileSystemEntity> children =
          file.listSync(recursive: true, followLinks: true);
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    try {
      if (file.existsSync()) {
        await file.delete(recursive: true);
      }
    } catch (err) {
      print("error:$err");
    }
  }
}
