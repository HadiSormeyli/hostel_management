import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_bloc.dart';
import 'package:hostel_management/utils/constant.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../blocs/dorm_bloc/dorm_event.dart';
import '../../widgets/drop_down_widget.dart';

class AddDormScreen extends StatefulWidget {
  const AddDormScreen({Key? key}) : super(key: key);

  @override
  State<AddDormScreen> createState() => _AddDormScreenState();
}

class _AddDormScreenState extends State<AddDormScreen> {
  final TextEditingController studentNumberController = TextEditingController();

  final _studentNumberKey = GlobalKey<FormState>();

  String startDateLabel = '';
  String endDateLabel = '';
  String fishDateLabel = '';
  String setDateLabel = '';
  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  void initState() {
    super.initState();
    initAddDorm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('افزودن خوابگاه'),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: mediumDistance,
                right: mediumDistance,
                left: mediumDistance,
                bottom: 72),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _studentNumberKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: studentNumberController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: validateStudentNumber,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'شماره دانشجویی',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(smallRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(smallRadius),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(smallDistance),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(smallDistance),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: smallDistance,
                ),
                Row(
                  children: [
                    DropDownWidget(
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
                          addDorm['HostelCode'] = ([
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
                              .toString();
                        },
                        selectedValue: "شهید عسگری نژاد",
                        label: "نام خوابگاه"),
                    const SizedBox(
                      height: smallDistance,
                    ),
                    DropDownWidget(
                      items: [for (var i = 1; i < 23; i++) i]
                          .map((e) => "$e")
                          .toList(),
                      label: "شماره اتاق",
                      selectedValue: '1',
                      onChanged: (value) {
                        addDorm['RoomCode'] = ([for (var i = 1; i < 23; i++) i]
                                    .map((e) => "$e")
                                    .toList()
                                    .indexOf(value) +
                                1)
                            .toString();
                      },
                    ),
                    const SizedBox(
                      width: smallDistance,
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
                        onChanged: (value) {
                          addDorm['HostelPropertyCode'] = ([
                                    "میز",
                                    "موکت",
                                    "توری",
                                    "فرش",
                                    "صندلی",
                                    "نوپان",
                                    "کلید"
                                  ].indexOf(value) +
                                  1)
                              .toString();
                        },
                        selectedValue: "میز",
                        label: "اموال خوابگاه"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["موجود", "ناموجود"],
                        onChanged: (value) {
                          addDorm['InventoryOfTheHostelPropertyCode'] =
                              (["موجود", "ناموجود"].indexOf(value) + 1)
                                  .toString();
                        },
                        selectedValue: "موجود",
                        label: "وضعیت موجودی اموال خوابگاه"),
                  ],
                ),
              ],
            ),
          ),
        )),
        floatingActionButton: Container(
            margin: const EdgeInsets.only(right: xLargeDistance),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_studentNumberKey.currentState!.validate()) {
                      addDorm['StudentNumber'] = studentNumberController.value.text;
                      await Future.microtask(
                        () => Provider.of<DormBloc>(context, listen: false)
                            .add(const AddDormEvent()),
                      );
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
                  child: const Text("تایید"),
                ),
              ],
            )));
  }
}
