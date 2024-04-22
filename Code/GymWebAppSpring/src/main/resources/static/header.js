function generateHTML() {
    return `
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="/">TAW_Project</a>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/entrenador/clientes">Clientes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/entrenador/rutinas">Rutinas</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    `;
}

document.getElementById("header").innerHTML = generateHTML();
console.log("Header loaded");