<?php
// personal info
$NationalCode = $_POST["NationalCode"];
$Name = $_POST["Name"];
$LastName = $_POST["LastName"];
$IdNumber = $_POST["IdNumber"];
$IdentitySerialNumber = $_POST["IdentitySerialNumber"];
$Nationality = $_POST["Nationality"];
$Religion = $_POST["Religion"];
$Gilder = $_POST["Gilder"];
$CellularPhone = $_POST["CellularPhone"];
$MothersPhone = $_POST["MothersPhone"];
$FathersPhone = $_POST["FathersPhone"];
$EmailAddress = $_POST["EmailAddress"];
$FathersName = $_POST["FathersName"];
$MothersName = $_POST["MothersName"];
$BirthPlace = $_POST["BirthPlace"];
$BirthCertificateIssuingPlace = $_POST["BirthCertificateIssuingPlace"];
$DateOfBirth = $_POST["DateOfBirth"];


$GenderCode = $_POST["GenderCode"];
$MaritalStatusCode = $_POST["MaritalStatusCode"];
$DutySystemCode = $_POST["DutySystemCode"];
$PostalCode = $_POST["PostalCode"];

$Address = $_POST["Address"];
$State = $_POST["State"];
$City = $_POST["City"];

// educational info
$StudentNumber = $_POST["StudentNumber"];
$StartDateOfStudy= $_POST["StartDateOfStudy"];
$DateOfGraduation = $_POST["DateOfGraduation"];
$EntrySemester = $_POST["EntrySemester"];

$FieldOfStudyCode = $_POST["FieldOfStudyCode"];
$OrientationCode = $_POST["OrientationCode"];
$AcceptanceTypeCode = $_POST["AcceptanceTypeCode"];
$GroupCode = $_POST["GroupCode"];
$SectionCode = $_POST["SectionCode"];
$CollegeCode = $_POST["CollegeCode"];
$ActivityCheckStatusCode = $_POST["ActivityCheckStatusCode"];



$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);


$sqlAcademic = "INSERT [dbo].[AcademicInformationOfStudents] ([StudentNumber], [StartDateOfStudy], [DateOfGraduation], [EntrySemester]) VALUES (?, ?, ?, ?)";
$paramsAcademic = array((int)$StudentNumber,$StartDateOfStudy,$DateOfGraduation,$EntrySemester);
$stmtAcademic = sqlsrv_query($conn, $sqlAcademic,$paramsAcademic);

$sqlStudentCon ="INSERT [dbo].[StudentContactInformation] ([StudentNumber], [FieldOfStudyCode], [OrientationCode], [AcceptanceTypeCode], [GroupCode], [SectionCode], [CollegeCode], [ActivityCheckStatusCode]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
$paramsStudentCon = array((int)$StudentNumber,(int) $FieldOfStudyCode,(int)$OrientationCode,(int)$AcceptanceTypeCode,(int)$GroupCode,(int)$SectionCode,(int)$CollegeCode,(int)$ActivityCheckStatusCode);
$stmtStudentCon = sqlsrv_query($conn, $sqlStudentCon,$paramsStudentCon);

$sqlPersonal = "INSERT [dbo].[PersonalInformationOfStudents] ([NationalCode], [Name], [LastName], [IdNumber], [IdentitySerialNumber], [Nationality], [Religion], [Gilder], [CellularPhone], [MothersPhone], [FathersPhone], [EmailAddress], [FathersName], [MothersName], [BirthPlace], BirthCertificateIssuingPlace, DateOfBirth) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
$paramsPersonal = array((int) $NationalCode,$Name,$LastName,(int)$IdNumber,(int)$IdentitySerialNumber,$Nationality,$Religion,$Gilder,(float)$CellularPhone,(int)$MothersPhone,(int)$FathersPhone,$EmailAddress,$FathersName,$MothersName,$BirthPlace,$BirthCertificateIssuingPlace,$DateOfBirth);
$stmtPersonal = sqlsrv_query($conn, $sqlPersonal,$paramsPersonal);

$sqlLocation = "INSERT [dbo].[LocationInformation] ([PostalCode], [Address], [State], [City]) VALUES (?, ?, ?, ?)";
$paramsLocation = array((int)$PostalCode,$Address,$State,$City);
$stmtLocation = sqlsrv_query($conn, $sqlLocation,$paramsLocation);

$sqlContact = "INSERT [dbo].[PersonalContactInformationOfStudents] ([NationalCode], [GenderCode], [MaritalStatusCode], [DutySystemCode], [PostalCode]) VALUES (?, ?, ?, ?, ?)";
$paramsContact = array((int)$NationalCode,(int)$GenderCode,(int)$MaritalStatusCode,(int)$DutySystemCode,(int)$PostalCode);
$stmtContact = sqlsrv_query($conn, $sqlContact,$paramsContact);

$sqlDorm = "INSERT [dbo].[StudentDormitoryRegistrationInputInformation] ([Password], [NationalCode], [StudentNumber]) VALUES (?, ?, ?)";
$paramsDorm = array('123456',(int)$NationalCode,(int)$StudentNumber);
$stmtDorm = sqlsrv_query($conn, $sqlDorm,$paramsDorm);


if($stmtAcademic == false || $stmtDorm == false || $stmtPersonal == false || $stmtContact == false || $stmtLocation == false || $stmtStudentCon == false)  die(print_r(sqlsrv_errors(), true));
sqlsrv_free_stmt($stmtPersonal);
sqlsrv_free_stmt($stmtContact);
sqlsrv_free_stmt($stmtLocation);
sqlsrv_free_stmt($stmtAcademic);
sqlsrv_free_stmt($stmtStudentCon);
sqlsrv_free_stmt($stmtDorm);
echo 1;

sqlsrv_close($conn);
?>
