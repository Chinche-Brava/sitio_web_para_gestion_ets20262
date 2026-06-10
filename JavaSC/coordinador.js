$(document).ready(() => {
    const API = "http://localhost/ets20262/api/ets.php"; // <-- YA QUEDÓ FIJA CON LOCALHOST
    let todosLosETS = [];

    cargarETS();

    document.getElementById("filter-all").addEventListener("click", async () => {
        await cargarETS();
    });

    document.getElementById("filtro-texto").addEventListener("input", () => {
        filtrar("");
    });

    document.getElementById("filter-isc").addEventListener("click", () => {
        filtrar("isc");
    });

    document.getElementById("filter-iia").addEventListener("click", async () => {
        filtrar("iia");
    });

    document.getElementById("filter-lcd").addEventListener("click", async () => {
        filtrar("lcd");
    });

    document.getElementById("filter-isisa").addEventListener("click", async () => {
        filtrar("isisa");
    });

    function credHeaders() {
        return { "Content-Type": "application/json" };
    }

    function apiURL(base, params = {}) {
        const u = "root";
        const p = "";
        const q = new URLSearchParams({ user: u, pass: p, ...params });
        return `${base}?${q}`;
    }

    // ── Cargar todos los ETS ──────────────────────────────────────────────────────
    async function cargarETS() {
        console.info("Conectando…");
        try {
            const res = await fetch(apiURL(API), { headers: credHeaders() });

            if (!res.ok) {
                console.error("HTTP Error:", res.status);
                return;
            }

            const json = await res.json();
            if (!json.success) {
                console.error("Error: " + json.message, "error");
                return;
            }

            todosLosETS = json.data;

            console.info(todosLosETS);
            console.info(json.total + " registros");
            renderizarMaterias(todosLosETS);
        } catch (e) {
            console.error("Error de red: " + e.message, "error");
        }
    }

    function filtrar(carrera) {
        const texto = document.getElementById("filtro-texto").value.toLowerCase();

        const filtrados = todosLosETS.filter((e) => {
            const matchCarrera = !carrera || e.carrera.toLowerCase() === carrera;
            const matchTexto =
                !texto ||
                e.materia.toLowerCase().includes(texto) ||
                e.salon.toLowerCase().includes(texto) ||
                e.coordinador.toLowerCase().includes(texto) ||
                (e.nota && e.nota.toLowerCase().includes(texto)); // Prevenir fallos si nota viene null
            return matchCarrera && matchTexto;
        });

        renderizarMaterias(filtrados);
    }
});

function obtenerIconoPorCarrera(carrera, plan) {
    const id = carrera.toLowerCase();
    const p = plan.toString();

    if (id === "isc" && p === "2009") return "fa-solid fa-laptop-code";
    if (id === "isc" && p === "2020") return "fa-solid fa-code";
    if (id === "iia") return "fa-solid fa-network-wired";
    if (id === "lcd") return "fa-solid fa-terminal";
    if (id === "isisa") return "fa-solid fa-microchip";

    return "fa-solid fa-book";
}

/**
 * Función para generar el HTML dinámico con recuadros modificables y colores de SASS correctos
 */
