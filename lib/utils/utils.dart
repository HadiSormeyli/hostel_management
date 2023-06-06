import 'package:flutter/material.dart';

import '../config/theme.dart';
import 'constant.dart';

String? validateFirstName(String? value) {
  return value!.isEmpty ? 'لطفا نام را وارد کنید.' : null;
}

String? validateLastName(String? value) {
  return value!.isEmpty ? 'لطفا نام خانوادگی را وارد کنید.' : null;
}

String? validateMobile(String? value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty || value.length < 9) {
    return 'لطفا شماره موبایل را درست  وارد کنید.';
  }
  return null;
}

String? validateNationalCode(String? nationalCode) {
  if (nationalCode == null ||
      nationalCode.isEmpty ||
      nationalCode.length < 9) {
    return 'لطفا عدد را وارد کنید.';
  }
  return null;
}

String? validateStudentNumber(String? studentNumber) {
  if (studentNumber == null ||
      studentNumber.isEmpty ||
      studentNumber.length < 8) {
    return 'لطفا شماره دانشجویی را وارد کنید.';
  }
  return null;
}

String? validateEnterTerm(String? enterTerm) {
  if (enterTerm == null ||
      enterTerm.isEmpty) {
    return 'لطفا ترم ورود را وارد کنید.';
  }
  return null;
}

String? validateNationalSeri(String? seri) {
  if (seri == null || seri.isEmpty || seri.length < 6) {
    return 'لطفا عدد را وارد کنید.';
  }
  return null;
}

String? validateNationality(String? nationality) {
  if (nationality == null || nationality.isEmpty) {
    return 'لطفا ملیت را وارد کنید.';
  }
  return null;
}

String? validateState(String? state) {
  if (state == null || state.isEmpty) {
    return 'لطفا استان را وارد کنید.';
  }
  return null;
}

String? validateCity(String? city) {
  if (city == null || city.isEmpty) {
    return 'لطفا شهر را وارد کنید.';
  }
  return null;
}

String? validateAddress(String? address) {
  if (address == null || address.isEmpty) {
    return 'لطفا آدرس را وارد کنید.';
  }
  return null;
}

String? validatePostCode(String? postCode) {
  if (postCode == null || postCode.isEmpty) {
    return 'لطفا کدپستی را وارد کنید.';
  } else if (postCode.length < 9) {
    return 'لطفا کدپستی را کامل وارد کنید.';
  }
  return null;
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isEmpty || !regex.hasMatch(value)
      ? 'آدرس ایمیل را صحیح وارد کنید.'
      : null;
}

String? validateNation(String? value) {
  return value!.isEmpty ? 'لطفا قومیت را وارد کنید.' : null;
}

String? validateFaith(String? value) {
  return value!.isEmpty ? 'لطفا دین را وارد کنید.' : null;
}

String? validateReligion(String? value) {
  return value!.isEmpty ? 'لطفا مذهب را وارد کنید.' : null;
}


void createSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: primaryColor,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    action: SnackBarAction(
      label: 'باشه',
      textColor: Colors.white,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void initAddStudent() {
  addStudent = {
    "NationalCode": "Null",
    "Name": "Null",
    "LastName": "Null",
    "IdNumber": "Null",
    "IdentitySerialNumber": "Null",
    "Nationality": "Null",
    "Religion": "Null",
    "Gilder": "Null",
    "CellularPhone": "Null",
    "MothersPhone": "Null",
    "FathersPhone": "Null",
    "EmailAddress": "Null",
    "FathersName": "Null",
    "MothersName": "Null",
    "BirthPlace": "Null",
    "BirthCertificateIssuingPlace": "Null",
    "DateOfBirth": "Null",
    "GenderCode": "1",
    "MaritalStatusCode": "1",
    "DutySystemCode": "1",
    "PostalCode": "Null",
    "Address": "Null",
    "State": "Null",
    "City": "Null",

    "StudentNumber": "Null",
    "StartDateOfStudy": "Null",
    "DateOfGraduation": "Null",
    "EntrySemester": "Null",

    "FieldOfStudyCode": "1",
    "OrientationCode": "1",
    "AcceptanceTypeCode": "1",
    "GroupCode": "1",
    "SectionCode": "1",
    "CollegeCode": "1",
    "ActivityCheckStatusCode": "1",
  };
}

void initAddDorm() {
  addDorm = {
    "StudentNumber":"Null",
    "HostelCode":"1",
    "RoomCode":"1",
    "InventoryOfTheHostelPropertyCode":"1",
    "HostelPropertyCode":"1",
  };
}

void initAddDormFinance() {
  addDormFinance = {
    "DepositReceiptNumber":"Null",
    "DepositAmount":"Null",
    "DepositDate":"Null",

    "StudentNumber":"Null",
    "HostelPropertyCode":"1",
    "PropertyDamageCode":"1",
    "FinancialReviewStatusCode":"1",

    "DateOfArrivalAtTheHostel":"Null",
    "DateOfDeparture":"Null",
    "DebtAmount":"Null",
    "FullNameOfTheHostelSupervisor":"Null",
    "DescriptionOfTheDormitory":"Null",
    "SettlementDate":"Null",
    "FormCompletionDate":"Null",

    "TheAmountOfDamageCaused":"1",
  };
}

void initAddViolation() {
  addViolation = {
    "StudentNumber":"Null",
    "ComplaintCode":"1",
    "ViolationCode":"1",
    "ViolationCheckCode":"1",
  };
}

