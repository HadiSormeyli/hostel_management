import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../config/theme.dart';
import '../../../utils/utils.dart';
import '../../widgets/drop_down_widget.dart';
import 'add_student_screen.dart';

class AddPersonalInfoScreen extends StatefulWidget {
  final Validation validation;

  const AddPersonalInfoScreen({Key? key, required this.validation})
      : super(key: key);

  @override
  State<AddPersonalInfoScreen> createState() => _AddPersonalInfoScreenState();
}

class _AddPersonalInfoScreenState extends State<AddPersonalInfoScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController sodoorPlaceController = TextEditingController();
  final TextEditingController nationalNumberController =
      TextEditingController();
  final TextEditingController seriNumberController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController homeNumberController = TextEditingController();
  final TextEditingController motherNumberController = TextEditingController();
  final TextEditingController fatherNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController nationController = TextEditingController();
  final TextEditingController faithController = TextEditingController();
  final TextEditingController religionController = TextEditingController();

  final _codeKey = GlobalKey<FormState>();
  final _fnameKey = GlobalKey<FormState>();
  final _lnameKey = GlobalKey<FormState>();
  final _nationalNumberKey = GlobalKey<FormState>();
  final _seriNumberKey = GlobalKey<FormState>();
  final _sodoorPlaceKey = GlobalKey<FormState>();
  final _birthPlaceKey = GlobalKey<FormState>();
  final _nationalityKey = GlobalKey<FormState>();
  final _stateKey = GlobalKey<FormState>();
  final _cityKey = GlobalKey<FormState>();
  final _addressKey = GlobalKey<FormState>();
  final _postCodeKey = GlobalKey<FormState>();
  final _mobileNumberKey = GlobalKey<FormState>();
  final _homeNumberKey = GlobalKey<FormState>();
  final _motherNumberKey = GlobalKey<FormState>();
  final _fatherNumberKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _fatherNameKey = GlobalKey<FormState>();
  final _motherNameKey = GlobalKey<FormState>();
  final _nationKey = GlobalKey<FormState>();
  final _faithKey = GlobalKey<FormState>();
  final _religionKey = GlobalKey<FormState>();

  String label = '';

  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  void initState() {
    label = 'تاریخ تولد خود را انتخاب کنید.';

    widget.validation.validatePersonalInfo = () {
      return (_codeKey.currentState!.validate() &
          _fnameKey.currentState!.validate() &
          _lnameKey.currentState!.validate() &
          _nationalNumberKey.currentState!.validate() &
          _seriNumberKey.currentState!.validate() &
          _validateBirthDate() &
          _sodoorPlaceKey.currentState!.validate() &
          _birthPlaceKey.currentState!.validate() &
          _nationalityKey.currentState!.validate() &
          _stateKey.currentState!.validate() &
          _cityKey.currentState!.validate() &
          _addressKey.currentState!.validate() &
          _postCodeKey.currentState!.validate() &
          _mobileNumberKey.currentState!.validate() &
          _homeNumberKey.currentState!.validate() &
          _motherNumberKey.currentState!.validate() &
          _fatherNumberKey.currentState!.validate() &
          _emailKey.currentState!.validate() &
          _fatherNameKey.currentState!.validate() &
          _motherNameKey.currentState!.validate() &
          _nationKey.currentState!.validate() &
          _faithKey.currentState!.validate() &
          _religionKey.currentState!.validate());
    };

    super.initState();
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: _codeKey,
              child: TextFormField(
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                controller: codeController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validateNationalCode,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'کدملی',
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
              key: _fnameKey,
              child: TextFormField(
                maxLength: 20,
                controller: fnameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateFirstName,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'نام',
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
              key: _lnameKey,
              child: TextFormField(
                maxLength: 20,
                controller: lnameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateLastName,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'نام خانوادگی',
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
              key: _nationalNumberKey,
              child: TextFormField(
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                controller: nationalNumberController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validateNationalCode,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'شماره شناسنامه',
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
              key: _seriNumberKey,
              child: TextFormField(
                maxLength: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                controller: seriNumberController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validateNationalSeri,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'سریال شناسنامه',
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
                  items: ["مجرد", "متاهل"],
                  onChanged: () {},
                  selectedValue: "مجرد",
                  label: "وضعیت تاهل"),
              const SizedBox(
                width: smallDistance,
              ),
              DropDownWidget(
                  items: ["مرد", "زن"],
                  onChanged: () {},
                  selectedValue: "مرد",
                  label: "جنسیت"),
              const SizedBox(
                width: smallDistance,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("تاریخ تولد"),
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
                          label =
                              "${picked.year}/${picked.month}/${picked.day}";
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(smallDistance),
                      alignment: Alignment.centerRight,
                      height: 48,
                      width: 200,
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(mediumRadius),
                      ),
                      child: Text(label),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: smallDistance,
              ),
              DropDownWidget(
                  items: ["معاف", "گذرانده"],
                  onChanged: () {},
                  selectedValue: "معاف",
                  label: "وضعیت نظام وظعیفه"),
            ],
          ),
          const SizedBox(
            height: smallDistance,
          ),
          Form(
              key: _sodoorPlaceKey,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                controller: sodoorPlaceController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'محل صدور شناسنامه',
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
              key: _birthPlaceKey,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                controller: birthPlaceController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'محل تولد',
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
              key: _nationalityKey,
              child: TextFormField(
                maxLength: 20,
                controller: nationalityController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateNationality,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'ملیت',
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
              key: _stateKey,
              child: TextFormField(
                maxLength: 20,
                controller: stateController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateState,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'استان',
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
              key: _cityKey,
              child: TextFormField(
                maxLength: 20,
                controller: cityController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateCity,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'شهر',
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
              key: _addressKey,
              child: TextFormField(
                maxLength: 20,
                controller: addressController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'آدرس',
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
              key: _postCodeKey,
              child: TextFormField(
                maxLength: 10,
                controller: postCodeController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validatePostCode,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'کدپستی',
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
              key: _mobileNumberKey,
              child: TextFormField(
                maxLength: 11,
                controller: mobileNumberController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validateMobile,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'تلفن همراه',
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
              key: _homeNumberKey,
              child: TextFormField(
                maxLength: 11,
                controller: homeNumberController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validateMobile,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'تلفن ثابت',
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
              key: _motherNumberKey,
              child: TextFormField(
                maxLength: 11,
                controller: motherNumberController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateMobile,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'تلفن مادر',
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
              key: _fatherNumberKey,
              child: TextFormField(
                maxLength: 11,
                controller: fatherNumberController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: validateMobile,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'تلفن پدر',
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
              key: _emailKey,
              child: TextFormField(
                controller: emailController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateEmail,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[abcdefghijklmnopqrstwxyz@.-_]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '* آدرس ایمیل',
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
              key: _fatherNameKey,
              child: TextFormField(
                maxLength: 20,
                controller: fatherNameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'نام پدر',
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
              key: _motherNameKey,
              child: TextFormField(
                maxLength: 20,
                controller: motherNameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'نام مادر',
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
              key: _nationKey,
              child: TextFormField(
                maxLength: 20,
                controller: nationController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateNation,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'قومیت',
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
              key: _faithKey,
              child: TextFormField(
                maxLength: 20,
                controller: faithController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'دین',
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
              key: _religionKey,
              child: TextFormField(
                maxLength: 20,
                controller: religionController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: validateAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]'))
                ],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'مذهب',
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
    ))));
  }

  bool _validateBirthDate() {
    if (label == 'تاریخ تولد خود را انتخاب کنید.') {
      createSnackBar(context, 'تاریخ تولد را انتخاب کنید.');
      return false;
    }
    return true;
  }
}
