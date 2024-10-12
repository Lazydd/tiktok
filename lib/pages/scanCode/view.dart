part of scancode;

// 扫码框宽高
final cutOutWidth = ScreenFunc.screenWidth - 70;
final cutOutHeight = ScreenFunc.screenWidth - 70;

// 底部高度
const bottomBarHeight = 100.0;

// 扫码线的高度
const scanLineHeight = 70.0;

class ScanCodePage extends GetView<ScanCodeController> {
  const ScanCodePage({
    Key? key,
  }) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: QRView(
              key: GlobalKey(debugLabel: controller.qrKey.toString()),
              onQRViewCreated: (controller) async {
                await _onQRViewCreated(controller);
              }),
        ),
        // 遮罩层
        Positioned(
          top: 0,
          left: 0,
          child: CustomPaint(
            painter: _ScanFramePainter(),
          ),
        ),
        // 闪光灯
        Positioned(
          top: (ScreenFunc.screenHeight - cutOutHeight) / 2 -
              bottomBarHeight +
              cutOutHeight +
              60,
          child: GetBuilder<ScanCodeController>(
            id: "scan_code_flash",
            builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(58, 59, 61, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _.isFlash
                          ? Icons.flash_off_rounded
                          : Icons.flash_on_rounded,
                      color: Colors.white,
                      size: 20,
                    ).paddingLeft(2).paddingTop(3),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _.isFlash ? "关闭" : "开启",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ).onTap(() {
                controller.openFlash();
              });
            },
          ),
        ),

        Positioned(
          bottom: 10,
          child: SizedBox(
            width: cutOutWidth,
            child: Text(
              "扫描二维码，读取信息",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ),
        Positioned(
          top: (ScreenFunc.screenHeight - cutOutHeight) / 2 -
              bottomBarHeight -
              20,
          child: const LoopVerticalAnimation(),
        ),
      ],
    );
  }

  /// 扫码结果
  Future _onQRViewCreated(QRViewController qrViewController) async {
    controller.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen((scanData) {
      String code = scanData.code ?? "";
      if (code.isNotEmpty) {
        qrViewController.pauseCamera();
        qrViewController.dispose();
        Get.back(result: code);
      }
    });
  }

  /// 底部bottom
  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      height: bottomBarHeight,
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 5.0),
            blurRadius: 25.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "扫一扫",
            style: TextStyle(
              color: Color.fromRGBO(19, 199, 95, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: 5.0,
            height: 5.0,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(19, 199, 95, 1),
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanCodeController>(
      init: ScanCodeController(),
      id: "scan_code",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 64,
            leading: IconWidget.svg(
              AssetsSvgs.commonExpandBackSvg,
              color: const Color.fromRGBO(227, 224, 231, 1),
            ).padding(all: 12).onTap(() {
              Get.back();
            }),
          ),
          extendBodyBehindAppBar: true,
          body: _buildView(),
          bottomNavigationBar: _buildBottomBar(),
          backgroundColor: Colors.black,
        );
      },
    );
  }
}

class LoopVerticalAnimation extends StatefulWidget {
  const LoopVerticalAnimation({Key? key}) : super(key: key);

  @override
  LoopVerticalAnimationState createState() => LoopVerticalAnimationState();
}

class LoopVerticalAnimationState extends State<LoopVerticalAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //将动画重置到开始前的状态
        controller.reset();
        //开始执行
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        //controller.forward();
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
      }
    });
    animation = Tween(
            begin: const Offset(0, 0),
            end: Offset(0, cutOutHeight / scanLineHeight))
        .animate(controller);

    //开始执行
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //SlideTransition 用于执行平移动画
      child: SlideTransition(
        position: animation,
        //将要执行动画的子view
        child: Container(
          width: cutOutWidth,
          height: scanLineHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0, 0.3, 0.7, 1],
              colors: [
                Color.fromRGBO(19, 199, 95, 0.3),
                Color.fromRGBO(19, 199, 95, 0.15),
                Color.fromRGBO(19, 199, 95, 0.05),
                Color.fromRGBO(0, 0, 0, 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  //默认定义扫描框为 260边长的正方形
  final Size frameSize = Size.square(cutOutWidth);
  @override
  void paint(Canvas canvas, Size size) {
    double leftTopX = ScreenFunc.screenWidth / 2 - frameSize.width / 2;
    double leftTopY = ScreenFunc.screenHeight / 2 -
        frameSize.height / 2 -
        bottomBarHeight / 2;
    double height = ScreenFunc.screenHeight - bottomBarHeight;

    var rect =
        Rect.fromLTWH(leftTopX, leftTopY, frameSize.width, frameSize.height);
    // 4个点的坐标
    Offset leftTop = rect.topLeft;
    Offset leftBottom = rect.bottomLeft;
    Offset rightTop = rect.topRight;
    Offset rightBottom = rect.bottomRight;
    //定义画笔
    Paint paint = Paint()..style = PaintingStyle.stroke; // 画笔的模式，填充还是只绘制边框

    //绘制正方形
    canvas.drawRect(rect, paint);

    //绘制罩层
    //画笔
    Paint bgPaint = Paint()
      ..color = const Color.fromRGBO(0, 0, 0, 0.6) //透明灰
      ..style = PaintingStyle.fill; // 画笔的模式，填充
    //左侧矩形
    canvas.drawRect(Rect.fromLTRB(0, 0, leftTopX, height), bgPaint);
    //右侧矩形
    canvas.drawRect(
      Rect.fromLTRB(rightTop.dx, 0, ScreenFunc.screenWidth, height),
      bgPaint,
    );
    //中上矩形
    canvas.drawRect(Rect.fromLTRB(leftTopX, 0, rightTop.dx, leftTopY), bgPaint);
    //中下矩形
    canvas.drawRect(
      Rect.fromLTRB(leftBottom.dx, leftBottom.dy, rightBottom.dx, height),
      bgPaint,
    );

    const double cornerLength = 20.0;
    paint
      ..color = Colors.white
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square // 解决因为线宽导致交界处不是直角的问题
      ..style = PaintingStyle.stroke;
    // 横向线条的坐标偏移
    Offset horizontalOffset = const Offset(cornerLength, 0);
    // 纵向线条的坐标偏移
    Offset verticalOffset = const Offset(0, cornerLength);
    // 左上角
    canvas.drawLine(leftTop, leftTop + horizontalOffset, paint);
    canvas.drawLine(leftTop, leftTop + verticalOffset, paint);
    // 左下角
    canvas.drawLine(leftBottom, leftBottom + horizontalOffset, paint);
    canvas.drawLine(leftBottom, leftBottom - verticalOffset, paint);
    // 右上角
    canvas.drawLine(rightTop, rightTop - horizontalOffset, paint);
    canvas.drawLine(rightTop, rightTop + verticalOffset, paint);
    // 右下角
    canvas.drawLine(rightBottom, rightBottom - horizontalOffset, paint);
    canvas.drawLine(rightBottom, rightBottom - verticalOffset, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
