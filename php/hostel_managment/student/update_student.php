<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);


$sqlStudentCon = "UPDATE dbo.StudentContactInformation SET AcceptanceTypeCode = ?, ActivityCheckStatusCode = ? WHERE StudentNumber = ?";
$paramsStudentCon = array((int)$_POST['AcceptanceTypeCode'], (int)$_POST['ActivityCheckStatusCode'], (int)$_POST['StudentNumber']);
$stmtStudentCon = sqlsrv_query($conn, $sqlStudentCon,$paramsStudentCon);


$sqlPost = "SELECT PostalCode as CODE FROM dbo.PersonalContactInformationOfStudents WHERE NationalCode = ?";
$paramsPost = array((int)$_POST['NationalCode']);
$stmtPost = sqlsrv_query($conn, $sqlPost,$paramsPost);
$row = sqlsrv_fetch_array($stmtPost, SQLSRV_FETCH_ASSOC);
$postCode = $row['CODE'];

$sqlDeletePost = "DELETE FROM dbo.LocationInformation WHERE PostalCode = ?";
$paramsDeletePost = array($postCode);
$stmtDeletePost = sqlsrv_query($conn, $sqlDeletePost,$paramsDeletePost);


$sqlAcademic = "UPDATE dbo.AcademicInformationOfStudents SET StartDateOfStudy = ?, EntrySemester = ? WHERE StudentNumber = ?";
$paramsAcademic = array($_POST['StartDateOfStudy'], $_POST['EntrySemester'],(int) $_POST['StudentNumber']);
$stmtAcademic = sqlsrv_query($conn, $sqlAcademic,$paramsAcademic);

$sqlPersonal = "UPDATE dbo.PersonalInformationOfStudents SET Name = ?, LastName = ? WHERE NationalCode = ?";
$paramsPersonal = array($_POST['Name'], $_POST['LastName'], (int)$_POST['NationalCode']);
$stmtPersonal = sqlsrv_query($conn, $sqlPersonal,$paramsPersonal);

$sqlLocation = "INSERT [dbo].[LocationInformation] ([PostalCode], [Address], [State], [City]) VALUES (?, ?, ?, ?)";
$paramsLocation = array((int)$_POST['PostalCode'],$_POST['Address'],$_POST['State'],$_POST['City']);
$stmtLocation = sqlsrv_query($conn, $sqlLocation,$paramsLocation);

$sqlContact = "UPDATE dbo.PersonalContactInformationOfStudents SET PostalCode = ? WHERE NationalCode = ?";
$paramsContact = array((int)$_POST['PostalCode'],(int)$_POST['NationalCode']);
$stmtContact = sqlsrv_query($conn, $sqlContact,$paramsContact);


if ($stmtAcademic === false || $stmtStudentCon == false || $stmtPersonal == false || $stmtLocation == false || $stmtContact == false) {
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_free_stmt($stmtPersonal);
sqlsrv_free_stmt($stmtAcademic);
sqlsrv_free_stmt($stmtContact);
sqlsrv_free_stmt($stmtLocation);
sqlsrv_free_stmt($stmtStudentCon);

echo 1;

sqlsrv_close($conn);
?>