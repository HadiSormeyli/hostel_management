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
$InventoryOfTheHostelPropertyCode = $_POST["InventoryOfTheHostelPropertyCode"];
$HostelPropertyCode = $_POST["HostelPropertyCode"];
$RoomNumber = $_POST["RoomNumber"];


$query_dorm = "SELECT dbo.HostelContactInformation.StudentNumber AS [شماره دانشجویی], dbo.HostelInformation.HostelName AS [نام خوابگاه], dbo.RoomInformation.RoomNumber AS [شماره اتاق], dbo.HostelPropertyInformation.HostelProperty AS [اموال خوابگاه], 
dbo.InventoryOfTheHostelPropertyInformation.InventoryOfTheHostelProperty AS [وضعیت موجودی اموال خوابگاه]
FROM  dbo.HostelInformation INNER JOIN
dbo.HostelContactInformation ON dbo.HostelInformation.HostelCode = dbo.HostelContactInformation.HostelCode INNER JOIN
dbo.HostelPropertyInformation ON dbo.HostelContactInformation.HostelPropertyCode = dbo.HostelPropertyInformation.HostelPropertyCode INNER JOIN
dbo.RoomInformation ON dbo.HostelContactInformation.RoomCode = dbo.RoomInformation.RoomCode INNER JOIN
dbo.InventoryOfTheHostelPropertyInformation ON dbo.HostelContactInformation.InventoryOfTheHostelPropertyCode = dbo.InventoryOfTheHostelPropertyInformation.InventoryOfTheHostelPropertyCode
WHERE (dbo.HostelInformation.HostelCode != -1)";

if ($HostelCode != '-1') {
  $query_dorm .= "AND (dbo.HostelInformation.HostelCode = '$HostelCode')";
}

if ($InventoryOfTheHostelPropertyCode != '-1') {
$query_dorm .= "AND (dbo.InventoryOfTheHostelPropertyInformation.InventoryOfTheHostelPropertyCode = '$InventoryOfTheHostelPropertyCode')";
}

if ($HostelPropertyCode != '-1') {
$query_dorm .= "AND (dbo.HostelContactInformation.HostelPropertyCode = '$HostelPropertyCode')";
}

if ($RoomNumber != '-1') {
  $query_dorm .= "AND (dbo.RoomInformation.RoomNumber = '$RoomNumber')";
}


$stmtDorm = sqlsrv_query($conn, $query_dorm);

if ($stmtDorm == false) {
  die(print_r(sqlsrv_errors(), true));
}

$dataDorm = array();
while ($row = sqlsrv_fetch_array($stmtDorm, SQLSRV_FETCH_ASSOC)) {
  $dataDorm[] = $row;
}


$json_data = json_encode($dataDorm);


header("Content-Type: application/json");

echo $json_data;

sqlsrv_free_stmt($stmtDorm);
sqlsrv_close($conn);
?>
