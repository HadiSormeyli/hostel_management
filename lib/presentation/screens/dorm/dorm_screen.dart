import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_event.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_state.dart';
import 'package:hostel_management/presentation/screens/dorm/add_dorm_screen.dart';
import 'package:hostel_management/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../../config/theme.dart';
import '../../widgets/drop_down_widget.dart';

class DormScreen extends StatefulWidget {
  const DormScreen({Key? key}) : super(key: key);

  @override
  State<DormScreen> createState() => _DormScreenState();
}

class _DormScreenState extends State<DormScreen> {
  late List<DatatableHeader> _headersStudent;
  late List<DatatableHeader> _headersDorm;

  int _currentScreen = 0;
  PageController controller = PageController();

  final List<List<Map<String, dynamic>>> _source = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () =>
          Provider.of<DormBloc>(context, listen: false).add(const DormEvent()),
    );
  }

  void _createHeadersStudent() {
    Map<String, dynamic> sample = {
      "نام": "احمد",
      "نام خانوادگی": "سلیمی",
      "شماره دانشجویی": 98484112,
      "رشته تحصیلی": "مهندسی مکانیک",
      "گروه": "مهندسی مکانیک",
      "نوع پذیرش": "روزانه",
      "مقطع": "کارشناسی",
      "دانشکده": "مهندسی",
      "وضعیت فعال بودن دانشجو": "فعال",
      "شماره اتاق": 2,
      "ظرفیت اتاق": 5,
      "نام خوابگاه": "شهید فرجامی\r\n\r\n",
      "تاریخ شروع به تحصیل": "1398/06/30"
    };
    final _keys = sample.entries.toList().map((e) => e.key);
    _headersStudent = [
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
          flex: 4,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: [
                "مهندسی صنایع",
                "مهندسی مکانیک",
                "مهندسی عمران",
                "مهندسی برق",
                "شیمی محض",
                "روانشناسی"
              ],
              selectedValue: value,
              onChanged: (value) {
                row['رشته تحصیلی'] = value;

                Future.microtask(
                  () => Provider.of<DormBloc>(context, listen: false)
                      .add(UpdateStudentDormEvent(row)),
                );
              },
            );
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(4),
          value: _keys.elementAt(4),
          flex: 4,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: [
                "مهندسی صنایع",
                "مهندسی مکانیک",
                "مهندسی عمران",
                "مهندسی برق",
                "شیمی محض",
                "روانشناسی"
              ],
              selectedValue: value,
              onChanged: (value) {
                row['گروه'] = value;

                Future.microtask(
                  () => Provider.of<DormBloc>(context, listen: false)
                      .add(UpdateStudentDormEvent(row)),
                );
              },
            );
          },
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(5),
          value: _keys.elementAt(5),
          show: true,
          flex: 2,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(6),
          value: _keys.elementAt(6),
          show: true,
          flex: 3,
          sourceBuilder: (value, row) {
            return DropDownWidget(
                items: ["کارشناسی", "ارشد", "دکترا"],
                onChanged: (value) {
                  row['مقطع'] = value;

                  Future.microtask(
                    () => Provider.of<DormBloc>(context, listen: false)
                        .add(UpdateStudentDormEvent(row)),
                  );
                },
                selectedValue: value);
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(7),
          value: _keys.elementAt(7),
          show: true,
          flex: 3,
          sourceBuilder: (value, row) {
            return Center(
              child: DropDownWidget(
                  items: ["مهندسی", "انسانی", "علوم"],
                  onChanged: (value) {
                    row['دانشکده'] = value;

                    Future.microtask(
                      () => Provider.of<DormBloc>(context, listen: false)
                          .add(UpdateStudentDormEvent(row)),
                    );
                  },
                  selectedValue: value),
            );
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(8),
          value: _keys.elementAt(8),
          show: true,
          flex: 2,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(9),
          value: _keys.elementAt(9),
          show: true,
          flex: 2,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: [for (var i = 1; i < 23; i++) i].map((e) => "$e").toList(),
              selectedValue: value.toString(),
              onChanged: (value) {
                row['شماره اتاق'] = value;

                Future.microtask(
                  () => Provider.of<DormBloc>(context, listen: false)
                      .add(UpdateStudentDormEvent(row)),
                );
              },
            );
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(10),
          value: _keys.elementAt(10),
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(11),
          value: _keys.elementAt(11),
          show: true,
          flex: 4,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: [
                "شهید عسگری نژاد",
                "شهید بابازاده",
                "شهید فرجامی",
                "شهید ناصر بخت",
                "شهید علیخانی",
                "شهید نوری",
                "روغنی زنجانی",
                "دکترا 2"
              ],
              selectedValue: value.toString().trim(),
              onChanged: (value) {
                row['نام خوابگاه'] = value;

                Future.microtask(
                  () => Provider.of<DormBloc>(context, listen: false)
                      .add(UpdateStudentDormEvent(row)),
                );
              },
            );
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(12),
          value: _keys.elementAt(12),
          show: true,
          flex: 2,
          sortable: false,
          textAlign: TextAlign.center),
    ];
  }

  void _createHeadersDorm() {
    Map<String, dynamic> sample = {
      "شماره دانشجویی": "شهید نوری\r\n\r\n",
      "نام خوابگاه": "شهید نوری\r\n\r\n",
      "شماره اتاق": 6,
      "اموال خوابگاه": "موکت",
      "وضعیت موجودی اموال خوابگاه": "موجود"
    };
    final _keys = sample.entries.toList().map((e) => e.key);
    _headersDorm = [
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
          sourceBuilder: (value, row) {
            return Center(
                child: DropDownWidget(
              items: ["میز", "موکت", "توری", "فرش", "صندلی", "نوپان", "کلید"],
              selectedValue: value,
              onChanged: (value) {
                row['اموال خوابگاه'] = value;

                Future.microtask(
                  () => Provider.of<DormBloc>(context, listen: false)
                      .add(UpdateDormEvent(row)),
                );
              },
            ));
          },
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(4),
          value: _keys.elementAt(4),
          sourceBuilder: (value, row) {
            return Center(
              child: DropDownWidget(
                items: ["موجود", "ناموجود"],
                selectedValue: value,
                onChanged: (value) {
                  row['وضعیت موجودی اموال خوابگاه'] = value;

                  Future.microtask(
                    () => Provider.of<DormBloc>(context, listen: false)
                        .add(UpdateDormEvent(row)),
                  );
                },
              ),
            );
          },
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<DormBloc, DormState>(builder: (context, state) {
      _createHeadersStudent();
      _createHeadersDorm();
      if (state is DormLoading) {
        _source.clear();
        _isLoading = true;
      } else if (state is DormSuccess) {
        _source.clear();
        _source.addAll(state.dorms);
        _isLoading = false;
      } else if (state is DormEmpty) {
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
                        'اطلاعات خوابگاه',
                        style: TextStyle(fontSize: 16, fontWeight: bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: ((context) {
                                return const AddDormScreen();
                              }),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: const Size(152, 48),
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(smallRadius),
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
                        child: DropDownWidget(
                            width: double.infinity,
                            items: [
                              "شهید عسگری نژاد",
                              "شهید بابازاده",
                              "شهید فرجامی",
                              "شهید ناصر بخت",
                              "شهید علیخانی",
                              "شهید نوری",
                              "روغنی زنجانی",
                              "دکتر2"
                            ],
                            onChanged: (value) {
                              dormFilter['HostelCode'] = (value != 'همه')
                                  ? ([
                                            "شهید عسگری نژاد",
                                            "شهید بابازاده",
                                            "شهید فرجامی",
                                            "شهید ناصر بخت",
                                            "شهید علیخانی",
                                            "شهید نوری",
                                            "روغنی زنجانی",
                                            "دکتر2"
                                          ].indexOf(value) +
                                          1)
                                      .toString()
                                  : '-1';
                            },
                            label: "نام خوابگاه"),
                      ),
                      DropDownWidget(
                        items: [for (var i = 1; i < 23; i++) i]
                            .map((e) => "$e")
                            .toList(),
                        label: "شماره اتاق",
                        onChanged: (value) {
                          dormFilter['RoomNumber'] = (value != 'همه')
                              ? ([for (var i = 1; i < 23; i++) i]
                                          .map((e) => "$e")
                                          .toList()
                                          .indexOf(value) +
                                      1)
                                  .toString()
                              : '-1';
                        },
                      ),
                      DropDownWidget(
                        items: [
                          "میز",
                          "موکت",
                          "توری",
                          "فرش",
                          "صندلی",
                          "نوپان",
                          "کلید"
                        ],
                        label: "اموال خوابگاه",
                        onChanged: (value) {
                          dormFilter['HostelPropertyCode'] = (value != 'همه')
                              ? ([
                                        "میز",
                                        "موکت",
                                        "توری",
                                        "فرش",
                                        "صندلی",
                                        "نوپان",
                                        "کلید"
                                      ].indexOf(value) +
                                      1)
                                  .toString()
                              : '-1';
                        },
                      ),
                      DropDownWidget(
                        items: ["موجود", "ناموجود"],
                        label: "وضعیت موجودی اموال خوابگاه",
                        onChanged: (value) {
                          dormFilter['InventoryOfTheHostelPropertyCode'] =
                              (value != 'همه')
                                  ? (["موجود", "ناموجود"].indexOf(value) + 1)
                                      .toString()
                                  : '-1';
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: xLargeDistance),
                        child: ElevatedButton(
                            onPressed: () {
                              Future.microtask(
                                () => Provider.of<DormBloc>(context,
                                        listen: false)
                                    .add(const DormEvent()),
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
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  onPageChanged: (num) {
                    setState(() {
                      _currentScreen = num;
                    });
                  },
                  children: [
                    _buildTable(_headersStudent,
                        (_source.length > 1) ? _source[1] : List.empty()),
                    _buildTable(_headersDorm,
                        (_source.isNotEmpty) ? _source[0] : List.empty()),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(smallDistance)),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_currentScreen == 1) {
                            setState(() {
                              controller.jumpToPage(_currentScreen - 1);
                            });
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: smallDistance,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(smallDistance)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          if (_currentScreen == 0) {
                            setState(() {
                              controller.jumpToPage(_currentScreen + 1);
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              )
            ]),
      );
    }));
  }

  Widget _buildTable(
      List<DatatableHeader> headers, List<Map<String, dynamic>> source) {
    return Card(
        elevation: 4,
        shadowColor: Colors.black,
        clipBehavior: Clip.none,
        child: Container(
          padding: const EdgeInsets.only(top: smallDistance),
          child: ResponsiveDatatable(
            expanded: List.generate(source.length, (index) => false),
            reponseScreenSizes: const [ScreenSize.xs],
            headers: headers,
            source: source,
            showSelect: false,
            autoHeight: false,
            onChangedRow: (value, header) {},
            onSubmittedRow: (value, header) {},
            onTabRow: (data) {},
            onSort: (value) {},
            isLoading: _isLoading,
            selecteds: const [],
            headerDecoration: const BoxDecoration(
                color: actionColor,
                border:
                    Border(bottom: BorderSide(color: primaryColor, width: 1))),
            selectedDecoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.green[300]!, width: 1)),
              color: Colors.green,
            ),
            headerTextStyle: const TextStyle(color: Colors.white),
            rowTextStyle: const TextStyle(color: Colors.green),
            selectedTextStyle: const TextStyle(color: Colors.white),
          ),
        ));
  }
}
