const baseUrl = 'http://localhost/hostel_managment/';

final Map<String, String> studentFilter = {
  "StudentNumber": "",
  "AcceptanceType": '-1',
  "ActiveCheckStatus": '-1',
  "Residence": '-1',
  "EntrySemester": '-1'
};

final Map<String, String> dormFilter = {
  "HostelCode": "-1",
  "RoomNumber": '-1',
  "InventoryOfTheHostelPropertyCode": '-1',
  "HostelPropertyCode": '-1'
};

final Map<String, String> dormFinancesFilter = {
  "StudentNumber": "",
  "DateOfArrivalAtTheHostel": '-1',
  "FinancialReviewStatusCode": '-1',
};

final Map<String, String> violationFilter = {
  "StudentNumber": "",
  "ViolationCode": '-1',
  "EntrySemester": '-1'
};

late Map<String, String> addStudent;
late Map<String, String> addDorm;
late Map<String, String> addDormFinance;
late Map<String, String> addViolation;
