import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController descriptionController = TextEditingController();

  final _studentNumberKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey<FormState>();

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
                    key: _descriptionKey,
                    child: TextFormField(
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            '[1234567890 آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                      ],
                      controller: descriptionController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'شرح تخلف',
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
                        label: "نوع تخلف"),
                    const SizedBox(
                      width: smallDistance,
                    ),
                    DropDownWidget(
                        items: ["مرد", "زن"],
                        onChanged: () {},
                        selectedValue: "مرد",
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
