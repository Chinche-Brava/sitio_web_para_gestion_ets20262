document.addEventListener("DOMContentLoaded", () => {
    const list = document.querySelector(".subject-list");
    if (!list) return; // Seguridad por si no existe la lista

    const items = Array.from(list.getElementsByClassName("subject-item"));

    // 1. ORDENAR ALFABÉTICAMENTE
    items.sort((a, b) => {
        const nameA = a.querySelector(".subject-name").innerText.trim().toUpperCase();
        const nameB = b.querySelector(".subject-name").innerText.trim().toUpperCase();
        return nameA.localeCompare(nameB);
    });

    // 2. RE-INSERTAR Y ASIGNAR EVENTO DE CLIC
    items.forEach((item) => {
        list.appendChild(item); // Lo mueve a su nueva posición

        const row = item.querySelector(".subject-row");
        const panel = item.querySelector(".subject-info-panel");
        const arrow = item.querySelector(".arrow-icon");

        row.addEventListener("click", () => {
            // Alternamos entre block y none
            const isVisible = panel.style.display === "block";

            if (isVisible) {
                panel.style.display = "none";
                arrow.style.transform = "rotate(0deg)";
            } else {
                panel.style.display = "block";
                arrow.style.transform = "rotate(180deg)";
            }
        });
    });
});
