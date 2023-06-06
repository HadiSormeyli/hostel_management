<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);

$HostelCode = $_POST["HostelCode"];
$RoomNumber = $_POST["RoomNumber"];


$query_student = "SELECT dbo.PersonalInformationOfStudents.Name AS [نام], dbo.PersonalInformationOfStudents.LastName AS [نام خانوادگی], dbo.StudentDormitoryRegistrationInputInformation.StudentNumber AS [شماره دانشجویی], 
dbo.FieldOfStudyInformation.FieldOfStudy AS [رشته تحصیلی], dbo.GroupInformation.Department AS گروه, dbo.AcceptanceTypeInformation.AcceptanceType AS [نوع پذیرش], dbo.SectionInformation.Section AS مقطع, 
dbo.CollegeInformation.College AS دانشکده, dbo.InformationOnTheActiveStatusOfStudents.ActiveCheckStatus AS [وضعیت فعال بودن دانشجو], dbo.RoomInformation.RoomNumber AS [شماره اتاق], 
dbo.RoomInformation.RoomCapacity AS [ظرفیت اتاق], dbo.HostelInformation.HostelName AS [نام خوابگاه], 
dbo.AcademicInformationOfStudents.StartDateOfStudy AS [تاریخ شروع به تحصیل]
FROM dbo.PersonalInformationOfStudents INNER JOIN
dbo.StudentDormitoryRegistrationInputInformation ON dbo.PersonalInformationOfStudents.NationalCode = dbo.StudentDormitoryRegistrationInputInformation.NationalCode INNER JOIN
dbo.AcademicInformationOfStudents ON dbo.StudentDormitoryRegistrationInputInformation.StudentNumber = dbo.AcademicInformationOfStudents.StudentNumber INNER JOIN
dbo.StudentContactInformation ON dbo.AcademicInformationOfStudents.StudentNumber = dbo.StudentContactInformation.StudentNumber INNER JOIN
dbo.FieldOfStudyInformation ON dbo.StudentContactInformation.FieldOfStudyCode = dbo.FieldOfStudyInformation.FieldOfStudyCode INNER JOIN
dbo.OrientationInformation ON dbo.StudentContactInformation.OrientationCode = dbo.OrientationInformation.OrientationCode INNER JOIN
dbo.AcceptanceTypeInformation ON dbo.StudentContactInformation.AcceptanceTypeCode = dbo.AcceptanceTypeInformation.AcceptanceTypeCode INNER JOIN
dbo.GroupInformation ON dbo.StudentContactInformation.GroupCode = dbo.GroupInformation.GroupCode INNER JOIN
dbo.SectionInformation ON dbo.StudentContactInformation.SectionCode = dbo.SectionInformation.SectionCode INNER JOIN
dbo.CollegeInformation ON dbo.StudentContactInformation.CollegeCode = dbo.CollegeInformation.CollegeCode INNER JOIN
dbo.InformationOnTheActiveStatusOfStudents ON dbo.StudentContactInformation.ActivityCheckStatusCode = dbo.InformationOnTheActiveStatusOfStudents.ActivityCheckStatusCode INNER JOIN
dbo.HostelContactInformation ON dbo.AcademicInformationOfStudents.StudentNumber = dbo.HostelContactInformation.StudentNumber INNER JOIN
dbo.HostelInformation ON dbo.HostelContactInformation.HostelCode = dbo.HostelInformation.HostelCode INNER JOIN
dbo.RoomInformation ON dbo.HostelContactInformation.RoomCode = dbo.RoomInformation.RoomCode
WHERE (dbo.HostelInformation.HostelCode != -1)";

if ($HostelCode != '-1') {
    $query_student .= "AND (dbo.HostelInformation.HostelCode = '$HostelCode')";
}

if ($RoomNumber != '-1') {
    $query_student .= "AND (dbo.RoomInformation.RoomNumber = '$RoomNumber')";
}

$query_student.="GROUP BY dbo.PersonalInformationOfStudents.Name, dbo.PersonalInformationOfStudents.LastName, dbo.StudentDormitoryRegistrationInputInformation.StudentNumber, dbo.FieldOfStudyInformation.FieldOfStudy, 
dbo.GroupInformation.Department, dbo.AcceptanceTypeInformation.AcceptanceType, dbo.SectionInformation.Section, dbo.CollegeInformation.College, dbo.InformationOnTheActiveStatusOfStudents.ActiveCheckStatus, 
dbo.RoomInformation.RoomNumber, dbo.RoomInformation.RoomCapacity, dbo.HostelInformation.HostelName, dbo.HostelInformation.HostelCapacity, dbo.AcademicInformationOfStudents.StartDateOfStudy";

$stmtStudent = sqlsrv_query($conn, $query_student);

if ($stmtStudent == false) {
  die(print_r(sqlsrv_errors(), true));
}

$dataStudent= array();
while ($row = sqlsrv_fetch_array($stmtStudent, SQLSRV_FETCH_ASSOC)) {
  $dataStudent[] = $row;
}

$json_data = json_encode($dataStudent);


header("Content-Type: application/json");

echo $json_data;

sqlsrv_free_stmt($stmtStudent);
sqlsrv_close($conn);
?>
