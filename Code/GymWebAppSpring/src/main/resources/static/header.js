function createHeader(pagina) {
    document.getElementById("header").innerHTML = `
        <nav class="navbar navbar-expand-lg bg-body-tertiary mb-3">
            <div class="container-fluid">
                <a class="navbar-brand" href="/entrenador">TAW PROJECT</a>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link` + (pagina === "clientes" ? " active" : "") + `" aria-current="page" href="/entrenador/clientes">Clientes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link` + (pagina === "rutinas" ? " active" : "") + `" href="/entrenador/rutinas">Rutinas</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    `;
}


console.log("Header loaded");