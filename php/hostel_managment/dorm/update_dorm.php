<?php

$serverName = "(local)";
$connectionOptions = array(
    "Database" => "DB_DormitoryAffairs",
    "Uid" => "",
    "PWD" => "",
    "CharacterSet" =>"UTF-8"
);
$conn = sqlsrv_connect($serverName, $connectionOptions);


$sqlHostel = "UPDATE dbo.HostelContactInformation SET HostelPropertyCode = ?, InventoryOfTheHostelPropertyCode = ? WHERE StudentNumber = ?";
$paramsHostel = array((int)$_POST['HostelProperty'], (int)$_POST['InventoryOfTheHostelProperty'], (int)$_POST['StudentNumber']);
$stmtHostel = sqlsrv_query($conn, $sqlHostel,$paramsHostel);


if ($stmtHostel === false) {
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_free_stmt($stmtHostel);

echo 1;

sqlsrv_close($conn);
?>