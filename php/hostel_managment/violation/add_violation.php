<?php

$StudentNumber = $_POST["StudentNumber"];
$ComplaintCode = $_POST["ComplaintCode"];
$ViolationCode = $_POST["ViolationCode"];
$ViolationCheckCode = $_POST["ViolationCheckCode"];



$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);


$sqlComplaints = "INSERT [dbo].[ComplaintsInterfaceInformation] ([StudentNumber], [ComplaintCode], [ViolationCode], [ViolationCheckCode]) VALUES (?, ?, ?, ?)";
$paramsComplaints = array((int)$StudentNumber,(int)$ComplaintCode,(int)$ViolationCode,(int)$ViolationCheckCode);
$stmtComplaints = sqlsrv_query($conn, $sqlComplaints,$paramsComplaints);

if($stmtComplaints == false) {
    die(print_r(sqlsrv_errors(), true));
}

sqlsrv_free_stmt($stmtComplaints);

echo 1;

sqlsrv_close($conn);
?>
