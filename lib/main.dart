import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hostel_management/presentaion/screens/student/student_screen.dart';
import 'package:sidebarx/sidebarx.dart';

import 'config/theme.dart';

void main() {
  runApp(SidebarXExampleApp());
}

class SidebarXExampleApp extends StatelessWidget {
  SidebarXExampleApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("fa", "IR"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          canvasColor: canvasColor,
          cardColor: canvasColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          iconTheme: iconTheme,
          textTheme: textTheme),
      home: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: _controller,
              theme: SidebarXTheme(
                margin: const EdgeInsets.all(smallDistance),
                decoration: BoxDecoration(
                  color: canvasColor,
                  borderRadius: BorderRadius.circular(mediumRadius),
                ),
                textStyle: const TextStyle(color: Colors.white),
                selectedTextStyle: const TextStyle(color: Colors.white),
                itemTextPadding: const EdgeInsets.only(right: xLargeDistance),
                selectedItemTextPadding:
                    const EdgeInsets.only(right: xLargeDistance),
                itemDecoration: BoxDecoration(
                  border: Border.all(color: canvasColor),
                ),
                selectedItemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(smallRadius),
                  border: Border.all(
                    color: actionColor.withOpacity(0.37),
                  ),
                  gradient: const LinearGradient(
                    colors: [accentCanvasColor, canvasColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.28),
                      blurRadius: xLargeRadius,
                    )
                  ],
                ),
              ),
              extendedTheme: const SidebarXTheme(
                width: 200,
                decoration: BoxDecoration(
                  color: canvasColor,
                ),
                margin: EdgeInsets.only(left: smallDistance),
              ),
              footerDivider: divider,
              headerBuilder: (context, extended) {
                return SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(mediumDistance),
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                );
              },
              items: const [
                SidebarXItem(
                  icon: Icons.home,
                  label: 'خانه',
                ),
                SidebarXItem(
                  icon: Icons.search,
                  label: 'جستجو',
                ),
                SidebarXItem(
                  icon: Icons.people,
                  label: 'مردم',
                ),
                SidebarXItem(
                  icon: Icons.favorite,
                  label: 'موردعلاقه',
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: _ScreensExample(controller: _controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const DataPage();
          case 1:
            return Text(
              'جستجو',
              style: theme.textTheme.headlineSmall,
            );
          case 2:
            return Text(
              'مردم',
              style: theme.textTheme.headlineSmall,
            );
          case 3:
            return Text(
              'موردعلاقه',
              style: theme.textTheme.headlineSmall,
            );
          case 4:
            return Text(
              'پروفایل',
              style: theme.textTheme.headlineSmall,
            );
          case 5:
            return Text(
              'تنظیمات',
              style: theme.textTheme.headlineSmall,
            );
          default:
            return Text(
              'وجود ندارد!',
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

final divider = Divider(color: white.withOpacity(0.3), height: 1);
