<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);

$sqlComplaints = "UPDATE dbo.ComplaintsInterfaceInformation SET ComplaintCode = ?, ViolationCode = ?, ViolationCheckCode = ? WHERE StudentNumber = ?";
$paramsComplaints = array((int)$_POST['ComplaintCode'], (int)$_POST['ViolationCode'], (int)$_POST['ViolationCheckCode'], (int)$_POST['StudentNumber']);
$stmtComplaints = sqlsrv_query($conn, $sqlComplaints,$paramsComplaints);


if ($stmtComplaints === false) {
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_free_stmt($stmtComplaints);

echo 1;

sqlsrv_close($conn);
?>