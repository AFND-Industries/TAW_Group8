<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Welcome!</title>
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap"
          rel="stylesheet">
</head>
<style>
    /* Custom CSS */
    .lato-regular {
        font-family: "Lato", sans-serif;
        font-weight: 400;
        font-style: normal;
    }

    .vt323 {
        font-family: 'VT323', sans-serif;
    }

    .blurry-background {

        background: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(0, 0, 0, 1)),
        url('https://t3.ftcdn.net/jpg/04/31/55/92/360_F_431559277_rkkDdPgYlypnPwf4EoDIlvkVDiWNBBft.jpg');
        background-size: cover;
        background-blend-mode: multiply;
        z-index: 1;
    }

    .custom-h1 {
        font-size: 6rem; /* Tamaño de fuente personalizado */
        font-weight: bold; /* Opcional: hacer el texto en negrita */
        font-family: 'VT323', sans-serif; /* Opcional: cambiar la fuente */
        margin-inline: 300px;
        background: #3C1518;
        color: #EDF0DA;
    }

    h2, h3, h4, h5, h6 {
        .lato-regular
    }


</style>
<jsp:include page="components/header.jsp"/>
<body>
<div class="container-fluid p-0">
    <div class="row blurry-background align-items-center justify-content-center vh-100 mb-5">

        <div class="text-center text-white py-5" style="z-index: 100">
            <h1 class="custom-h1 fw-bolder mb-4">¡SIN DOLOR NO HAY GLORIA!</h1>
            <h2 class="mb-4" style="font-family: 'Arial', sans-serif;">Dale el gameOver a la flojera y comienza
                con nuestro gimnasio virtual.</h2>
            <button type="button" class="btn btn-outline-light btn-lg">¡Empieza ahora!</button>
        </div>

    </div>

    <h3 class="vt323 text-center mb-5">
        ¡Vamos juntos hacia el éxito, un entrenamiento a la vez! ¡Bienvenido a tu gimnasio online, donde cada día es una
        oportunidad para ser mejor que ayer!
    </h3>
</div>

<!-- Bootstrap Javascript Dependencies -->

</body>
<jsp:include page="components/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</html>
