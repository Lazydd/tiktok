part of 'index.dart';

class SystemConfigPage extends GetView<SystemConfigController> {
  const SystemConfigPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    final theme = AppTheme.of(context);
    return ListView(
      children: [
        CupertinoFormSection(
          header: const Text('通用'),
          children: [
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.settings,
                color: CupertinoColors.systemGrey,
              ),
              title: Text('通用设置', style: TextStyle(color: theme.textColor70)),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                Get.toNamed(RouteNames.generalRoute);
              },
            ),
          ],
        ),
        CupertinoFormSection(
          header: const Text('关于'),
          children: [
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.arrow_2_circlepath,
                color: CupertinoColors.systemGrey,
              ),
              title: Text('软件更新', style: TextStyle(color: theme.textColor70)),
              additionalInfo: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemRed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              trailing: const CupertinoListTileChevron(),
              onTap: () async {
                if (Platform.isAndroid) {
                  Get.toNamed(RouteNames.appUpdateRoute);
                } else {
                  String appStoreUrl =
                      'https://apps.apple.com/app/${Constants.iOSAppId}';
                  if (await canLaunchUrl(Uri(path: appStoreUrl))) {
                    await launchUrl(Uri(path: appStoreUrl));
                  } else {
                    throw 'Could not launch $appStoreUrl';
                  }
                }
              },
            ),
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.exclamationmark_circle,
                color: CupertinoColors.systemGrey,
              ),
              title: Text('关于抖音', style: TextStyle(color: theme.textColor70)),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                debugPrint('Tapped on Software Update');
              },
            ),
          ],
        ),
        CupertinoFormSection(
          children: [
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.square_arrow_right,
                color: CupertinoColors.systemGrey,
              ),
              title: Text('退出登录', style: TextStyle(color: theme.textColor70)),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemConfigController>(
      init: SystemConfigController(),
      id: "system_config",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("设置")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
