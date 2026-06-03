<?php
// ─── Configuración de la base de datos ───────────────────────────────────────
define('DB_HOST', '127.0.0.1');
define('DB_PORT', 3307);
define('DB_NAME', 'ETS20262');

// Headers CORS y tipo de contenido JSON
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

// Preflight OPTIONS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

/**
 * Crea y devuelve una conexión MySQLi usando las credenciales dadas.
 * Lanza un JSON de error y termina si la conexión falla.
 */
function getConnection(string $user, string $pass): mysqli {
    $conn = new mysqli(DB_HOST . ':' . DB_PORT, $user, $pass, DB_NAME);

    if ($conn->connect_error) {
        http_response_code(401);
        echo json_encode([
            'success' => false,
            'message' => 'Conexión fallida: ' . $conn->connect_error
        ]);
        exit();
    }

    $conn->set_charset('utf8mb4');
    return $conn;
}

/**
 * Devuelve una respuesta JSON y termina la ejecución.
 */
function jsonResponse(int $code, array $data): void {
    http_response_code($code);
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    exit();
}
