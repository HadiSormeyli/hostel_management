import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_bloc.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_event.dart';
import 'package:hostel_management/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../widgets/drop_down_widget.dart';

class AddViolationScreen extends StatefulWidget {
  const AddViolationScreen({Key? key}) : super(key: key);

  @override
  State<AddViolationScreen> createState() => _AddViolationScreenState();
}

class _AddViolationScreenState extends State<AddViolationScreen> {
  final TextEditingController studentNumberController = TextEditingController();

  final _studentNumberKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    initAddViolation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('افزودن تخلف'),
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
                              borderRadius: BorderRadius.circular(
                                  smallDistance),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(
                                  smallDistance),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: smallDistance,
                    ),
                    // Form(
                    //     key: _descriptionKey,
                    //     child: TextFormField(
                    //       maxLength: 8,
                    //       inputFormatters: [
                    //         FilteringTextInputFormatter.allow(RegExp(
                    //             '[1234567890 آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                    //       ],
                    //       controller: descriptionController,
                    //       maxLines: 1,
                    //       keyboardType: TextInputType.number,
                    //       decoration: InputDecoration(
                    //         counterText: "",
                    //         labelText: 'شرح تخلف',
                    //         labelStyle: const TextStyle(
                    //           color: Colors.grey,
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //           borderRadius: BorderRadius.circular(smallRadius),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: primaryColor),
                    //           borderRadius: BorderRadius.circular(smallRadius),
                    //         ),
                    //         errorBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.red),
                    //           borderRadius: BorderRadius.circular(
                    //               smallDistance),
                    //         ),
                    //         focusedErrorBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.red),
                    //           borderRadius: BorderRadius.circular(
                    //               smallDistance),
                    //         ),
                    //       ),
                    //     )),
                    // const SizedBox(
                    //   height: smallDistance,
                    // ),
                    Row(
                      children: [
                        DropDownWidget(
                          width: 340,
                            items: [
                              "ایجاد مزاحمت و سر و صدا",
                              "نوشتن شعارهای مغایر اصول و موازین اسلامی",
                              "انجام اعمال خلاف اخلاق",
                              "مصرف،فروش و کشت مواد مخدر",
                              "حمل سلاح گرم یا سرد",
                              "ارتکاب قتل"
                            ],
                            onChanged: (value) {
                              addViolation['ComplaintCode'] = ([
                                "ایجاد مزاحمت و سر و صدا",
                                "نوشتن شعارهای مغایر اصول و موازین اسلامی",
                                "انجام اعمال خلاف اخلاق",
                                "مصرف،فروش و کشت مواد مخدر",
                                "حمل سلاح گرم یا سرد",
                                "ارتکاب قتل"
                              ].indexOf(value) + 1).toString();
                            },
                            selectedValue: "ایجاد مزاحمت و سر و صدا",
                            label: "شرح تخلف"),
                        const SizedBox(
                          width: smallDistance,
                        ),
                        DropDownWidget(
                            items: ["خاص", "عادی"],
                            onChanged: (value) {
                              addViolation['ViolationCode'] = (["خاص", "عادی"].indexOf(value) + 1).toString();
                            },
                            selectedValue: "خاص",
                            label: "نوع تخلف"),
                        const SizedBox(
                          width: smallDistance,
                        ),
                        DropDownWidget(
                            width: 240,
                            items: [
                              "تایید و اخذ تعهد",
                              "تایید و تشکیل پرونده انظباطی",
                              "عدم تایید"
                            ],
                            onChanged: (value) {
                              addViolation['ViolationCheckCode'] = ([
                                "تایید و اخذ تعهد",
                                "تایید و تشکیل پرونده انظباطی",
                                "عدم تایید"
                              ].indexOf(value) + 1).toString();
                            },
                            selectedValue: "تایید و اخذ تعهد",
                            label: "نتیجه نهایی بررسی"),
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
                      addViolation['StudentNumber'] = studentNumberController.value.text;
                      await Future.microtask(
                            () => Provider.of<ViolationBloc>(context, listen: false)
                            .add(const AddViolationEvent()),
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
