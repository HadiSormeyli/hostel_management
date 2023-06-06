import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_bloc.dart';
import 'package:hostel_management/utils/constant.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../blocs/dorm_finance/dorm_finance_event.dart';
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
  final _amountOwedKey = GlobalKey<FormState>();
  final _amountGiveKey = GlobalKey<FormState>();
  final _fishNumberKey = GlobalKey<FormState>();
  final _supervisorNameKey = GlobalKey<FormState>();
  final _supervisorLastNameKey = GlobalKey<FormState>();
  final _descriptionNameKey = GlobalKey<FormState>();

  String startDateLabel = '';
  String endDateLabel = '';
  String fishDateLabel = '';
  String setDateLabel = '';
  String formDateLabel = '';
  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  void initState() {
    super.initState();
    initAddDormFinance();
  }

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
                                    "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
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
                        const Text("تاریخ تکمیل فرم"),
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
                                formDateLabel =
                                    "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
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
                            child: Text((formDateLabel.isEmpty)
                                ? 'تاریخ تکمیل فرم را انتخاب کنید.'
                                : formDateLabel),
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
                                    "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
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
                                    "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
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
                                    "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
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
                        onChanged: (value) {
                          addDormFinance['HostelPropertyCode'] = ([
                                    "شهید عسگری نژاد",
                                    "شهید بابازاده",
                                    "شهید فرجامی",
                                    "شهید ناصر بخت",
                                    "شهید علیخانی",
                                    "شهید نوری",
                                    "روغنی زنجانی",
                                    "دکترا 2"
                                  ].indexOf(value) +
                                  1)
                              .toString();
                        },
                        selectedValue: "شهید عسگری نژاد",
                        label: "نام خوابگاه"),
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
                          addDormFinance['HostelPropertyCode'] = ([
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
                        label: "اموال خسارت دیده"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["تایید", "عدم تایید"],
                        onChanged: (value) {
                          addDormFinance['FinancialReviewStatusCode'] =
                              (["تایید", "عدم تایید"].indexOf(value) + 1)
                                  .toString();
                        },
                        selectedValue: "تایید",
                        label: "وضعیت بررسی"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["20%", "40%", "60%", "80%", "100%", "0"],
                        onChanged: (value) {
                          addDormFinance['PropertyDamageCode'] = ([
                                    "20%",
                                    "40%",
                                    "60%",
                                    "80%",
                                    "100%",
                                    "0"
                                  ].indexOf(value) +
                                  1)
                              .toString();
                        },
                        selectedValue: "20%",
                        label: "میزان خسارت وارده"),
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
                            RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
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
                            RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
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
                            RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
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
                      addDormFinance['StudentNumber'] =
                          studentNumberController.value.text;
                      addDormFinance['DebtAmount'] =
                          amountOwedController.value.text;
                      addDormFinance['DepositAmount'] =
                          amountGiveController.value.text;
                      addDormFinance['DepositReceiptNumber'] =
                          fishNumberController.value.text;
                      addDormFinance['DepositReceiptNumber'] =
                          fishNumberController.value.text;
                      addDormFinance['FullNameOfTheHostelSupervisor'] =
                          "${supervisorNameController.value.text} ${supervisorLastNameController.value.text}";
                      addDormFinance['DescriptionOfTheDormitory'] =
                          descriptionController.value.text;

                      addDormFinance['FormCompletionDate'] = formDateLabel;
                      addDormFinance['SettlementDate'] = setDateLabel;
                      addDormFinance['DateOfArrivalAtTheHostel'] =
                          startDateLabel;
                      addDormFinance['DateOfDeparture'] = endDateLabel;
                      addDormFinance['DepositDate'] = fishDateLabel;

                      await Future.microtask(
                        () =>
                            Provider.of<DormFinanceBloc>(context, listen: false)
                                .add(const AddDormFinanceEvent()),
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
