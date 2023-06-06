<?php
// personal info
$StudentNumber = $_POST["StudentNumber"];
$HostelCode = $_POST["HostelCode"];
$RoomCode = $_POST["RoomCode"];
$InventoryOfTheHostelPropertyCode = $_POST["InventoryOfTheHostelPropertyCode"];
$HostelPropertyCode = $_POST["HostelPropertyCode"];


$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);


$sqlHostel = "INSERT [dbo].[HostelContactInformation] ([StudentNumber], [HostelCode], [RoomCode], [InventoryOfTheHostelPropertyCode], [HostelPropertyCode]) VALUES (?, ?, ?, ?, ?)";
$paramsHostel = array((int)$StudentNumber,$HostelCode,$RoomCode,$InventoryOfTheHostelPropertyCode,$HostelPropertyCode);
$stmtHostel = sqlsrv_query($conn, $sqlHostel,$paramsHostel);


if($stmtHostel == false ) {
    die(print_r(sqlsrv_errors(), true));
} 
sqlsrv_free_stmt($stmtHostel);

echo 1;

sqlsrv_close($conn);
?>
