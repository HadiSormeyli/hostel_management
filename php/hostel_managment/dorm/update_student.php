<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);



$sqlHostel = "UPDATE dbo.HostelContactInformation SET HostelCode = ?, RoomCode = ? WHERE StudentNumber = ?";
$paramsHostel = array((int)$_POST['HostelCode'], (int)$_POST['RoomCode'], (int)$_POST['StudentNumber']);
$stmtHostel = sqlsrv_query($conn, $sqlHostel,$paramsHostel);

$sqlStudentCon = "UPDATE dbo.StudentContactInformation SET FieldOfStudyCode = ?, GroupCode = ?, SectionCode = ?, CollegeCode = ? WHERE StudentNumber = ?";
$paramsStudentCon = array((int)$_POST['FieldOfStudy'], (int)$_POST['Department'], (int)$_POST['Section'], (int)$_POST['College'],(int)$_POST['StudentNumber']);
$stmtStudentCon = sqlsrv_query($conn, $sqlStudentCon,$paramsStudentCon);


if ($stmtStudentCon === false || $stmtHostel === false) {
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_free_stmt($stmtStudentCon);
sqlsrv_free_stmt($stmtHostel);

echo 1;

sqlsrv_close($conn);
?>