function renderizarMaterias(lista) {
    const contenedor = $("#contenedor-materias");

    // Limpiamos el spinner de "Cargando..."
    contenedor.empty();

    lista.forEach((materia) => {
        const iconoCarrera = obtenerIconoPorCarrera(materia.carrera, materia.plan);
        const idUnico = `${materia.carrera}-${materia.plan}-${materia.id_ets}`.toLowerCase();

        // SOLUCIÓN: Generamos la clase exacta que espera tu SASS (ej: "isc-2020", "iia-2020")
        const claseColorSass = `${materia.carrera.toLowerCase()}-${materia.plan}`;

        const html = `
            <!-- Agregamos la clase compuesta al article junto con subject-item -->
            <article class="subject-item ${claseColorSass}" id="${idUnico}" style="margin-bottom: 1rem; border-radius: 8px; overflow: hidden;">
                
                <!-- Encabezado del Acordeón (Quitamos los fondos fijos para que mande tu CSS/SASS) -->
                <div class="subject-row d-flex align-items-center p-3" onclick="toggleInfo('${idUnico}')" style="cursor:pointer;">
                    <div class="subject-icon me-3">
                        <i class="${iconoCarrera}"></i>
                    </div>
                    <!-- Quitamos 'text-dark' para que tome el #ffffff o #111111 de tu SASS -->
                    <span class="subject-name fw-bold">${materia.materia}</span>
                    <!-- Quitamos 'bg-secondary' para que use el background-color de tu .subject-tag -->
                    <span class="subject-tag ms-2 badge">${materia.carrera.toUpperCase()} - ${materia.plan}</span>
                    <i class="fa-solid fa-chevron-down arrow-icon ms-auto transition-transform"></i>
                </div>
                
                <!-- Panel Desplegable: Forzamos fondo blanco e inputs legibles para el coordinador -->
                <div class="subject-info-panel" id="info-${idUnico}" style="display: none; background: #ffffff; border-top: 1px solid #e2e8f0; color: #212529 !important;">
                    <form action="api/actualizar_materia.php" method="POST" enctype="multipart/form-data" class="p-4 row g-3">
                        
                        <!-- ID oculto para enviar al backend -->
                        <input type="hidden" name="id_ets" value="${materia.id_ets}">

                        <!-- Campo: Modificar Nombre de Materia -->
                        <div class="col-md-8">
                            <label class="form-label small fw-bold text-muted text-uppercase">Nombre de la Materia</label>
                            <input type="text" name="materia" class="form-control" value="${materia.materia}" required>
                        </div>

                        <!-- Campo: Modificar Salón -->
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted text-uppercase">Salón / Lab</label>
                            <input type="text" name="salon" class="form-control" value="${materia.salon}">
                        </div>

                        <!-- Campo: Modificar Fecha -->
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted text-uppercase">Fecha</label>
                            <input type="date" name="fecha" class="form-control" value="${materia.fecha}">
                        </div>

                        <!-- Campo: Modificar Horario -->
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted text-uppercase">Horario</label>
                            <input type="text" name="hora" class="form-control" value="${materia.hora}" placeholder="Ej. 10:00 - 12:00">
                        </div>

                        <!-- Campo: Modificar Coordinador -->
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted text-uppercase">Coordinador</label>
                            <input type="text" name="coordinador" class="form-control" value="${materia.coordinador}">
                        </div>

                        <!-- Campo: Subir Documento Adjunto -->
                        <div class="col-12 my-3">
                            <label class="form-label small fw-bold text-primary text-uppercase">
                                <i class="fa-solid fa-cloud-arrow-up me-1"></i> Subir Guía de Estudio / Temario (PDF)
                            </label>
                            <div class="input-group">
                                <input type="file" name="guia_archivo" class="form-control" accept=".pdf">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-file-pdf text-danger"></i></span>
                            </div>
                            <div class="form-text small text-muted">
                                Elige un archivo para actualizar el documento de esta materia.
                            </div>
                        </div>

                        <hr class="text-muted my-2">

                        <!-- Botón Único: Guardar Cambios -->
                        <div class="col-12 d-flex justify-content-end">
                            <button type="submit" class="btn btn-primary px-4 fw-bold shadow-sm d-flex align-items-center gap-2" style="background-color: #393d7e !important; border: none; color: #ffffff !important;">
                                <i class="fa-solid fa-floppy-disk"></i> Guardar Cambios
                            </button>
                        </div>
                    </form>
                </div>
            </article>`;

        contenedor.append(html);
    });
}

/**
 * Función para el efecto de acordeón (abrir/cerrar)
 */
function toggleInfo(id) {
    const panel = $(`#info-${id}`);
    const icono = $(`#${id} .arrow-icon`);

    panel.slideToggle(300);
    icono.toggleClass("rotate-icon");
}
