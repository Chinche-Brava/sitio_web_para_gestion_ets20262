function switchTab(role) {
    const panels = { alumno: "panel-alumno", coordinador: "panel-coordinador" };
    const tabs = { alumno: "tab-alumno", coordinador: "tab-coordinador" };

    Object.keys(panels).forEach((r) => {
        document.getElementById(panels[r]).style.display = r === role ? "block" : "none";
        const btn = document.getElementById(tabs[r]);
        if (r === role) {
            btn.style.backgroundColor = "#393d7e";
            btn.style.color = "#fff";
        } else {
            btn.style.backgroundColor = "transparent";
            btn.style.color = "#393d7e";
        }
    });
}
