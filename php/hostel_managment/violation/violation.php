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
$EntrySemester = $_POST["EntrySemester"];
$ViolationCode = $_POST["ViolationCode"];

$query = "SELECT dbo.StudentDormitoryRegistrationInputInformation.StudentNumber AS 'شماره دانشجویی', dbo.PersonalInformationOfStudents.Name AS 'نام', dbo.PersonalInformationOfStudents.LastName AS 'نام خانوادگی', 
dbo.ViolationTypeInformation.TypeOfViolation AS 'نوع تخلف', dbo.InformationOnRegisteredComplaints.DescriptionOfTheViolation AS 'شرح تخلف', 
dbo.ViolationInvestigationInformation.TheFinalResultOfTheReview AS 'نتیجه نهایی بررسی'
FROM dbo.PersonalInformationOfStudents INNER JOIN
dbo.StudentDormitoryRegistrationInputInformation ON dbo.PersonalInformationOfStudents.NationalCode = dbo.StudentDormitoryRegistrationInputInformation.NationalCode INNER JOIN
dbo.AcademicInformationOfStudents ON dbo.StudentDormitoryRegistrationInputInformation.StudentNumber = dbo.AcademicInformationOfStudents.StudentNumber INNER JOIN
dbo.ComplaintsInterfaceInformation ON dbo.AcademicInformationOfStudents.StudentNumber = dbo.ComplaintsInterfaceInformation.StudentNumber INNER JOIN
dbo.ViolationTypeInformation ON dbo.ComplaintsInterfaceInformation.ViolationCode = dbo.ViolationTypeInformation.ViolationCode INNER JOIN
dbo.ViolationInvestigationInformation ON dbo.ComplaintsInterfaceInformation.ViolationCheckCode = dbo.ViolationInvestigationInformation.ViolationCheckCode INNER JOIN
dbo.InformationOnRegisteredComplaints ON dbo.ComplaintsInterfaceInformation.ComplaintCode = dbo.InformationOnRegisteredComplaints.ComplaintCode
WHERE dbo.StudentDormitoryRegistrationInputInformation.StudentNumber like '%$StudentNumber%'";


if ($ViolationCode != '-1') {
$query .= "AND (dbo.ViolationTypeInformation.ViolationCode = '$ViolationCode')";
}

if ($EntrySemester != '-1') {
$query .= " AND  (dbo.AcademicInformationOfStudents.StartDateOfStudy = '$EntrySemester')";
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
