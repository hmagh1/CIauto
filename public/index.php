<?php
require_once __DIR__ . '/../vendor/autoload.php';

use App\Database;
use App\User;

$db = (new Database())->getConnection();
$user = new User($db);

// Route and simulate basic CRUD for demo
$action = $_GET['action'] ?? '';
header('Content-Type: application/json');

switch ($action) {
    case 'create':
        echo json_encode($user->create("Moad", "moad@example.com"));
        break;
    case 'read':
        echo json_encode($user->read());
        break;
    case 'update':
        echo json_encode($user->update(1, "Updated", "updated@example.com"));
        break;
    case 'delete':
        echo json_encode($user->delete(1));
        break;
    default:
        echo json_encode(["message" => "No action specified"]);
}
