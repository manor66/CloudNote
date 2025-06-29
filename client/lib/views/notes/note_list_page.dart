import 'package:client/core/utils/app_utils.dart';
import 'package:flutter/material.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appbar(context), drawer: _drawer(context), body: _body(context));
  }

  PreferredSizeWidget _appbar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text('备忘录', style: TextStyle(color: colorScheme.onPrimary)),
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: 0,
    );
  }

  Widget _drawer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colorScheme.primaryContainer),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, shape: BoxShape.circle),
                  child: ClipOval(child: Image.asset('assets/images/logo.png', fit: BoxFit.cover)),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('未命名', style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimaryContainer)),
                    Text('未设置', style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimaryContainer)),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.notes, color: colorScheme.onSurface),
            title: Text('所有笔记', style: textTheme.bodyLarge),
            trailing: Chip(
              label: Text('23', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSecondaryContainer)),
              backgroundColor: colorScheme.secondaryContainer,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline, color: colorScheme.onSurface),
            title: Text('已完成笔记', style: textTheme.bodyLarge),
            trailing: Chip(
              label: Text('8', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSecondaryContainer)),
              backgroundColor: colorScheme.secondaryContainer,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.radio_button_unchecked, color: colorScheme.onSurface),
            title: Text('未完成笔记', style: textTheme.bodyLarge),
            trailing: Chip(
              label: Text('15', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSecondaryContainer)),
              backgroundColor: colorScheme.secondaryContainer,
            ),
            onTap: () {},
          ),
          Divider(color: colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              '账号',
              style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: colorScheme.onSurface),
            title: Text('修改个人信息', style: textTheme.bodyLarge),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, color: colorScheme.onSurface),
            title: Text('退出登录', style: textTheme.bodyLarge),
            onTap: () {},
          ),
          if (!AppUtils.isWebPlatform())
            ListTile(
              leading: Icon(Icons.exit_to_app, color: colorScheme.onSurface),
              title: Text('退出应用', style: textTheme.bodyLarge),
              onTap: () => AppUtils.exitApp(),
            ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('笔记 $index', style: textTheme.bodyLarge),
          subtitle: Text('这是笔记的内容 $index', style: textTheme.bodySmall),
          onTap: () {
            // Handle note tap
          },
        );
      },
    );
  }
}
