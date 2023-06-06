import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_event.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_state.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../../config/theme.dart';
import '../../../utils/constant.dart';
import '../../widgets/drop_down_widget.dart';
import 'add_dorm_finance_screen.dart';

class DormFinanceScreen extends StatefulWidget {
  const DormFinanceScreen({Key? key}) : super(key: key);

  @override
  State<DormFinanceScreen> createState() => _DormFinanceScreenState();
}

class _DormFinanceScreenState extends State<DormFinanceScreen> {
  final TextEditingController searchController = TextEditingController();
  final _searchKey = GlobalKey<FormState>();

  late List<DatatableHeader> _headers;

  final List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];

  bool _isLoading = true;

  String dateLabel = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<DormFinanceBloc>(context, listen: false)
          .add(const DormFinanceEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<DormFinanceBloc, DormFinanceState>(
        builder: (context, state) {
      _createHeaders();
      if (state is DormFinanceLoading) {
        _sourceOriginal.clear();
        _sourceFiltered = _sourceOriginal;
        _source = _sourceFiltered.toList();
        _isLoading = true;
      } else if (state is DormFinanceSuccess) {
        _sourceOriginal.clear();
        _sourceOriginal.addAll(state.dormFinances);
        _sourceFiltered = _sourceOriginal;
        _source = _sourceFiltered.toList();
        _isLoading = false;
      } else if (state is DormFinanceEmpty) {
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
                          'اطلاعات مالی خوابگاه',
                          style: TextStyle(fontSize: 16, fontWeight: bold),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: ((context) {
                                  return const AddDormFinanceScreen();
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
                                            maxLength: 20,
                                            onChanged: (text) {
                                              dormFinancesFilter[
                                                  "StudentNumber"] = text;
                                            },
                                            controller: searchController,
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              counterText: "",
                                              hintText: 'جستجو نام خوابگاه',
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
                          items: ["تأیید", "عدم تأیید"],
                          label: "وضعیت بررسی",
                          onChanged: (value) {
                            dormFinancesFilter['FinancialReviewStatusCode'] =
                                (value == 'همه')
                                    ? '-1'
                                    : (value == 'تأیید')
                                        ? '1'
                                        : '2';
                          },
                        ),
                        const SizedBox(
                          width: smallDistance,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("تاریخ ورود به خوابگاه"),
                            const SizedBox(
                              height: smallDistance,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Jalali? picked = await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1385, 8),
                                  lastDate: Jalali(1450, 9),
                                );
                                if (picked != null) {
                                  setState(() {
                                    dateLabel =
                                        "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
                                    dormFinancesFilter[
                                        'DateOfArrivalAtTheHostel'] = dateLabel;
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: smallDistance),
                                alignment: Alignment.centerRight,
                                height: 48,
                                width: 248,
                                decoration: BoxDecoration(
                                  color: canvasColor,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.circular(mediumRadius),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text((dateLabel.isEmpty)
                                        ? 'تاریخ ورود'
                                        : dateLabel),
                                    if (dateLabel.isNotEmpty)
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              dateLabel = '';
                                              dormFinancesFilter[
                                                      'DateOfArrivalAtTheHostel'] =
                                                  '-1';
                                            });
                                          },
                                          icon: const Icon(Icons.clear))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: smallDistance,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: xLargeDistance),
                          child: ElevatedButton(
                              onPressed: () {
                                Future.microtask(
                                  () => Provider.of<DormFinanceBloc>(context,
                                          listen: false)
                                      .add(const DormFinanceEvent()),
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
      "شماره فیش": 1,
      "شماره دانشجویی": 95484106,
      "نام": "علیرضا",
      "نام خانوادگی": "بیرانوند",
      "تاریخ ورود به خوابگاه": "1395/04/30",
      "تاریخ خروج از خوابگاه": "1399/04/30",
      "مبلغ بدهی": 1,
      "نام کامل سرپرست خوابگاه": "علیرضا زمانلو",
      "توضیحات بخش خوابگاه": "بدهی ندارد",
      "تاریخ تسویه حساب": "1399/04/30",
      "تاریخ تکمیل فرم": "1399/04/24",
      "مبلغ واریزی": 400000,
      "تاریخ فیش": "1399/04/30",
      "وضعیت بررسی": "تأیید",
      "میزان خسارت وارده به اموال": "0"
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
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(4),
          flex: 2,
          value: _keys.elementAt(4),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(5),
          value: _keys.elementAt(5),
          show: true,
          flex: 2,
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
          flex: 2,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(8),
          value: _keys.elementAt(8),
          show: true,
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
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(11),
          value: _keys.elementAt(11),
          show: true,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(12),
          value: _keys.elementAt(12),
          show: true,
          flex: 2,
          editable: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(13),
          value: _keys.elementAt(13),
          show: true,
          editable: true,
          sortable: false,
          flex: 2,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: ["تأیید", "عدم تأیید"],
              selectedValue: value,
              onChanged: (value) {
                row['وضعیت بررسی'] = value;

                Future.microtask(
                      () => Provider.of<DormFinanceBloc>(context, listen: false)
                      .add(UpdateDormFinanceEvent(row)),
                );
              },
            );
          },
          textAlign: TextAlign.center),
      DatatableHeader(
          text: _keys.elementAt(14),
          value: _keys.elementAt(14),
          show: true,
          flex: 2,
          sourceBuilder: (value, row) {
            return DropDownWidget(
              items: ["20%", "40%","60%","80%","100%","0"],
              selectedValue: value,
              onChanged: (value) {
                row['میزان خسارت وارده به اموال'] = value;

                Future.microtask(
                      () => Provider.of<DormFinanceBloc>(context, listen: false)
                      .add(UpdateDormFinanceEvent(row)),
                );
              },
            );
          },
          editable: true,
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
                  () => Provider.of<DormFinanceBloc>(context, listen: false)
                  .add(UpdateDormFinanceEvent(value)),
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
