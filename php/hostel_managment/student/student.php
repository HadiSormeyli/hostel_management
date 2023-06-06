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
$ActiveCheckStatus = $_POST["ActiveCheckStatus"];
$AcceptanceType = $_POST["AcceptanceType"];
$Residence = $_POST["Residence"];
$EntrySemester = $_POST["EntrySemester"];



  $query = "SELECT dbo.PersonalInformationOfStudents.NationalCode AS 'کدملی', dbo.PersonalInformationOfStudents.Name AS 'نام', dbo.PersonalInformationOfStudents.LastName AS 'نام خانوادگی', 
  dbo.PersonalContactInformationOfStudents.PostalCode AS 'کدپستی', dbo.LocationInformation.Address AS 'آدرس', dbo.LocationInformation.State AS 'استان', dbo.LocationInformation.City AS 'شهر', 
  dbo.StudentDormitoryRegistrationInputInformation.StudentNumber AS'شماره دانشجویی', dbo.AcademicInformationOfStudents.StartDateOfStudy AS 'تاریخ شروع به تحصیل', 
  dbo.AcademicInformationOfStudents.EntrySemester AS 'ترم ورود', dbo.InformationOnTheActiveStatusOfStudents.ActiveCheckStatus AS 'وضعیت فعال بودن دانشجو', dbo.AcceptanceTypeInformation.AcceptanceType AS 'نوع پذیرش'
FROM dbo.PersonalInformationOfStudents INNER JOIN
  dbo.PersonalContactInformationOfStudents ON dbo.PersonalInformationOfStudents.NationalCode = dbo.PersonalContactInformationOfStudents.NationalCode INNER JOIN
  dbo.LocationInformation ON dbo.PersonalContactInformationOfStudents.PostalCode = dbo.LocationInformation.PostalCode INNER JOIN
  dbo.StudentDormitoryRegistrationInputInformation ON dbo.PersonalInformationOfStudents.NationalCode = dbo.StudentDormitoryRegistrationInputInformation.NationalCode INNER JOIN
  dbo.AcademicInformationOfStudents ON dbo.StudentDormitoryRegistrationInputInformation.StudentNumber = dbo.AcademicInformationOfStudents.StudentNumber INNER JOIN
  dbo.StudentContactInformation ON dbo.AcademicInformationOfStudents.StudentNumber = dbo.StudentContactInformation.StudentNumber INNER JOIN
  dbo.AcceptanceTypeInformation ON dbo.StudentContactInformation.AcceptanceTypeCode = dbo.AcceptanceTypeInformation.AcceptanceTypeCode INNER JOIN
  dbo.InformationOnTheActiveStatusOfStudents ON dbo.StudentContactInformation.ActivityCheckStatusCode = dbo.InformationOnTheActiveStatusOfStudents.ActivityCheckStatusCode
WHERE dbo.StudentDormitoryRegistrationInputInformation.StudentNumber like '%$StudentNumber%'";

if ($ActiveCheckStatus != '-1') {
  $query .= "AND (dbo.InformationOnTheActiveStatusOfStudents.ActivityCheckStatusCode = '$ActiveCheckStatus')";
}

if ($AcceptanceType != '-1') {
  $query .= "AND (dbo.AcceptanceTypeInformation.AcceptanceTypeCode = '$AcceptanceType')";
}

if ($Residence == '0') {
  $query .= "AND (dbo.LocationInformation.City <> N'زنجان')";
} else if($Residence == '1') {
  $query .= "AND (dbo.LocationInformation.City = N'زنجان')";
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
