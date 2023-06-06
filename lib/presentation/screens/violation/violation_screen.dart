import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_bloc.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_event.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../../config/theme.dart';
import '../../../utils/constant.dart';
import '../../blocs/violation/violation_state.dart';
import '../../widgets/drop_down_widget.dart';
import 'add_violation_screen.dart';

class ViolationScreen extends StatefulWidget {
  const ViolationScreen({Key? key}) : super(key: key);

  @override
  State<ViolationScreen> createState() => _ViolationState();
}

class _ViolationState extends State<ViolationScreen> {
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
      () => Provider.of<ViolationBloc>(context, listen: false)
          .add(const ViolationEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ViolationBloc, ViolationState>(builder: (context, state) {
      _createHeaders();
      if (state is ViolationLoading) {
        _sourceOriginal.clear();
        _sourceFiltered = _sourceOriginal;
        _source = _sourceFiltered.toList();
        _isLoading = true;
      } else if (state is ViolationSuccess) {
        _sourceOriginal.clear();
        _sourceOriginal.addAll(state.violations);
        _sourceFiltered = _sourceOriginal;
        _source = _sourceFiltered.toList();
        _isLoading = false;
      } else if (state is ViolationEmpty) {
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
                          'اطلاعات تخلفات',
                          style: TextStyle(fontSize: 16, fontWeight: bold),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: ((context) {
                                  return const AddViolationScreen();
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
                              'افزودن تخلفات',
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
                                            maxLength: 20,
                                            onChanged: (text) {
                                              violationFilter["StudentNumber"] =
                                                  text;
                                            },
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
                          items: [for (var i = 1380; i <= 1401; i++) i]
                              .map((e) => "${(e)}/06/30")
                              .toList(),
                          label: "نیمسال ورودی",
                          onChanged: (value) {
                            violationFilter["EntrySemester"] =
                                (value == 'همه') ? '-1' : value;
                          },
                        ),
                        DropDownWidget(
                          items: ["خاص", "عادی"],
                          label: "نوع تخلف",
                          onChanged: (value) {
                            violationFilter["ViolationCode"] = (value == 'همه')
                                ? '-1'
                                : (value == 'خاص')
                                    ? '1'
                                    : '2';
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: xLargeDistance),
                          child: ElevatedButton(
                              onPressed: () {
                                Future.microtask(
                                  () => Provider.of<ViolationBloc>(context,
                                          listen: false)
                                      .add(const ViolationEvent()),
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
      "شماره دانشجویی": 98484112,
      "نام": "احمد",
      "نام خانوادگی": "سلیمی",
      "نوع تخلف": "عادی",
      "شرح تخلف": "انجام اعمال خلاف اخلاق",
      "نتیجه نهایی بررسی": "تأیید و اخذ تعهد"
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
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(2),
          value: _keys.elementAt(2),
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(3),
          value: _keys.elementAt(3),
          show: true,
          editable: true,
          sourceBuilder: (value, row) {
            return Center(
                child: DropDownWidget(
              items: ["خاص", "عادی"],
              selectedValue: value,
              onChanged: (value) {
                row['نوع تخلف'] = value;

                Future.microtask(() =>
                    Provider.of<ViolationBloc>(context, listen: false)
                        .add(UpdateViolationEvent(row)));
              },
            ));
          },
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(4),
          value: _keys.elementAt(4),
          show: true,
          flex: 3,
          sourceBuilder: (value, row) {
            return Center(
                child: DropDownWidget(
              width: 340,
              items: [
                "ایجاد مزاحمت و سر و صدا",
                "نوشتن شعارهای مغایر اصول و موازین اسلامی",
                "انجام اعمال خلاف اخلاق",
                "مصرف،فروش و کشت مواد مخدر",
                "حمل سلاح گرم یا سرد",
                "ارتکاب قتل"
              ],
              selectedValue: value,
              onChanged: (value) {
                row['شرح تخلف'] = value;

                Future.microtask(() =>
                    Provider.of<ViolationBloc>(context, listen: false)
                        .add(UpdateViolationEvent(row)));
              },
            ));
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(5),
          value: _keys.elementAt(5),
          show: true,
          editable: true,
          flex: 2,
          sourceBuilder: (value, row) {
            return Center(
              child: DropDownWidget(
                items: [
                  "تأیید و اخذ تعهد",
                  "تأیید و تشکیل پرونده انضباطی",
                  "عدم تأیید"
                ],
                width: 260,
                selectedValue: value,
                onChanged: (value) {
                  row['نتیجه نهایی بررسی'] = value;

                  Future.microtask(
                    () => Provider.of<ViolationBloc>(context, listen: false)
                        .add(UpdateViolationEvent(row)),
                  );
                },
              ),
            );
          },
          sortable: false,
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
          onSubmittedRow: (value, header) {
            Future.microtask(
              () => Provider.of<ViolationBloc>(context, listen: false)
                  .add(UpdateViolationEvent(value)),
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
