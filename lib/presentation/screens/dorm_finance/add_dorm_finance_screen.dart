import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../widgets/drop_down_widget.dart';

class AddDormFinanceScreen extends StatefulWidget {
  const AddDormFinanceScreen({Key? key}) : super(key: key);

  @override
  State<AddDormFinanceScreen> createState() => _AddDormFinanceScreenState();
}

class _AddDormFinanceScreenState extends State<AddDormFinanceScreen> {
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController enterTermController = TextEditingController();
  final TextEditingController amountOwedController = TextEditingController();
  final TextEditingController amountGiveController = TextEditingController();
  final TextEditingController fishNumberController = TextEditingController();
  final TextEditingController supervisorNameController =
      TextEditingController();
  final TextEditingController supervisorLastNameController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController completionDateController =
      TextEditingController();

  final _studentNumberKey = GlobalKey<FormState>();
  final _enterTermKey = GlobalKey<FormState>();
  final _amountOwedKey = GlobalKey<FormState>();
  final _amountGiveKey = GlobalKey<FormState>();
  final _fishNumberKey = GlobalKey<FormState>();
  final _supervisorNameKey = GlobalKey<FormState>();
  final _supervisorLastNameKey = GlobalKey<FormState>();
  final _descriptionNameKey = GlobalKey<FormState>();
  final _completionDateDateKey = GlobalKey<FormState>();

  String startDateLabel = '';
  String endDateLabel = '';
  String fishDateLabel = '';
  String setDateLabel = '';
  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('اطلاعات مالی خوابگاه'),
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
                Form(
                    key: _enterTermKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            '[1234567890 آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                      ],
                      controller: enterTermController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'ترم ورود',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("تاریخ ورود"),
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
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                startDateLabel =
                                    "${picked.year}/${picked.month}/${picked.day}";
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(smallDistance),
                            alignment: Alignment.centerRight,
                            height: 48,
                            width: 248,
                            decoration: BoxDecoration(
                              color: canvasColor,
                              borderRadius: BorderRadius.circular(mediumRadius),
                            ),
                            child: Text((startDateLabel.isEmpty)
                                ? 'تاریخ ورود را انتخاب کنید.'
                                : startDateLabel),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("تاریخ خروج"),
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
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                endDateLabel =
                                    "${picked.year}/${picked.month}/${picked.day}";
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(smallDistance),
                            alignment: Alignment.centerRight,
                            height: 48,
                            width: 248,
                            decoration: BoxDecoration(
                              color: canvasColor,
                              borderRadius: BorderRadius.circular(mediumRadius),
                            ),
                            child: Text((endDateLabel.isEmpty)
                                ? 'تاریخ خروج را انتخاب کنید.'
                                : endDateLabel),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("تاریخ فیش"),
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
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                fishDateLabel =
                                    "${picked.year}/${picked.month}/${picked.day}";
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(smallDistance),
                            alignment: Alignment.centerRight,
                            height: 48,
                            width: 248,
                            decoration: BoxDecoration(
                              color: canvasColor,
                              borderRadius: BorderRadius.circular(mediumRadius),
                            ),
                            child: Text((fishDateLabel.isEmpty)
                                ? 'تاریخ فیش را انتخاب کنید.'
                                : fishDateLabel),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("تاریخ تسویه حساب"),
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
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                setDateLabel =
                                    "${picked.year}/${picked.month}/${picked.day}";
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(smallDistance),
                            alignment: Alignment.centerRight,
                            height: 48,
                            width: 248,
                            decoration: BoxDecoration(
                              color: canvasColor,
                              borderRadius: BorderRadius.circular(mediumRadius),
                            ),
                            child: Text((setDateLabel.isEmpty)
                                ? 'تاریخ خروج را انتخاب کنید.'
                                : setDateLabel),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: smallDistance,
                ),
                Row(
                  children: [
                    DropDownWidget(
                        items: ["کامپیوتر", "انسانی"],
                        onChanged: () {},
                        selectedValue: "کامپیوتر",
                        label: "نام خوابگاه"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["مرد", "زن"],
                        onChanged: () {},
                        selectedValue: "مرد",
                        label: "شماره اتاق"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["معاف", "گذرانده"],
                        onChanged: () {},
                        selectedValue: "معاف",
                        label: "اموال خسارت دیده"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["کامپیوتر", "انسانی"],
                        onChanged: () {},
                        selectedValue: "کامپیوتر",
                        label: "وضعیت بررسی"),
                  ],
                ),
                const SizedBox(
                  height: smallDistance,
                ),
                Form(
                    key: _amountOwedKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: amountOwedController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: validateStudentNumber,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'مبلغ بدهی',
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
                Form(
                    key: _amountGiveKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: amountGiveController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: validateStudentNumber,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'مبلغ واریزی',
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
                Form(
                    key: _fishNumberKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: fishNumberController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: validateStudentNumber,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'شماره فیش',
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
                Form(
                    key: _supervisorNameKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: supervisorNameController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      validator: validateStudentNumber,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'نام سرپرست خوابگاه',
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
                Form(
                    key: _supervisorLastNameKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: supervisorLastNameController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'نام خانوادگی سرپرست خوابگاه',
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
                Form(
                    key: _descriptionNameKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: descriptionController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'توضیحات بخش خوابگاه',
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
                Form(
                    key: _completionDateDateKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[1234567890]'))
                      ],
                      controller: completionDateController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'تاریخ تکمیل فرم',
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
                  onPressed: () {
                    if (_studentNumberKey.currentState!.validate()) {
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
