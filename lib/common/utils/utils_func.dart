import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icebery_flutter/common/index.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UtilsFunc {
  /// 通过文本的内容 限制最大宽和行高来确认文本内容的宽高尺寸
  static Size boundingTextSize(String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  static const deFaultDurationTime = 300;
  static Timer? timer;

  /// 防抖
  static debounce(Function doSomething, {durationTime = deFaultDurationTime}) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: durationTime), () {
      doSomething.call();
      timer = null;
    });
  }

  /// 处理文字，超出部分用特殊符号代替
  /// [text] 文字
  /// [maxLength] 限制最大字数
  /// [replaceCharacter] 超出部分用特殊符号代替
  static interceptStringByEllipsis(
    String text, {
    int maxLength = 6,
    String replaceCharacter = ".",
  }) {
    int startIndex = maxLength;
    int endIndex = text.length;
    //字符串转utf8
    List<int> bytes = utf8.encode(text);

    if (bytes.length > maxLength * 3) {
      return text.replaceRange(startIndex, endIndex, replaceCharacter * 3);
    } else {
      return text;
    }
  }

  /// 随机生成某范围的数值 - 生成min ~ max - 1的值
  static randomRangeNum(int min, int max) {
    //实例化 Random类 并赋值给 私有变量 _random
    final random = Random();
    var number = min + random.nextInt(max - min);
    return number;
  }

  /// 将每个字符串之间插入零宽空格，防止由于设置了【overflow: TextOverflow.ellipsis】字母，数字整串导致省略号提前
  static String breakWord(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = ' ';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  /// 对object根据modal进行整形,赋值modal中的数值,删除多余键值
  /// @param obj
  /// @param modal
  static Map initObj(Map obj, Map modal) {
    List modalKeyList = modal.keys.toList();
    for (String key in obj.keys.toList()) {
      if (modalKeyList.contains(key)) {
        obj[key] = modal[key];
      } else {
        obj.remove(key);
      }
    }
    return obj;
  }

  /// 将src中的数据copy到dist中，只要dist中存在该key则进行赋值
  /// param dist //模范元素
  /// param src //需要拷贝值的源
  static Map cloneValue(Map dist, Map src) {
    List srcKeyList = src.keys.toList();
    for (String key in dist.keys.toList()) {
      if (srcKeyList.contains(key)) {
        dist[key] = src[key];
      } else {
        dist[key] = "";
      }
    }
    return dist;
  }

  /// "key"相同的两个Map为其中一带TextEditingController进行text赋值
  /// param textControllerMap // "value" => TextEditingController的Map
  /// param srcMap // "value" => textControllerMap所需text的值
  static cloneValueToTextContoller(
      Map<String, TextEditingController> textControllerMap, Map srcMap) {
    for (String key in textControllerMap.keys.toList()) {
      textControllerMap[key]!.text = srcMap[key];
    }
  }

  /// 后台返回的图片处理，有可能要自己拼接url
  static imgUrlSplice(String urlString, {String standByUrl = ""}) {
    final url = Uri.tryParse(urlString);
    if (url != null && url.scheme.contains('http')) {
      return urlString;
    } else {
      if (urlString != "" || standByUrl != "") {
        return Constants.imagesUrl +
            (standByUrl.isNotEmpty ? standByUrl : urlString);
      } else {
        return "";
      }
    }
  }

  /// 图片是否是url地址
  static bool isNetImage(dynamic dynamicParams) {
    if (dynamicParams is File) {
      return false;
    }
    if (dynamicParams is String) {
      final url = Uri.tryParse(dynamicParams);
      if (url != null && url.scheme.contains('http') ||
          (url != null &&
              (imgUrlSplice(dynamicParams) as String).contains('http'))) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static bool isUrl(String urlString) {
    final url = Uri.tryParse(urlString);
    if (url != null && url.scheme.contains('http')) {
      return true;
    } else {
      return false;
    }
  }

  /// 有的图片链接会出现中文，需要移动端utf-8进行转义
  static String stringUtf8Encode(String url) {
    return Uri.encodeFull(url);
  }

  /// 将文本复制到剪贴板
  static void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  /// 校验是否是个合法的json字符串
  static bool isJsonString(String jsonString) {
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      // ignore: unnecessary_type_check
      if (json is Map<String, dynamic>) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// 对于电话号码中间四位进行*处理
  static String maskPhoneMiddleFourDigits(String input, {bool isShow = false}) {
    if (!isShow) {
      if (input.length < 8) {
        // 输入字符串长度不足8位，无法进行中间四个数字的星号处理
        return input;
      }
      String maskedString = input.substring(0, input.length - 8); // 保留前面的字符
      // 获取中间四个数字
      String maskedDigits = '****'; // 替换为星号的字符串
      String remainingDigits = input.substring(input.length - 4); // 保留后面的字符
      return maskedString + maskedDigits + remainingDigits;
    }
    return input;
  }

  /// 压缩图片
  static Future<File?> compressImage(
    File file, {
    int quality = 80,
    int rotate = 0,
  }) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.absolute.path}-compressed.jpg',
      quality: quality,
      rotate: rotate,
    );
    return result != null ? File(result.path) : null;
  }
}
