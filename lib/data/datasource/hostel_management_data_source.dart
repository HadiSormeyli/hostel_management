import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hostel_management/utils/constant.dart' as constants;
import 'package:http/http.dart' as http;

import '../../config/exception.dart';
import '../../utils/constant.dart';

abstract class HostelManagementDataSource {
  Future<List<Map<String, dynamic>>> getStudentList();

  Future<bool> addStudent();

  Future<bool> updateStudent(Map<String?, dynamic> updatedStudent);

  Future<List<Map<String, dynamic>>> getDormList();

  Future<List<Map<String, dynamic>>> getStudentDormList();

  Future<List<Map<String, dynamic>>> getViolationList();

  Future<bool> addViolation();

  Future<bool> updateViolation(Map<String?, dynamic> updateViolation);

  Future<List<Map<String, dynamic>>> getDormFinanceList();

  Future<bool> addDormFinance();

  Future<bool> updateDormFinance(Map<String?, dynamic> updatedDormFinance);

  Future<bool> addDorm();

  Future<bool> updateStudentDorm(Map<String?, dynamic> updatedDorm);

  Future<bool> updateDorm(Map<String?, dynamic> updatedDorm);
}

class HostelManagementDataSourceImpl extends HostelManagementDataSource {
  final http.Client client;

  HostelManagementDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getStudentList() async {
    final response = await client
        .post(Uri.parse('${baseUrl}student/student.php'), body: studentFilter);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> addStudent() async {
    final response = await client.post(
        Uri.parse('${baseUrl}student/add_student.php'),
        body: constants.addStudent);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateStudent(Map<String?, dynamic> updatedStudent) async {
    updatedStudent['وضعیت فعال بودن دانشجو'] =
        (updatedStudent['وضعیت فعال بودن دانشجو'] == 'فعال') ? 1 : 2;
    updatedStudent['نوع پذیرش'] =
        (updatedStudent['نوع پذیرش'] == 'روزانه') ? 1 : 2;

    Map<String, String> u = updatedStudent.map((key, value) {
      if (key == 'کدملی') {
        key = 'NationalCode';
      } else if (key == 'نام') {
        key = 'Name';
      } else if (key == 'نام خانوادگی') {
        key = 'LastName';
      } else if (key == 'کدپستی') {
        key = 'PostalCode';
      } else if (key == 'آدرس') {
        key = 'Address';
      } else if (key == 'استان') {
        key = 'State';
      } else if (key == 'شهر') {
        key = 'City';
      } else if (key == 'شماره دانشجویی') {
        key = 'StudentNumber';
      } else if (key == 'تاریخ شروع به تحصیل') {
        key = 'StartDateOfStudy';
      } else if (key == 'ترم ورود') {
        key = 'EntrySemester';
      } else if (key == 'وضعیت فعال بودن دانشجو') {
        key = 'ActivityCheckStatusCode';
      } else if (key == 'نوع پذیرش') {
        key = 'AcceptanceTypeCode';
      }
      return MapEntry(key!, value.toString());
    });

    final response = await client
        .post(Uri.parse('${baseUrl}student/update_student.php'), body: u);

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDormList() async {
    final response = await client.post(Uri.parse('${baseUrl}dorm/dorm.php'),
        body: dormFilter);
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getStudentDormList() async {
    final response = await client.post(Uri.parse('${baseUrl}dorm/student.php'),
        body: dormFilter);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDormFinanceList() async {
    final response = await client.post(
        Uri.parse('${baseUrl}dorm_finance/dorm_finance.php'),
        body: dormFinancesFilter);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> addDormFinance() async {
    debugPrint("${constants.addDormFinance}");
    final response = await client.post(
        Uri.parse('${baseUrl}dorm_finance/add_dorm_finance.php'),
        body: constants.addDormFinance);

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getViolationList() async {
    final response = await client.post(
        Uri.parse('${baseUrl}violation/violation.php'),
        body: violationFilter);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> addViolation() async {
    final response = await client.post(
        Uri.parse('${baseUrl}violation/add_violation.php'),
        body: constants.addViolation);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateViolation(Map<String?, dynamic> updateViolation) async {
    updateViolation['نوع تخلف'] =
        ["خاص", "عادی"].indexOf(updateViolation['نوع تخلف']) + 1;

    updateViolation['شرح تخلف'] = [
          "ایجاد مزاحمت و سر و صدا",
          "نوشتن شعارهای مغایر اصول و موازین اسلامی",
          "انجام اعمال خلاف اخلاق",
          "مصرف،فروش و کشت مواد مخدر",
          "حمل سلاح گرم یا سرد",
          "ارتکاب قتل"
        ].indexOf(updateViolation['شرح تخلف']) +
        1;

    updateViolation['نتیجه نهایی بررسی'] = [
          "تأیید و اخذ تعهد",
          "تأیید و تشکیل پرونده انضباطی",
          "عدم تأیید"
        ].indexOf(updateViolation['نتیجه نهایی بررسی']) +
        1;

    Map<String, String> u = updateViolation.map((key, value) {
      if (key == 'شماره دانشجویی') {
        key = 'StudentNumber';
      } else if (key == 'نوع تخلف') {
        key = 'ViolationCode';
      } else if (key == 'شرح تخلف') {
        key = 'ComplaintCode';
      } else if (key == 'نتیجه نهایی بررسی') {
        key = 'ViolationCheckCode';
      }
      return MapEntry(key!, value.toString());
    });

    final response = await client
        .post(Uri.parse('${baseUrl}violation/update_violation.php'), body: u);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateDormFinance(
      Map<String?, dynamic> updatedDormFinance) async {
    updatedDormFinance['وضعیت بررسی'] =
        ["تأیید", "عدم تأیید"].indexOf(updatedDormFinance['وضعیت بررسی']) + 1;

    updatedDormFinance['میزان خسارت وارده به اموال'] = [
          "20%",
          "40%",
          "60%",
          "80%",
          "100%",
          "0"
        ].indexOf(updatedDormFinance['میزان خسارت وارده به اموال']) +
        1;

    Map<String, String> u = updatedDormFinance.map((key, value) {
      if (key == 'شماره فیش') {
        key = 'DepositReceiptNumber';
      } else if (key == 'شماره دانشجویی') {
        key = 'StudentNumber';
      } else if (key == 'تاریخ ورود به خوابگاه') {
        key = 'DateOfArrivalAtTheHostel';
      } else if (key == 'تاریخ خروج از خوابگاه') {
        key = 'DateOfDeparture';
      } else if (key == 'مبلغ بدهی') {
        key = 'DebtAmount';
      } else if (key == 'نام کامل سرپرست خوابگاه') {
        key = 'FullNameOfTheHostelSupervisor';
      } else if (key == 'توضیحات بخش خوابگاه') {
        key = 'DescriptionOfTheDormitory';
      } else if (key == 'تاریخ تسویه حساب') {
        key = 'SettlementDate';
      } else if (key == 'تاریخ تکمیل فرم') {
        key = 'FormCompletionDate';
      } else if (key == 'مبلغ واریزی') {
        key = 'DepositAmount';
      } else if (key == 'تاریخ فیش') {
        key = 'DepositDate';
      } else if (key == 'وضعیت بررسی') {
        key = 'FinancialReviewStatusCode';
      } else if (key == 'میزان خسارت وارده به اموال') {
        key = 'PropertyDamageCode';
      }
      return MapEntry(key!, value.toString());
    });

    final response = await client.post(
        Uri.parse('${baseUrl}dorm_finance/update_dorm_finance.php'),
        body: u);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> addDorm() async {
    debugPrint("${constants.addDorm}");
    final response = await client.post(Uri.parse('${baseUrl}dorm/add_dorm.php'),
        body: constants.addDorm);

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateStudentDorm(Map<String?, dynamic> updatedDorm) async {
    updatedDorm['رشته تحصیلی'] = [
          "مهندسی صنایع",
          "مهندسی مکانیک",
          "مهندسی عمران",
          "مهندسی برق",
          "شیمی محض",
          "روانشناسی"
        ].indexOf(updatedDorm['رشته تحصیلی']) +
        1;

    updatedDorm['گروه'] = [
          "مهندسی صنایع",
          "مهندسی مکانیک",
          "مهندسی عمران",
          "مهندسی برق",
          "شیمی محض",
          "روانشناسی"
        ].indexOf(updatedDorm['گروه']) +
        1;

    updatedDorm['مقطع'] =
        ["کارشناسی", "ارشد", "دکترا"].indexOf(updatedDorm['مقطع']) + 1;

    updatedDorm['دانشکده'] =
        ["مهندسی", "انسانی", "علوم"].indexOf(updatedDorm['دانشکده']) + 1;

    updatedDorm['نام خوابگاه'] = [
          "شهید عسگری نژاد",
          "شهید بابازاده",
          "شهید فرجامی",
          "شهید ناصر بخت",
          "شهید علیخانی",
          "شهید نوری",
          "روغنی زنجانی",
          "دکترا 2"
        ].indexOf(updatedDorm['نام خوابگاه'].toString().trim()) +
        1;

    Map<String, String> u = updatedDorm.map((key, value) {
      if (key == 'شماره دانشجویی') {
        key = 'StudentNumber';
      } else if (key == 'دانشکده') {
        key = 'College';
      } else if (key == 'مقطع') {
        key = 'Section';
      } else if (key == 'گروه') {
        key = 'Department';
      } else if (key == 'رشته تحصیلی') {
        key = 'FieldOfStudy';
      } else if (key == 'نام خوابگاه') {
        key = 'HostelCode';
      } else if (key == 'شماره اتاق') {
        key = 'RoomCode';
      }
      return MapEntry(key!, value.toString());
    });

    final response = await client
        .post(Uri.parse('${baseUrl}dorm/update_student.php'), body: u);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateDorm(Map<String?, dynamic> updatedDorm) async {
    updatedDorm['وضعیت موجودی اموال خوابگاه'] = ["موجود", "ناموجود"]
            .indexOf(updatedDorm['وضعیت موجودی اموال خوابگاه']) +
        1;

    updatedDorm['اموال خوابگاه'] = [
          "میز",
          "موکت",
          "توری",
          "فرش",
          "صندلی",
          "نوپان",
          "کلید"
        ].indexOf(updatedDorm['اموال خوابگاه'].toString().trim()) +
        1;

    Map<String, String> u = updatedDorm.map((key, value) {
      if (key == 'شماره دانشجویی') {
        key = 'StudentNumber';
      } else if (key == 'اموال خوابگاه') {
        key = 'HostelProperty';
      } else if (key == 'وضعیت موجودی اموال خوابگاه') {
        key = 'InventoryOfTheHostelProperty';
      }
      return MapEntry(key!, value.toString());
    });

    final response =
        await client.post(Uri.parse('${baseUrl}dorm/update_dorm.php'), body: u);

    if (response.statusCode == 200) {
      return response.body == '1';
    } else {
      throw ServerException();
    }
  }
}
