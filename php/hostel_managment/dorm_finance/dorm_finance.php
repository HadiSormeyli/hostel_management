<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);

$StudentNumber = $_POST["StudentNumber"];
$DateOfArrivalAtTheHostel = $_POST["DateOfArrivalAtTheHostel"];
$FinancialReviewStatusCode = $_POST["FinancialReviewStatusCode"];

$query = "SELECT dbo.FinancialTransactionInformation.DepositReceiptNumber As [شماره فیش], dbo.StudentDormitoryRegistrationInputInformation.StudentNumber AS [شماره دانشجویی], dbo.PersonalInformationOfStudents.Name AS نام, dbo.PersonalInformationOfStudents.LastName AS [نام خانوادگی], 
dbo.StudentDormitoryFinancialInformation.DateOfArrivalAtTheHostel AS [تاریخ ورود به خوابگاه], dbo.StudentDormitoryFinancialInformation.DateOfDeparture AS [تاریخ خروج از خوابگاه], 
dbo.StudentDormitoryFinancialInformation.DebtAmount AS [مبلغ بدهی], dbo.StudentDormitoryFinancialInformation.FullNameOfTheHostelSupervisor AS [نام کامل سرپرست خوابگاه], 
dbo.StudentDormitoryFinancialInformation.DescriptionOfTheDormitory AS [توضیحات بخش خوابگاه], dbo.StudentDormitoryFinancialInformation.SettlementDate AS [تاریخ تسویه حساب], 
dbo.StudentDormitoryFinancialInformation.FormCompletionDate AS [تاریخ تکمیل فرم], dbo.FinancialTransactionInformation.DepositAmount AS [مبلغ واریزی], dbo.FinancialTransactionInformation.DepositDate AS [تاریخ فیش], 
dbo.FinancialReviewStatusInformation.FinancialReviewStatus AS [وضعیت بررسی], dbo.DamagedPropertyInformation.TheAmountOfDamageCaused AS [میزان خسارت وارده به اموال]
FROM  dbo.PersonalInformationOfStudents INNER JOIN
dbo.StudentDormitoryRegistrationInputInformation ON dbo.PersonalInformationOfStudents.NationalCode = dbo.StudentDormitoryRegistrationInputInformation.NationalCode INNER JOIN
dbo.AcademicInformationOfStudents ON dbo.StudentDormitoryRegistrationInputInformation.StudentNumber = dbo.AcademicInformationOfStudents.StudentNumber INNER JOIN
dbo.StudentDormitoryFinancialContactInformation ON dbo.AcademicInformationOfStudents.StudentNumber = dbo.StudentDormitoryFinancialContactInformation.StudentNumber INNER JOIN
dbo.StudentDormitoryFinancialInformation ON dbo.StudentDormitoryFinancialContactInformation.DormitoryFinancialCode = dbo.StudentDormitoryFinancialInformation.DormitoryFinancialCode INNER JOIN
dbo.FinancialTransactionInformation ON dbo.StudentDormitoryFinancialContactInformation.DepositReceiptNumber = dbo.FinancialTransactionInformation.DepositReceiptNumber INNER JOIN
dbo.FinancialReviewStatusInformation ON dbo.StudentDormitoryFinancialContactInformation.FinancialReviewStatusCode = dbo.FinancialReviewStatusInformation.FinancialReviewStatusCode INNER JOIN
dbo.DamagedPropertyInformation ON dbo.StudentDormitoryFinancialContactInformation.PropertyDamageCode = dbo.DamagedPropertyInformation.PropertyDamageCode
WHERE dbo.StudentDormitoryRegistrationInputInformation.StudentNumber like '%$StudentNumber%'";


if ($FinancialReviewStatusCode != '-1') {
$query .= "AND (dbo.FinancialReviewStatusInformation.FinancialReviewStatusCode = '$FinancialReviewStatusCode')";
}

if ($DateOfArrivalAtTheHostel != '-1') {
$query .= " AND  (dbo.StudentDormitoryFinancialInformation.DateOfArrivalAtTheHostel = '$DateOfArrivalAtTheHostel')";
}


$stmt = sqlsrv_query($conn, $query);

if ($stmt == false) {
  die(print_r(sqlsrv_errors(), true));
}

$data = array();
while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
  $data[] = $row;
}

$json_data = json_encode($data);

header("Content-Type: application/json");

echo $json_data;

sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);
?>
