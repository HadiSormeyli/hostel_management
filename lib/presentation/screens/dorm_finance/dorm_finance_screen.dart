import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../../config/theme.dart';
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

  int _total = 100;
  final int _currentPerPage = 100;
  List<bool>? _expanded;

  final List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;

  String dateLabel = '';

  _initializeData() async {
    // _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      // _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
      _sourceFiltered = _sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, _currentPerPage).toList();
      setState(() => _isLoading = false);
    });
  }

  _resetData({start = 0}) async {
    setState(() => _isLoading = true);
    var expandedLen =
        _total - start < _currentPerPage ? _total - start : _currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _expanded = List.generate(expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = _sourceOriginal;
      } else {
        _sourceFiltered = _sourceOriginal
            .where((data) => data[_searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var rangeTop = _total < _currentPerPage ? _total : _currentPerPage;
      _expanded = List.generate(rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, rangeTop).toList();
    } catch (ignore) {
      //
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _headers = [
      DatatableHeader(
          text: "کدملی",
          value: "کدملی",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "نام",
          value: "نام",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "نام خانوادگی",
          value: "نام خانوادگی",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "کدپستی",
          value: "کدپستی",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "آدرس",
          value: "آدرس",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "استان",
          value: "استان",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "شهر",
          value: "شهر",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "تاریخ شروع به تحصیل",
          value: "تاریخ شروع به تحصیل",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "ترم ورود",
          value: "ترم ورود",
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "وضعیت فعال بودن دانشجو",
          value: "وضعیت فعال بودن دانشجو",
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "نوع پذیرش",
          value: "نوع پذیرش",
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
    ];

    //    _headers = [
    //       DatatableHeader(
    //           text: "شماره دانشجویی",
    //           value: "شماره دانشجویی",
    //           show: true,
    //           sortable: true,
    //           textAlign: TextAlign.center),
    //       DatatableHeader(
    //           text: "نام",
    //           value: "نام",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "نام خانوادگی",
    //           value: "نام خانوادگی",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "تاریخ ورود به خوابگاه",
    //           value: "تاریخ ورود به خوابگاه",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "تاریخ خروج از خوابگاه",
    //           value: "تاریخ خروج از خوابگاه",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "مبلغ بدهی",
    //           value: "مبلغ بدهی",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "نام کامل سرپرست خوابگاه",
    //           value: "نام کامل سرپرست خوابگاه",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "توضیحات بخش خوابگاه",
    //           value: "توضیحات بخش خوابگاه",
    //           show: true,
    //           sortable: true,
    //           editable: true,
    //           textAlign: TextAlign.right),
    //       DatatableHeader(
    //           text: "تاریخ تسویه حساب",
    //           value: "تاریخ تسویه حساب",
    //           show: true,
    //           sortable: false,
    //           textAlign: TextAlign.center),
    //       DatatableHeader(
    //           text: "تاریخ تکمیل فرم",
    //           value: "تاریخ تکمیل فرم",
    //           show: true,
    //           sortable: false,
    //           textAlign: TextAlign.center),
    //       DatatableHeader(
    //           text: "مبلغ واریزی",
    //           value: "مبلغ واریزی",
    //           show: true,
    //           sortable: false,
    //           textAlign: TextAlign.center),
    //       DatatableHeader(
    //           text: "تاریخ فیش",
    //           value: "تاریخ فیش",
    //           show: true,
    //           sortable: false,
    //           textAlign: TextAlign.center),
    //       DatatableHeader(
    //           text: "وضعیت بررسی",
    //           value: "وضعیت بررسی",
    //           show: true,
    //           sortable: false,
    //           textAlign: TextAlign.center),
    //       DatatableHeader(
    //           text: "میزان خسارت وارده به اموال",
    //           value: "میزان خسارت وارده به اموال",
    //           show: true,
    //           sortable: false,
    //           textAlign: TextAlign.center),
    //     ];

    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                      'لیست خوابگاه ها',
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
                        child: Container(
                            margin: const EdgeInsets.all(smallDistance),
                            width: 288,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(smallDistance),
                                  child: const Text('دنبال چی میگردی؟'),
                                ),
                                SizedBox(
                                  height: 48,
                                  child: Form(
                                      key: _searchKey,
                                      child: TextFormField(
                                        maxLength: 20,
                                        controller: searchController,
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: 'جستجو نام خوابگاه',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.3)),
                                            borderRadius: BorderRadius.circular(
                                                mediumRadius),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: primaryColor),
                                            borderRadius: BorderRadius.circular(
                                                mediumRadius),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius: BorderRadius.circular(
                                                mediumRadius),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                            borderRadius: BorderRadius.circular(
                                                mediumRadius),
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ))),
                    DropDownWidget(
                      items: ["تایید شده", "تایید نشده"],
                      label: "وضعیت بررسی",
                      onChanged: () {},
                    ),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("تاریخ فراغت از تحصیل"),
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
                                    "${picked.year}/${picked.month}/${picked.day}";
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: smallDistance),
                            alignment: Alignment.centerRight,
                            height: 48,
                            width: 248,
                            decoration: BoxDecoration(
                              color: canvasColor,
                              border: Border.all(color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(mediumRadius),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((dateLabel.isEmpty)
                                    ? 'تاریخ ورود'
                                    : dateLabel),
                                if (dateLabel.isNotEmpty)
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          dateLabel = '';
                                        });
                                      },
                                      icon: const Icon(Icons.clear))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: smallDistance,),
                    Padding(
                      padding: const EdgeInsets.only(top: xLargeDistance),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: primaryColor,
                            minimumSize: const Size(152, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(smallRadius),
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
              child: Card(
                  elevation: 4,
                  shadowColor: Colors.black,
                  clipBehavior: Clip.none,
                  child: Container(
                    padding: const EdgeInsets.only(top: smallDistance),
                    child: ResponsiveDatatable(
                      reponseScreenSizes: const [ScreenSize.xs],
                      headers: _headers,
                      source: _source,
                      showSelect: false,
                      autoHeight: false,
                      onChangedRow: (value, header) {},
                      onSubmittedRow: (value, header) {
                        print(value);
                      },
                      onTabRow: (data) {},
                      onSort: (value) {
                        setState(() => _isLoading = true);

                        setState(() {
                          _sortColumn = value;
                          _sortAscending = !_sortAscending;
                          if (_sortAscending) {
                            _sourceFiltered.sort((a, b) =>
                                b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                          } else {
                            _sourceFiltered.sort((a, b) =>
                                a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                          }
                          var rangeTop =
                              _currentPerPage < _sourceFiltered.length
                                  ? _currentPerPage
                                  : _sourceFiltered.length;
                          _source =
                              _sourceFiltered.getRange(0, rangeTop).toList();

                          _isLoading = false;
                        });
                      },
                      expanded: _expanded,
                      sortAscending: _sortAscending,
                      sortColumn: _sortColumn,
                      isLoading: _isLoading,
                      selecteds: const [],
                      headerDecoration: const BoxDecoration(
                          color: actionColor,
                          border: Border(
                              bottom:
                                  BorderSide(color: primaryColor, width: 1))),
                      selectedDecoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.green[300]!, width: 1)),
                        color: Colors.green,
                      ),
                      headerTextStyle: const TextStyle(color: Colors.white),
                      rowTextStyle: const TextStyle(color: Colors.green),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ]),
    ));
  }
}
