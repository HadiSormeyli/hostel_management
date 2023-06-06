<?php

//FinancialTransactionInformation

$DepositReceiptNumber = $_POST["DepositReceiptNumber"];
$DepositAmount = $_POST["DepositAmount"];
$DepositDate = $_POST["DepositDate"];


// StudentDormitoryFinancialContactInformation
$StudentNumber = $_POST["StudentNumber"];
$HostelPropertyCode = $_POST["HostelPropertyCode"];
$PropertyDamageCode = $_POST["PropertyDamageCode"];
$FinancialReviewStatusCode = $_POST["FinancialReviewStatusCode"];

// StudentDormitoryFinancialInformation
$DateOfArrivalAtTheHostel = $_POST["DateOfArrivalAtTheHostel"];
$DateOfDeparture = $_POST["DateOfDeparture"];
$DebtAmount = $_POST["DebtAmount"];
$FullNameOfTheHostelSupervisor = $_POST["FullNameOfTheHostelSupervisor"];
$DescriptionOfTheDormitory = $_POST["DescriptionOfTheDormitory"];
$SettlementDate = $_POST["SettlementDate"];
$FormCompletionDate = $_POST["FormCompletionDate"];




$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);



$sqlTransaction = "INSERT [dbo].[FinancialTransactionInformation] ([DepositReceiptNumber], [DepositAmount], [DepositDate]) VALUES (?, ?, ?)";
$paramsTransaction = array((int)$DepositReceiptNumber,(int)$DepositAmount,$DepositDate);
$stmtTransaction = sqlsrv_query($conn, $sqlTransaction,$paramsTransaction);


$sqlFinancial = "INSERT [dbo].[StudentDormitoryFinancialInformation] ([DormitoryFinancialCode], [DateOfArrivalAtTheHostel], [DateOfDeparture], [DebtAmount], [FullNameOfTheHostelSupervisor], [DescriptionOfTheDormitory], [SettlementDate], [FormCompletionDate]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
$paramsFinancial = array((int)$DepositReceiptNumber,$DateOfArrivalAtTheHostel,$DateOfDeparture,(int)$DebtAmount,$FullNameOfTheHostelSupervisor,$DescriptionOfTheDormitory,$SettlementDate,$FormCompletionDate);
$stmtFinancial = sqlsrv_query($conn, $sqlFinancial,$paramsFinancial);

$sqlDormitory = "INSERT [dbo].[StudentDormitoryFinancialContactInformation] ([StudentNumber], [HostelPropertyCode], [DepositReceiptNumber], [PropertyDamageCode], [FinancialReviewStatusCode], [DormitoryFinancialCode]) VALUES (?, ?, ?, ?, ?, ?)";
$paramsDormitory = array((int)$StudentNumber,(int)$HostelPropertyCode,(int)$DepositReceiptNumber,(int)$PropertyDamageCode,(int)$FinancialReviewStatusCode,(int)$DepositReceiptNumber);
$stmtDormitory = sqlsrv_query($conn, $sqlDormitory,$paramsDormitory);


if($stmtTransaction == false || $stmtDormitory == false ||$stmtFinancial == false)  {
    die(print_r(sqlsrv_errors(), true));
}

sqlsrv_free_stmt($stmtTransaction);
sqlsrv_free_stmt($stmtDormitory);
sqlsrv_free_stmt($stmtFinancial);


echo 1;

sqlsrv_close($conn);
?>
