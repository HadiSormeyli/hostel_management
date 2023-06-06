import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_management/config/theme.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_event.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_event.dart';
import 'package:hostel_management/presentation/blocs/student_bloc/student_bloc.dart';
import 'package:hostel_management/presentation/blocs/student_bloc/student_event.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_bloc.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_event.dart';
import 'package:hostel_management/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../blocs/student_bloc/student_state.dart';
import '../../widgets/drop_down_widget.dart';
import 'add_student_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController searchController = TextEditingController();
  final _searchKey = GlobalKey<FormState>();

  late List<DatatableHeader> _headers;

  final List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<StudentBloc>(context, listen: false)
          .add(const StudentEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      _createHeaders();
      if (state is StudentLoading) {
        _sourceOriginal.clear();
        _sourceFiltered = _sourceOriginal;
        _source = _sourceFiltered.toList();
        _isLoading = true;
      } else if (state is StudentSuccess) {
        _sourceOriginal.clear();
        _sourceOriginal.addAll(state.students);
        _sourceFiltered = _sourceOriginal;
        _source = _sourceFiltered.toList();
        _isLoading = false;
      } else if (state is StudentEmpty) {
        _isLoading = false;
      }

      return Container(
          margin: const EdgeInsets.all(smallDistance),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: const EdgeInsets.all(smallDistance),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'اطلاعات دانشجویان',
                          style: TextStyle(fontSize: 16, fontWeight: bold),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: ((context) {
                                  return const AddStudentScreen();
                                }),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: const Size(152, 48),
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(smallRadius),
                              ),
                            ),
                            child: const Text(
                              'افزودن',
                              style: TextStyle(
                                fontWeight: bold,
                              ),
                            ))
                      ],
                    )),
                Card(
                  elevation: 4,
                  shadowColor: Colors.black,
                  clipBehavior: Clip.none,
                  child: Container(
                    padding: const EdgeInsets.all(smallDistance),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                margin: const EdgeInsets.all(smallDistance),
                                width: 288,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.all(smallDistance),
                                      child: const Text('دنبال چی میگردی؟'),
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: Form(
                                          key: _searchKey,
                                          child: TextFormField(
                                            onChanged: (text) {
                                              studentFilter["StudentNumber"] =
                                                  text;
                                            },
                                            maxLength: 20,
                                            controller: searchController,
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              counterText: "",
                                              hintText: 'جستجو شماره دانشجویی',
                                              hintStyle: TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.3)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mediumRadius),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mediumRadius),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mediumRadius),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mediumRadius),
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                ))),
                        DropDownWidget(
                          items: ["روزانه", "شبانه"],
                          label: "نوع پذیرش",
                          onChanged: (value) {
                            studentFilter["AcceptanceType"] = (value == "همه")
                                ? '-1'
                                : (value == "روزانه")
                                    ? '1'
                                    : '2';
                          },
                        ),
                        DropDownWidget(
                          items: ["فعال", "غیرفعال"],
                          label: "وضعیت فعالی",
                          onChanged: (value) {
                            studentFilter["ActiveCheckStatus"] =
                                (value == "همه")
                                    ? '-1'
                                    : (value == "فعال")
                                        ? '1'
                                        : '2';
                          },
                        ),
                        DropDownWidget(
                          items: ["بومی", "غیربومی"],
                          label: "نوع سکونت",
                          onChanged: (value) {
                            studentFilter["Residence"] = (value == "همه")
                                ? '-1'
                                : (value == "بومی")
                                    ? '1'
                                    : '0';
                          },
                        ),
                        DropDownWidget(
                          items: [for (var i = 1380; i <= 1401; i++) i]
                              .map((e) => "${(e)}/06/30")
                              .toList(),
                          label: "نیمسال ورودی",
                          onChanged: (value) {
                            studentFilter["EntrySemester"] =
                                (value == 'همه') ? '-1' : value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: xLargeDistance),
                          child: ElevatedButton(
                              onPressed: () {
                                Future.microtask(
                                  () => Provider.of<StudentBloc>(context,
                                          listen: false)
                                      .add(const StudentEvent()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: primaryColor,
                                minimumSize: const Size(152, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(smallRadius),
                                ),
                              ),
                              child: const Text(
                                'جستجو',
                                style: TextStyle(
                                  fontWeight: bold,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(child: _buildTable()),
              ]));
    }));
  }

  void _createHeaders() {
    Map<String, dynamic> sample = {
      "کدملی": 312243542,
      "نام": "سیامک",
      "نام خانوادگی": "نعمتی",
      "کدپستی": 313562323,
      "آدرس": "چهارراه نیکان-بلوار بیهقی-کوچه غفوری-پلاک24-واحد12",
      "استان": "البرز",
      "شهر": "کرج",
      "شماره دانشجویی": 98321406,
      "تاریخ شروع به تحصیل": "1398/06/30",
      "ترم ورود": "نیمسال اول98-99",
      "وضعیت فعال بودن دانشجو": "فعال",
      "نوع پذیرش": "روزانه"
    };
    final _keys = sample.entries.toList().map((e) => e.key);
    _headers = [
      DatatableHeader(
          text: _keys.elementAt(0),
          value: _keys.elementAt(0),
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(1),
          value: _keys.elementAt(1),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(2),
          value: _keys.elementAt(2),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(3),
          flex: 2,
          value: _keys.elementAt(3),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(4),
          value: _keys.elementAt(4),
          show: true,
          flex: 6,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(5),
          value: _keys.elementAt(5),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(6),
          value: _keys.elementAt(6),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(7),
          value: _keys.elementAt(7),
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(8),
          value: _keys.elementAt(8),
          show: true,
          flex: 2,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(9),
          value: _keys.elementAt(9),
          show: true,
          flex: 2,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(10),
          value: _keys.elementAt(10),
          show: true,
          flex: 2,
          editable: true,
          sortable: false,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: ["فعال", "غیرفعال"],
              selectedValue: value,
              onChanged: (value) {
                row['وضعیت فعال بودن دانشجو'] = value;

                Future.microtask(
                      () => Provider.of<StudentBloc>(context, listen: false)
                      .add(UpdateStudentEvent(row)),
                );
              },
            );
          },
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(11),
          value: _keys.elementAt(11),
          show: true,
          flex: 2,
          editable: true,
          sortable: false,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: ["روزانه", "شبانه"],
              selectedValue: value,
              onChanged: (value) {
                row['نوع پذیرش'] = value;

                Future.microtask(
                      () => Provider.of<StudentBloc>(context, listen: false)
                      .add(UpdateStudentEvent(row)),
                );
              },
            );
          },
          textAlign: TextAlign.center),
    ];
  }

  Widget _buildTable() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Container(
        padding: const EdgeInsets.only(top: smallDistance),
        child: ResponsiveDatatable(
          expanded: List.generate(_source.length, (index) => false),
          reponseScreenSizes: const [ScreenSize.xs],
          headers: _headers,
          source: _source,
          showSelect: false,
          autoHeight: false,
          onChangedRow: (value, header) {},
          onSubmittedRow: (value, header) async {
            await Future.microtask(
                  () => Provider.of<StudentBloc>(context, listen: false)
                  .add(UpdateStudentEvent(value)),
            );

            Future.microtask(
                  () => Provider.of<DormBloc>(context, listen: false)
                  .add(const DormEvent()),
            );

            Future.microtask(
                  () => Provider.of<DormFinanceBloc>(context, listen: false)
                  .add(const DormFinanceEvent()),
            );

            Future.microtask(
                  () => Provider.of<ViolationBloc>(context, listen: false)
                  .add(const ViolationEvent()),
            );
          },
          onTabRow: (data) {},
          onSort: (value) {},
          isLoading: _isLoading,
          selecteds: const [],
          headerDecoration: const BoxDecoration(
              color: actionColor,
              border:
                  Border(bottom: BorderSide(color: primaryColor, width: 1))),
          selectedDecoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.green[300]!, width: 1)),
            color: Colors.green,
          ),
          headerTextStyle: const TextStyle(color: Colors.white),
          rowTextStyle: const TextStyle(color: Colors.green),
          selectedTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
