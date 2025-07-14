import 'package:flutter/widgets.dart'
    show FormFieldValidator, TextEditingController;

class Validdator {
  Validdator._();

  // Validator.require('filed is required')
  static FormFieldValidator required(String m) {
    return (v) {
      if (v?.isEmpty ?? true) return m;
      return null;
    };
  }

  // Validator.min(4, 'field min 4')
  static FormFieldValidator<String> min(int min, String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) < min) return m;
      return null;
    };
  }

  // Validator.max(4, 'field max 4')
  static FormFieldValidator<String> max(int max, String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) > max) return m;
      return null;
    };
  }

  /// Validates if the field has at least `minimumLength` and at most `maximumLength`
  ///
  /// e.g.: Validator.between(6, 10, 'password must have between 6 and 10 digits')
  static FormFieldValidator<String> between(
    int minimumLength,
    int maximumLength,
    String errorMessage,
  ) {
    assert(minimumLength < maximumLength);
    return multiple([
      min(minimumLength, errorMessage),
      max(maximumLength, errorMessage),
    ]);
  }

  // Validator.number('Value not a number')
  static FormFieldValidator<String> number(String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (double.tryParse(v!) != null) {
        return null;
      } else {
        return m;
      }
    };
  }

  // Validator.email('Value is not email')
  static FormFieldValidator<String> email(String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      );
      if (emailRegex.hasMatch(v!)) return null;
      return m;
    };
  }

  static FormFieldValidator<String> phone(String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      final phoneRegex = RegExp(r"^1[3456789]\d{9}$");
      if (phoneRegex.hasMatch(v!)) return null;
      return m;
    };
  }

  static FormFieldValidator<String> noChineseandBlank(String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      final phoneRegex = RegExp(r"^[^\u4e00-\u9fa5\s]{0,}$");
      if (phoneRegex.hasMatch(v!)) return null;
      return m;
    };
  }

  // Validator.multiple([
  //   Validator.email('Value is not email')
  //   Validator.max(4, 'field max 4')
  // ])
  static FormFieldValidator<String> multiple(
    List<FormFieldValidator<String>> v,
  ) {
    return (value) {
      for (final validator in v) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  /// Validates if the field has a valid date according to `DateTime.tryParse`
  ///
  /// e.g.: Validator.date('invalid date')
  static FormFieldValidator<String> date(String errorMessage) {
    return (value) {
      final date = DateTime.tryParse(value ?? '');
      if (date == null) {
        return errorMessage;
      }
      return null;
    };
  }

  // Compare two values using desired input controller
  /// e.g.: Validator.compare(inputController, 'Passwords do not match')
  static FormFieldValidator<String> compareDifferent(
    TextEditingController? controller,
    String message,
  ) {
    return (value) {
      final textCompare = controller?.text ?? '';
      if (value == null || textCompare != value) {
        return message;
      }
      return null;
    };
  }

  // Compare two values using desired input controller
  /// e.g.: Validator.compare(inputController, 'Passwords do not match')
  static FormFieldValidator<String> compareSame(
    TextEditingController? controller,
    String message,
  ) {
    return (value) {
      final textCompare = controller?.text ?? '';
      if (value == null || textCompare == value) {
        return message;
      }
      return null;
    };
  }

  /// IP 地址校验
  static bool ipAddressValidator(String? value) {
    // 带端口
    final ipAddressWithPortRegex = RegExp(
      r"^((http|https):\/\/)?(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}:([0-9]|[1-9]\d|[1-9]\d{2}|[1-9]\d{3}|[1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])$",
    );
    // 不带端口
    final ipAddressRegex = RegExp(
      r"^((http|https):\/\/)?(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])$",
    );

    if (ipAddressWithPortRegex.hasMatch(value!) ||
        ipAddressRegex.hasMatch(value)) {
      return true;
    }
    return false;
  }

  /// 校验 域名+IP 带端口的地址
  static bool networkAddressValidator(String? value) {
    final networkRegex = RegExp(
      r"^((https|http|ftp|rtsp|igmp|file|rtspt|rtspu):\/\/)(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(\/[a-zA-Z0-9\&%_\./-~-]*)?$",
    );
    if (networkRegex.hasMatch(value!)) return true;
    return false;
  }

  /// 判断是否有值
  static bool inputValidator(String? input) {
    if (input == null) {
      return false;
    }
    // "     "的字符串也默认为空
    if (input.trim().isEmpty) {
      return false;
    }

    if (input.isEmpty) {
      return false;
    }

    return true;
  }

  static bool isNumber(String v) {
    if (double.tryParse(v) != null) {
      return true;
    } else {
      return false;
    }
  }

  /// 车牌校验 （新能源+非新能源）
  static bool vehiclePlateValidator(String? value) {
    final plateRegex = RegExp(
      r"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使][A-HJ-NP-Z][A-HJ-NP-Z0-9]{4,5}[A-HJ-NP-Z0-9挂学警港澳领]$",
    );
    if (plateRegex.hasMatch(value!)) return true;
    return false;
  }
}
