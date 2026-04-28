<?php
require '../db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    $sql = "INSERT INTO client (
                type_client, nom, prenom, raison_sociale, telephone, email, adresse, taux_remise, etat, user_creation, date_creation
            ) VALUES (
                :type_client, :nom, :prenom, :raison_sociale, :telephone, :email, :adresse, :taux_remise, :etat, 'api_user', NOW()
            )";

    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        ':type_client' => $data['type_client'],
        ':nom' => $data['nom'],
        ':prenom' => $data['prenom'],
        ':raison_sociale' => $data['raison_sociale'],
        ':telephone' => $data['telephone'],
        ':email' => $data['email'],
        ':adresse' => $data['adresse'],
        ':taux_remise' => $data['taux_remise'],
        ':etat' => $data['etat']
    ]);

    $lastId = $pdo->lastInsertId();
    $data['id'] = $lastId;

    echo json_encode($data);
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Method Not Allowed']);
}
?>