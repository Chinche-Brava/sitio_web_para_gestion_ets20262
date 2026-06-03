$(document).ready(() => {
    const API = '../php/ets.php';

    let todosLosETS = [];
    // 1. Crear un arreglo vacío para juntar todas las materias
    cargarETS();

    document.getElementById('filter-all').addEventListener('click', async () => {
        await cargarETS();
    })

    document.getElementById('filtro-texto').addEventListener('input', () => {
        filtrar('');
    })

    document.getElementById('filter-isc').addEventListener('click', () => {
        filtrar('isc');
    })

    document.getElementById('filter-iia').addEventListener('click', async () => {
        filtrar('iia');
    })

    document.getElementById('filter-lcd').addEventListener('click', async () => {
        filtrar('lcd');
    })

    document.getElementById('filter-isisa').addEventListener('click', async () => {
        filtrar('isisa');
    })


    function credHeaders() {
        return { 'Content-Type': 'application/json' };
    }
    
    function apiURL(base, params = {}) {
        //const u = document.getElementById('inp-user').value;
        //const p = document.getElementById('inp-pass').value;
        const u = 'alumno';
        const p = 'alumno';
        const q = new URLSearchParams({ user: u, pass: p, ...params });
        
        return `${base}?${q}`;
    }
    
    // ── Cargar todos los ETS ──────────────────────────────────────────────────────
    async function cargarETS() {
        console.info('Conectando…');
        try {
            const res = await fetch(apiURL(API), { headers: credHeaders() });

            if (!res.ok) {
                // ya sabes que falló sin leer el body
                console.error('HTTP Error:', res.status);
                return;
            }

            const json = await res.json(); // solo lees si todo está bien
            if (!json.success) { 
                console.error('Error: ' + json.message, 'error'); 
                return; 
            }
            
            todosLosETS = json.data;

            console.info(todosLosETS);
            console.info(json.total  + ' registros');
            renderizarMaterias(todosLosETS);
            //filtrar();
            //document.getElementById('ts').textContent = 'Última carga: ' + new Date().toLocaleTimeString('es-MX');
        } catch (e) {
            console.error('Error de red: ' + e.message, 'error');
        }
    }

    function filtrar(carrera) {
        const texto   = document.getElementById('filtro-texto').value.toLowerCase();

        const filtrados = todosLosETS.filter(e => {
            const matchCarrera = !carrera || e.carrera.toLowerCase() === carrera;
            const matchTexto   = !texto   ||
            e.materia.toLowerCase().includes(texto) ||
            e.salon.toLowerCase().includes(texto)   ||
            e.coordinador.toLowerCase().includes(texto) ||
            e.nota.toLowerCase().includes(texto);
            return matchCarrera && matchTexto;
        });

        renderizarMaterias(filtrados);
    }
});







function obtenerIconoPorCarrera(carrera, plan) {
    const id = carrera.toLowerCase();
    const p = plan.toString();

    // Mapeo exacto según tu lista
    if (id === "isc" && p === "2009") return "fa-solid fa-laptop-code";
    if (id === "isc" && p === "2020") return "fa-solid fa-code";
    if (id === "iia") return "fa-solid fa-network-wired";
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
        const iconoCarrera = obtenerIconoPorCarrera(materia.carrera, materia.plan);
        // Generamos un ID único combinando carrera, plan y clave
        const idUnico = `${materia.carrera}-${materia.plan}-${materia.id_ets}`.toLowerCase();

        const html = `
            <article class="subject-item ${materia.color_class.toLowerCase()}" id="${idUnico}">
                <div class="subject-row" onclick="toggleInfo('${idUnico}')" style="cursor:pointer;">
                    <div class="subject-icon">
                        <i class="${iconoCarrera}"></i>
                    </div>
                    <span class="subject-name">${materia.materia}</span>
                    <span class="subject-tag ms-2">${materia.carrera.toUpperCase()} - ${materia.plan}</span>
                    <i class="fa-solid fa-chevron-down arrow-icon ms-auto"></i>
                </div>
                
                <div class="subject-info-panel" id="info-${idUnico}" style="display: none; background: #fff;">
                    <div class="info-grid p-3">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Fecha:</strong> ${materia.fecha}</p>
                                <p><strong>Horario:</strong> ${materia.hora}</p>
                                <p><strong>Salón/Lab:</strong> ${materia.salon}</p>
                            </div>
                            <div class="col-md-6 text-end">
                                <p><strong>Coordinador:</strong> ${materia.coordinador}</p>
                                <p><strong>Proyecto:</strong> ${materia.proyecto}</p>
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
