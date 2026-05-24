$(document).ready(function () {
    // 1. Crear un arreglo vacío para juntar todas las materias
    let todasLasMaterias = [];

    // 2. Recorrer el objeto global DATA_ESCOM (viniendo de datosMaterias.js)
    // Usamos bucles para entrar a: Carrera -> Plan -> Semestre
    for (let codCarrera in DATA_ESCOM.carreras) {
        const carrera = DATA_ESCOM.carreras[codCarrera];

        for (let numPlan in carrera.planes) {
            const plan = carrera.planes[numPlan];

            for (let numSemestre in plan.semestres) {
                // Mapeamos cada materia para que guarde su propia info de carrera y plan
                plan.semestres[numSemestre].forEach((materia) => {
                    todasLasMaterias.push({
                        ...materia,
                        carrera_id: codCarrera,
                        plan_id: numPlan,
                        color_class: plan.color_class,
                        semestre: numSemestre,
                    });
                });
            }
        }
    }

    // 3. ORDENAR ALFABÉTICAMENTE por el nombre de la materia
    todasLasMaterias.sort((a, b) => a.nombre.localeCompare(b.nombre));

    // 4. Llamar a la función para pintar las materias en el HTML
    renderizarMaterias(todasLasMaterias);
});

function obtenerIconoPorCarrera(carrera, plan) {
    const id = carrera.toLowerCase();
    const p = plan.toString();

    // Mapeo exacto según tu lista
    if (id === "isc" && p === "2009") return "fa-solid fa-laptop-code";
    if (id === "isc" && p === "2020") return "fa-solid fa-code";
    if (id === "ia") return "fa-solid fa-network-wired";
    if (id === "lcd") return "fa-solid fa-terminal";
    if (id === "isisa") return "fa-solid fa-microchip";

    // Icono de respaldo por si acaso
    return "fa-solid fa-book";
}

/**
 * Función para generar el HTML dinámico de cada materia
 */
function renderizarMaterias(lista) {
    const contenedor = $("#contenedor-materias");

    // Limpiamos el spinner de "Cargando..."
    contenedor.empty();

    lista.forEach((materia) => {
        // 1. Obtener el icono dinámico según la carrera y plan
        // Esta función debe estar definida arriba de este ciclo
        const iconoCarrera = obtenerIconoPorCarrera(materia.carrera_id, materia.plan_id);
        // Generamos un ID único combinando carrera, plan y clave
        const idUnico = `${materia.carrera_id}-${materia.plan_id}-${materia.clave}`.toLowerCase();

        const html = `
            <article class="subject-item ${materia.color_class}" id="${idUnico}">
                <div class="subject-row" onclick="toggleInfo('${idUnico}')" style="cursor:pointer;">
                    <div class="subject-icon">
                        <i class="${iconoCarrera}"></i>
                    </div>
                    <span class="subject-name">${materia.nombre}</span>
                    <span class="subject-tag ms-2">${materia.carrera_id.toUpperCase()} - ${materia.plan_id}</span>
                    <i class="fa-solid fa-chevron-down arrow-icon ms-auto"></i>
                </div>
                
                <div class="subject-info-panel" id="info-${idUnico}" style="display: none; background: #fff;">
                    <div class="info-grid p-3">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Fecha:</strong> ${materia.info.fecha}</p>
                                <p><strong>Horario:</strong> ${materia.info.horario}</p>
                                <p><strong>Salón/Lab:</strong> ${materia.info.salon}</p>
                            </div>
                            <div class="col-md-6 text-end">
                                <p><strong>Coordinador:</strong> ${materia.info.coordinador}</p>
                                <p><strong>Proyecto:</strong> ${materia.info.proyecto}</p>
                                <button class="btn btn-outline-danger btn-sm mt-2">
                                    <i class="fa-solid fa-file-pdf"></i> Descargar Guía
                                </button>
                            </div>
                        </div>
                        <div class="mt-3 text-center border-top pt-2">
                            <button class="btn btn-primary w-100">
                                <i class="fa-solid fa-file-signature"></i> Descargar Comprobante
                            </button>
                        </div>
                    </div>
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

    // Cerramos los demás paneles si quieres efecto acordeón puro (opcional)
    // $(".subject-info-panel").not(panel).slideUp();

    panel.slideToggle(300);

    // Rotamos la flechita para que se vea pro
    icono.toggleClass("rotate-icon");
}
