import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import 'add_education_info_screen.dart';
import 'add_personal_info_screen.dart';

class KeepAlivePage extends StatefulWidget {
  const KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class Validation {
  late bool Function() validatePersonalInfo;
  late bool Function() validateEducationalInfo;
}

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  Validation validation = Validation();

  PageController controller = PageController();
  late List<Widget> _list;
  final titles = ['اطلاعات شخصی', 'اطلاعات تحصیلی'];
  int _currentScreen = 0;

  @override
  void initState() {
    _list = <Widget>[
      KeepAlivePage(
          child: AddPersonalInfoScreen(
        validation: validation,
      )),
      KeepAlivePage(child: AddEducationInfoScreen(validation: validation,)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titles[_currentScreen]),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: (num) {
            setState(() {
              _currentScreen = num;
            });
          },
          children: _list,
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    if (_currentScreen == 0) {
                      if (!validation.validatePersonalInfo.call()) {
                        controller.jumpToPage(_currentScreen + 1);
                      }
                    } else if (validation.validateEducationalInfo.call()) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(152, 48),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallRadius),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.navigate_before),
                      Text((_currentScreen == 0) ? "بعدی" : "تایید"),
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_currentScreen > 0) {
                        controller.jumpToPage(_currentScreen - 1);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(152, 48),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallRadius),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("قبلی"),
                      Icon(Icons.navigate_next),
                    ],
                  )),
            ]));
  }
}
