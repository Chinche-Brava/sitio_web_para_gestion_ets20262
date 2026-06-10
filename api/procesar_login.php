<?php
// 1. Iniciar la sesión para guardar los datos del alumno si el login es exitoso
session_start();

// 2. Conexión a la base de datos usando PDO
$host = 'localhost';
$dbname = 'ets20262'; // Cambia el nombre si tu base de datos se llama distinto
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    // Si la base de datos falla, puedes imprimir el error o redirigir
    die("Error de conexión: " . $e->getMessage());
}

// 3. Validar que los datos del formulario hayan llegado mediante POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Recolectar y limpiar los datos que vienen del HTML (los nombres corresponden al atributo 'name')
    $boleta = isset($_POST['boleta']) ? trim($_POST['boleta']) : '';
    $pass = isset($_POST['password']) ? trim($_POST['password']) : '';

    // Si por alguna razón llegan vacíos, regresamos al login con error
    if (empty($boleta) || empty($pass)) {
        header("Location: index.html?error=1");
        exit();
    }

    try {
        // 4. Preparar la consulta SQL apuntando a tus atributos id_alumno y contrasena
        // NOTA: Si guardas las contraseñas en texto plano usa esta consulta. 
        // (Si usas contraseñas encriptadas con password_hash, avísame para ajustarlo con password_verify)
        $stmt = $pdo->prepare("SELECT * FROM alumno WHERE id_alumno = :boleta AND contrasena = :pass LIMIT 1");
        
        // Ejecutar pasando los parámetros limpios
        $stmt->execute([
            'boleta' => $boleta,
            'pass'   => $pass
        ]);
        
        // Recuperar el registro
        $alumno = $stmt->fetch(PDO::FETCH_ASSOC);

        // 5. Verificar el resultado de la consulta
        if ($alumno) {
            // ¡Credenciales correctas! Guardamos los datos en la sesión
            $_SESSION['alumno_id'] = $alumno['id_alumno'];
            
            // Si tu tabla tiene un atributo para el nombre (ej. nombre_alumno), lo guardamos también
            if (isset($alumno['nombre'])) {
                $_SESSION['alumno_nombre'] = $alumno['nombre'];
            }

            // Redireccionamos a la página principal del sistema
            header("Location: HTML/principal.html");
            exit();

        } else {
            // Credenciales incorrectas: Redirecciona al login mandando el parámetro ?error=1
            // para que se active tu SweetAlert automáticamente
            header("Location: index.html?error=1");
            exit();
        }

    } catch (PDOException $e) {
        // Manejo de errores en la consulta SQL
        header("Location: index.html?error=1");
        exit();
    }
} else {
    // Si alguien intenta entrar a este archivo escribiendo la URL directamente, lo mandamos al login
    header("Location: index.html");
    exit();
}