part of 'index.dart';

class GeneralPage extends GetView<GeneralController> {
  const GeneralPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    final provider = context.watch<ThemeProvider>();
    final mode = provider.mode;

    final theme = AppTheme.of(context);

    return ListView(
      children: [
        CupertinoFormSection(
          children: [
            CupertinoListTile(
              title: Text('更随系统', style: TextStyle(color: theme.textColor70)),
              subtitle: const Text('开启后，将跟随系统打开或关闭深色模式'),
              trailing: CupertinoSwitch(
                value: provider.isFollowSystem,
                onChanged: (bool value) {
                  if (value) {
                    provider.saveMode(ThemeMode.system);
                    provider.refresh();
                  } else {
                    final isDark = MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark;
                    provider
                        .saveMode(isDark ? ThemeMode.dark : ThemeMode.light);
                    provider.refresh();
                  }
                },
              ),
            ),
          ],
        ),
        if (!provider.isFollowSystem)
          CupertinoFormSection(
            header: const Text('手动选择'),
            children: [
              CupertinoListTile(
                title: Text('普通模式', style: TextStyle(color: theme.textColor70)),
                trailing: mode == ThemeMode.light
                    ? const Icon(
                        CupertinoIcons.checkmark,
                        color: Colors.green,
                      )
                    : const SizedBox(),
                onTap: () {
                  provider.saveMode(ThemeMode.light);
                  provider.refresh();
                },
              ),
              CupertinoListTile(
                title: Text('深色模式', style: TextStyle(color: theme.textColor70)),
                trailing: mode == ThemeMode.dark
                    ? const Icon(
                        CupertinoIcons.checkmark,
                        color: Colors.green,
                      )
                    : const SizedBox(),
                onTap: () {
                  provider.saveMode(ThemeMode.dark);
                  provider.refresh();
                },
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      init: GeneralController(),
      id: "general",
      builder: (_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text("通用设置"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
