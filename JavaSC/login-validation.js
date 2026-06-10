// ==========================================
// 2. JUSTVALIDATE — Validación del formulario Coordinador
// ==========================================
const validation = new JustValidate("#loginFormCoord", {
    errorFieldCssClass: "is-invalid", // Dejamos las clases nativas en el input
    successFieldCssClass: "is-valid",
    lockForm: true,
    errorLabelStyle: {},
    errorLabelCssClass: ["text-danger", "small", "mt-1", "d-block"],
});

validation
    .addField(
        "#boleta_coord",
        [
            { rule: "required", errorMessage: "La boleta es obligatoria." },
            { rule: "number", errorMessage: "Solo se permiten números." },
            { rule: "minLength", value: 10, errorMessage: "Deben ser exactamente 10 dígitos." },
            { rule: "maxLength", value: 10, errorMessage: "Deben ser exactamente 10 dígitos." },
        ],
        {
            // Obliga a que el texto del error se inyecte ABAJO del input-group completo
            errorsContainer: document.querySelector("#boleta_coord").closest(".mb-3"),
        },
    )
    .addField(
        "#password_coord",
        [
            { rule: "required", errorMessage: "La contraseña es obligatoria." },
            { rule: "minLength", value: 6, errorMessage: "Mínimo 6 caracteres." },
        ],
        {
            // Obliga a que el texto del error se inyecte ABAJO del input-group completo
            errorsContainer: document.querySelector("#password_coord").closest(".mb-4"),
        },
    )
    .onSuccess((event) => {
        event.target.submit();
    });
