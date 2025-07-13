import 'package:flutter/cupertino.dart';
import 'package:tiktok/common/theme/index.dart';

extension Context on BuildContext {
  AppTheme get theme => AppTheme.of(this);
}
