<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);

$sqlDormitory = "UPDATE dbo.StudentDormitoryFinancialContactInformation SET FinancialReviewStatusCode = ?, PropertyDamageCode = ? WHERE DormitoryFinancialCode = ? AND StudentNumber = ?";
$paramsDormitory = array((int)$_POST['FinancialReviewStatusCode'],(int)$_POST['PropertyDamageCode'], (int)$_POST['DepositReceiptNumber'],(int)$_POST['StudentNumber']);
$stmtDormitory = sqlsrv_query($conn, $sqlDormitory,$paramsDormitory);

$sqlTransaction = "UPDATE dbo.FinancialTransactionInformation SET DepositAmount = ?, DepositDate = ? WHERE DepositReceiptNumber = ?";
$paramsTransaction = array((int)$_POST['DepositAmount'], $_POST['DepositDate'], (int)$_POST['DepositReceiptNumber']);
$stmtTransaction = sqlsrv_query($conn, $sqlTransaction,$paramsTransaction);

$sqlFinancial = "UPDATE dbo.StudentDormitoryFinancialInformation SET DateOfArrivalAtTheHostel = ?,DateOfDeparture = ?,DebtAmount = ?,FullNameOfTheHostelSupervisor = ?,DescriptionOfTheDormitory = ?,SettlementDate = ?,FormCompletionDate = ? WHERE DormitoryFinancialCode = ?";
$paramsFinancial = array($_POST['DateOfArrivalAtTheHostel'],$_POST['DateOfDeparture'],(int)$_POST['DebtAmount'],$_POST['FullNameOfTheHostelSupervisor'],$_POST['DescriptionOfTheDormitory'],$_POST['SettlementDate'],$_POST['FormCompletionDate'],(int)$_POST['DepositReceiptNumber']);
$stmtFinancial = sqlsrv_query($conn, $sqlFinancial,$paramsFinancial);



if ($stmtTransaction === false || $stmtFinancial == false || $stmtDormitory == false) {
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_free_stmt($stmtTransaction);
sqlsrv_free_stmt($stmtFinancial);
sqlsrv_free_stmt($stmtDormitory);

echo 1;

sqlsrv_close($conn);
?>