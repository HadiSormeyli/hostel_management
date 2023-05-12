import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../widgets/drop_down_widget.dart';

class AddDormScreen extends StatefulWidget {
  const AddDormScreen({Key? key}) : super(key: key);

  @override
  State<AddDormScreen> createState() => _AddDormScreenState();
}

class _AddDormScreenState extends State<AddDormScreen> {
  final TextEditingController roomNumberController = TextEditingController();

  final _roomNumberKey = GlobalKey<FormState>();


  String startDateLabel = '';
  String endDateLabel = '';
  String fishDateLabel = '';
  String setDateLabel = '';
  String selectedDate = Jalali.now().toJalaliDateTime();

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
                  children: [
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
                            label: "ظرفیت خوابگاه"),
                      ],
                    ),
                    const SizedBox(
                      height: smallDistance,
                    ),
                    Form(
                        key: _roomNumberKey,
                        child: TextFormField(
                          maxLength: 8,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[1234567890]'))
                          ],
                          controller: roomNumberController,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'شماره اتاق',
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
                            items: ["کامپیوتر", "انسانی"],
                            onChanged: () {},
                            selectedValue: "کامپیوتر",
                            label: "ظرفیت اتاق"),
                        const SizedBox(
                          width: smallDistance,
                        ),
                        DropDownWidget(
                            items: ["مرد", "زن"],
                            onChanged: () {},
                            selectedValue: "مرد",
                            label: "اموال خوابگاه"),
                        const SizedBox(
                          width: smallDistance,
                        ),
                        DropDownWidget(
                            items: ["مرد", "زن"],
                            onChanged: () {},
                            selectedValue: "مرد",
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
                  onPressed: () {
                      Navigator.pop(context);
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
