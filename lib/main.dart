import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hostel_management/di/injection.dart' as di;
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_bloc.dart';
import 'package:hostel_management/presentation/blocs/student_bloc/student_bloc.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_bloc.dart';
import 'package:hostel_management/presentation/screens/dorm/dorm_screen.dart';
import 'package:hostel_management/presentation/screens/dorm_finance/dorm_finance_screen.dart';
import 'package:hostel_management/presentation/screens/student/student_screen.dart';
import 'package:hostel_management/presentation/screens/violation/violation_screen.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import 'config/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final widgets = [
    const StudentScreen(),
    const DormScreen(),
    const DormFinanceScreen(),
    const ViolationScreen()
  ];

  final _controller = SidebarXController(selectedIndex: 0);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<StudentBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DormBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ViolationBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DormFinanceBloc>(),
          )
        ],
        child: MaterialApp(
          title: 'SidebarX Example',
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("fa", "IR"),
          ],
          locale: const Locale("fa", "IR"),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: colorScheme,
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
                    itemTextPadding:
                        const EdgeInsets.only(right: xLargeDistance),
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
                        child: Image.asset('assets/images/znu.png'),
                      ),
                    );
                  },
                  items: [
                    SidebarXItem(
                        icon: Icons.person,
                        label: 'دانشجو',
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        }),
                    SidebarXItem(
                        icon: Icons.bed,
                        label: 'خوابگاه',
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        }),
                    SidebarXItem(
                        icon: Icons.money,
                        label: 'مالی',
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        }),
                    SidebarXItem(
                        icon: Icons.dangerous_outlined,
                        label: 'تخلفات',
                        onTap: () {
                          setState(() {
                            _selectedIndex = 3;
                          });
                        }),
                  ],
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: widgets,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

final divider = Divider(color: white.withOpacity(0.3), height: 1);
