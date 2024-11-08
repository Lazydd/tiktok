library app_update;

import 'dart:io';

import 'package:tiktok/common/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/common/values/lotties.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';
import 'package:device_info_plus/device_info_plus.dart';

part 'controller.dart';
part 'view.dart';
