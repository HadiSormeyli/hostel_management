import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management/utils/constant.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../widgets/drop_down_widget.dart';
import 'add_student_screen.dart';

class AddEducationInfoScreen extends StatefulWidget {
  final Validation validation;

  const AddEducationInfoScreen({Key? key, required this.validation})
      : super(key: key);

  @override
  State<AddEducationInfoScreen> createState() => _AddEducationInfoScreenState();
}

class _AddEducationInfoScreenState extends State<AddEducationInfoScreen> {
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController enterTermController = TextEditingController();

  final _studentNumberKey = GlobalKey<FormState>();
  final _enterTermKey = GlobalKey<FormState>();

  String startDateLabel = '';
  String endDateLabel = '';
  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  void initState() {
    widget.validation.validateEducationalInfo = () {
      if (_studentNumberKey.currentState!.validate() &
          _validateDate(
              startDateLabel, "لطفا تاریخ شروع به تحصیل را مشخص کنید.") &
          _validateDate(endDateLabel, "لطفا فراغت از تحصیل را مشخص کنید.") &
          _enterTermKey.currentState!.validate()) {
        addStudent['StudentNumber'] = studentNumberController.value.text;
        addStudent['EntrySemester'] = enterTermController.value.text;
        addStudent['StartDateOfStudy'] = startDateLabel;
        addStudent['DateOfGraduation'] = endDateLabel;
        return true;
      }
      return false;
    };
    super.initState();
  }

  bool _validateDate(String label, String message) {
    if (label.isEmpty) {
      createSnackBar(context, message);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
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
                    const Text("تاریخ شروع به نحصیل"),
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
                            ? 'تاریخ شروع به تحصیل را انتخاب کنید.'
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
                            ? 'تاریخ فراغت از تحصیل را انتخاب کنید.'
                            : endDateLabel),
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
                    items: ["مهندسی", "انسانی", "علوم"],
                    onChanged: (value) {
                      addStudent['CollegeCode'] =
                          (["مهندسی", "انسانی", "علوم"].indexOf(value) + 1).toString();
                    },
                    selectedValue: "انسانی",
                    label: "دانشکده"),
                const SizedBox(
                  width: smallDistance,
                ),
                DropDownWidget(
                    items: [
                      "مهندسی صنایع",
                      "مهندسی مکانیک",
                      "مهندسی عمران",
                      "مهندسی برق",
                      "شیمی محض",
                      "روانشناسی"
                    ],
                    onChanged: (value) {
                      addStudent['GroupCode'] = ([
                            "مهندسی صنایع",
                            "مهندسی مکانیک",
                            "مهندسی عمران",
                            "مهندسی برق",
                            "شیمی محض",
                            "روانشناسی"
                          ].indexOf(value) +
                          1).toString();
                    },
                    selectedValue: "مهندسی صنایع",
                    label: "گروه"),
                const SizedBox(
                  width: smallDistance,
                ),
                DropDownWidget(
                    items: ["کارشناسی", "ارشد", "دکترا"],
                    onChanged: (value) {
                      addStudent['SectionCode'] = (["کارشناسی", "ارشد", "دکترا"].indexOf(value) + 1).toString();
                    },
                    selectedValue: "کارشناسی",
                    label: "مقطع"),
                const SizedBox(
                  width: smallDistance,
                ),
                DropDownWidget(
                    items: [
                      "مهندسی صنایع",
                      "مهندسی مکانیک",
                      "مهندسی عمران",
                      "مهندسی برق",
                      "شیمی محض",
                      "روانشناسی"
                    ],
                    onChanged: (value) {
                      addStudent['FieldOfStudyCode'] =  ([
                        "مهندسی صنایع",
                        "مهندسی مکانیک",
                        "مهندسی عمران",
                        "مهندسی برق",
                        "شیمی محض",
                        "روانشناسی"
                      ].indexOf(value) + 1).toString();
                    },
                    selectedValue: "مهندسی صنایع",
                    label: "رشته تحصیلی"),
                const SizedBox(
                  width: smallDistance,
                ),
                DropDownWidget(
                    items: ["ندارد", "سیالات", "جامدات", "برق قدرت"],
                    onChanged: (value) {
                      addStudent['OrientationCode'] =  (["ندارد", "سیالات", "جامدات", "برق قدرت"].indexOf(value) + 1).toString();
                    },
                    selectedValue: "ندارد",
                    label: "گرایش"),
                const SizedBox(
                  width: smallDistance,
                ),
                DropDownWidget(
                    items: ["روزانه", "شبانه"],
                    onChanged: (value) {
                      addStudent['AcceptanceTypeCode'] =  (["روزانه", "شبانه"].indexOf(value) + 1).toString();
                    },
                    selectedValue: "روزانه",
                    label: "نوع پذیرش"),
              ],
            ),
            const SizedBox(
              height: smallDistance,
            ),
            Form(
                key: _enterTermKey,
                child: TextFormField(
                  maxLength: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        '[- 1234567890 آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                  ],
                  controller: enterTermController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  validator: validateEnterTerm,
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
          ],
        ),
      ),
    )));
  }
}
