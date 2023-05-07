import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hostel_management/config/theme.dart';
import 'package:hostel_management/presentaion/widgets/drop_down_widget.dart';
import 'package:responsive_table/responsive_table.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
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
  var random = Random();

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "id": i,
        "sku": "$i\000$i",
        "name": "Product $i",
        "category": "Category-$i",
        "price": i * 10.00,
        "cost": "20.00",
        "margin": "${i}0.20",
        "in_stock": "${i}0",
        "alert": "5",
        "received": [i + 20, 150]
      });
      i++;
    }
    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
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

  //TODO:change this
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
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "SKU",
          value: "sku",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "Category",
          value: "category",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "Price",
          value: "price",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "Margin",
          value: "margin",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "In Stock",
          value: "in_stock",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "Alert",
          value: "alert",
          show: true,
          sortable: true,
          editable: true,
          textAlign: TextAlign.right),
      DatatableHeader(
          text: "Received",
          value: "received",
          show: true,
          sortable: false,
          sourceBuilder: (value, row) {
            List list = List.from(value);
            return Column(
              children: [
                SizedBox(
                  width: 85,
                  child: LinearProgressIndicator(
                    value: list.first / list.last,
                  ),
                ),
                Text("${list.first} of ${list.last}")
              ],
            );
          },
          textAlign: TextAlign.center),
    ];

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
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
                      'لیست دانشجویان',
                      style: TextStyle(fontSize: 16, fontWeight: bold),
                    ),
                    ElevatedButton(
                        onPressed: () {},
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
                                          hintText: 'جستجو شماره دانشجویی',
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
                      items: ["hadi", "12", "13"],
                      label: "سکونت",
                      onChanged: () {},
                    ),
                    DropDownWidget(
                      items: ["hadi", "12", "13"],
                      label: "سکونت",
                      onChanged: () {},
                    ),
                    DropDownWidget(
                      items: ["hadi", "12", "13"],
                      label: "سکونت",
                      onChanged: () {},
                    ),
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
