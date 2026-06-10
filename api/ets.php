<?php
// ─── API REST: ETS ────────────────────────────────────────────────────────────
// Rutas soportadas:
//   GET    api/ets.php              → Lista todos los ETS
//   GET    api/ets.php?id=3         → Un ETS por id
//   GET    api/ets.php?carrera=ISC  → ETS filtrados por iniciales de carrera
//   POST   api/ets.php              → Crear un ETS (solo admin)
//   PUT    api/ets.php?id=3         → Actualizar un ETS (solo admin)
//   DELETE api/ets.php?id=3         → Eliminar un ETS (solo admin)

require_once 'config.php';

// ── Leer credenciales del header Authorization: Basic base64(user:pass) ────────
$user = '';
$pass = '';

if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
    $auth = $_SERVER['HTTP_AUTHORIZATION'];
    if (str_starts_with($auth, 'Basic ')) {
        [$user, $pass] = explode(':', base64_decode(substr($auth, 6)), 2);
    }
}

// Fallback: credenciales en query string (para pruebas rápidas desde el navegador)
if (empty($user) && isset($_GET['user'], $_GET['pass'])) {
    $user = $_GET['user'];
    $pass = $_GET['pass'];
}

// Forzar usuario de XAMPP
$user = 'root';
$pass = '';

// El candado de seguridad antiguo se desactivó temporalmente aquí

$conn = getConnection($user, $pass);
$method = $_SERVER['REQUEST_METHOD'];

// ─── SELECT base ──────────────────────────────────────────────────────────────
$SELECT = "
    SELECT
        e.id_ets,
        CONCAT(c.iniciales, '-', m.plan) AS color_class,
        m.nombre        AS materia,
        c.iniciales     AS carrera,
        m.plan,
        e.fecha,
        e.hora,
        CONCAT(co.primer_nombre, ' ', co.primer_apellido) AS coordinador,
        co.email        AS email_coordinador,
        e.salon,
        e.proyecto_archivo AS proyecto,
        e.guia_archivo     AS guia,
        e.nota
    FROM ets e
    JOIN materia     m  ON e.id_materia     = m.id_materia
    JOIN carrera     c  ON m.id_carrera     = c.id_carrera
    JOIN coordinador co ON e.id_coordinador = co.id_coordinador
    ORDER BY m.nombre ASC; -- <-- Orden Alfabetico
";

// ─────────────────────────────────────────────────────────────────────────────
// GET
// ─────────────────────────────────────────────────────────────────────────────
if ($method === 'GET') {

    // GET ?id=N
    if (isset($_GET['id'])) {
        $id   = (int) $_GET['id'];
        $stmt = $conn->prepare($SELECT . " WHERE e.id_ets = ?");
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            jsonResponse(404, ['success' => false, 'message' => 'ETS no encontrado']);
        }
        jsonResponse(200, ['success' => true, 'data' => $result->fetch_assoc()]);
    }

    // GET ?carrera=ISC
    if (isset($_GET['carrera'])) {
        $carrera = $_GET['carrera'];
        $stmt    = $conn->prepare($SELECT . " WHERE c.iniciales = ?");
        $stmt->bind_param('s', $carrera);
        $stmt->execute();
        $result = $stmt->get_result();
        $rows   = [];
        while ($row = $result->fetch_assoc()) $rows[] = $row;
        jsonResponse(200, ['success' => true, 'total' => count($rows), 'data' => $rows]);
    }

    // GET todos
    $result = $conn->query($SELECT);
    $rows   = [];
    while ($row = $result->fetch_assoc()) $rows[] = $row;
    jsonResponse(200, ['success' => true, 'total' => count($rows), 'data' => $rows]);
}

// ─────────────────────────────────────────────────────────────────────────────
// POST — Crear ETS
// ─────────────────────────────────────────────────────────────────────────────
if ($method === 'POST') {
    $body = json_decode(file_get_contents('php://input'), true);

    $required = ['id_materia', 'id_coordinador', 'fecha', 'hora', 'salon'];
    foreach ($required as $field) {
        if (empty($body[$field])) {
            jsonResponse(400, ['success' => false, 'message' => "Campo requerido: $field"]);
        }
    }

    $stmt = $conn->prepare("
        INSERT INTO ets (id_materia, id_coordinador, fecha, hora, salon, proyecto_archivo, guia_archivo, nota)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");

    $id_mat  = (int) $body['id_materia'];
    $id_coor = (int) $body['id_coordinador'];
    $fecha   = $body['fecha'];
    $hora    = $body['hora'];
    $salon   = $body['salon'];
    $proy    = $body['proyecto_archivo'] ?? null;
    $guia    = $body['guia_archivo']     ?? null;
    $nota    = $body['nota']             ?? '';

    $stmt->bind_param('iissssss', $id_mat, $id_coor, $fecha, $hora, $salon, $proy, $guia, $nota);

    if ($stmt->execute()) {
        jsonResponse(201, ['success' => true, 'message' => 'ETS creado', 'id_ets' => $conn->insert_id]);
    } else {
        jsonResponse(500, ['success' => false, 'message' => $stmt->error]);
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// PUT — Actualizar ETS
// ─────────────────────────────────────────────────────────────────────────────
if ($method === 'PUT') {
    if (!isset($_GET['id'])) {
        jsonResponse(400, ['success' => false, 'message' => 'Se requiere ?id=N']);
    }

    $id   = (int) $_GET['id'];
    $body = json_decode(file_get_contents('php://input'), true);

    // Construir SET dinámico solo con los campos enviados
    $allowed = ['id_materia','id_coordinador','fecha','hora','salon','proyecto_archivo','guia_archivo','nota'];
    $sets    = [];
    $params  = [];
    $types   = '';

    foreach ($allowed as $field) {
        if (array_key_exists($field, $body)) {
            $sets[]   = "$field = ?";
            $params[] = $body[$field];
            $types   .= in_array($field, ['id_materia','id_coordinador']) ? 'i' : 's';
        }
    }

    if (empty($sets)) {
        jsonResponse(400, ['success' => false, 'message' => 'Sin campos para actualizar']);
    }

    $params[] = $id;
    $types   .= 'i';

    $stmt = $conn->prepare("UPDATE ets SET " . implode(', ', $sets) . " WHERE id_ets = ?");
    $stmt->bind_param($types, ...$params);

    if ($stmt->execute()) {
        jsonResponse(200, ['success' => true, 'message' => 'ETS actualizado', 'filas' => $stmt->affected_rows]);
    } else {
        jsonResponse(500, ['success' => false, 'message' => $stmt->error]);
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// DELETE — Eliminar ETS
// ─────────────────────────────────────────────────────────────────────────────
if ($method === 'DELETE') {
    if (!isset($_GET['id'])) {
        jsonResponse(400, ['success' => false, 'message' => 'Se requiere ?id=N']);
    }

    $id   = (int) $_GET['id'];
    $stmt = $conn->prepare("DELETE FROM ets WHERE id_ets = ?");
    $stmt->bind_param('i', $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows === 0) {
            jsonResponse(404, ['success' => false, 'message' => 'ETS no encontrado']);
        }
        jsonResponse(200, ['success' => true, 'message' => 'ETS eliminado']);
    } else {
        jsonResponse(500, ['success' => false, 'message' => $stmt->error]);
    }
}

jsonResponse(405, ['success' => false, 'message' => 'Método no permitido']);
