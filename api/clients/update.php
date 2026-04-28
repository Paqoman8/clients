<?php
require '../db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['id'])) {
        $sql = "UPDATE client SET 
                    type_client = :type_client,
                    nom = :nom,
                    prenom = :prenom,
                    raison_sociale = :raison_sociale,
                    telephone = :telephone,
                    email = :email,
                    adresse = :adresse,
                    taux_remise = :taux_remise,
                    etat = :etat,
                    user_modification = 'api_user',
                    date_modification = NOW()
                WHERE id = :id";

        $stmt = $pdo->prepare($sql);

        $stmt->execute([
            ':id' => $data['id'],
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

        echo json_encode(['message' => 'Client updated successfully']);
    } else {
        http_response_code(400);
        echo json_encode(['message' => 'Client ID is missing']);
    }
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Method Not Allowed']);
}
?>