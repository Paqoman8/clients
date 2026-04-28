<?php
require '../db.php';

$sql = "SELECT * FROM client";
$stmt = $pdo->query($sql);
$clients = $stmt->fetchAll();

echo json_encode($clients);
?>