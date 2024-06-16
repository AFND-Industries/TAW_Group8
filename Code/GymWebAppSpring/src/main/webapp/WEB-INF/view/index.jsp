<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
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



<%--    <div class="row row-cols-2 row-cols-md-3 g-4">--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Transforma tu vida con cada entrenamiento</h5>--%>
<%--                    <p class="card-text">Imagina un lugar donde cada gota de sudor, cada repetición y cada paso te lleva--%>
<%--                        más cerca de tu mejor versión. En nuestro gimnasio virtual, no estás solo; estás rodeado de--%>
<%--                        personas con la misma determinación y ganas de superarse. Ofrecemos una amplia variedad de--%>
<%--                        rutinas de ejercicios diseñadas por expertos en fitness que se adaptan a todos los niveles de--%>
<%--                        habilidad y objetivos, desde perder peso hasta ganar masa muscular y mejorar tu resistencia.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Entrena a tu manera, en tu propio tiempo</h5>--%>
<%--                    <p class="card-text">Entendemos que la vida puede ser agitada y que encontrar tiempo para ir al--%>
<%--                        gimnasio puede ser un desafío. Por eso, nuestro gimnasio online está disponible las 24 horas del--%>
<%--                        día, los 7 días de la semana. Puedes acceder a nuestras sesiones de entrenamiento desde la--%>
<%--                        comodidad de tu hogar, en el parque, o donde quiera que estés. Ya sea que prefieras entrenar--%>
<%--                        temprano en la mañana, durante tu descanso del almuerzo o tarde en la noche, nuestro contenido--%>
<%--                        está siempre disponible para ti.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Educación y motivación en cada clic</h5>--%>
<%--                    <p class="card-text">Además de las sesiones de entrenamiento, nuestro gimnasio virtual ofrece una--%>
<%--                        rica biblioteca de recursos educativos. Aprende sobre nutrición, técnicas de entrenamiento y--%>
<%--                        cómo mantener una mentalidad positiva. Nuestros entrenadores certificados comparten sus--%>
<%--                        conocimientos a través de blogs, videos y webinars, brindándote las herramientas necesarias para--%>
<%--                        tomar decisiones informadas sobre tu salud y bienestar.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Una comunidad que te apoya</h5>--%>
<%--                    <p class="card-text">En nuestro gimnasio online, no solo entrenas; también formas parte de una--%>
<%--                        comunidad vibrante y solidaria. Conéctate con otros miembros a través de nuestros foros y grupos--%>
<%--                        de discusión. Comparte tus progresos, celebra tus logros y encuentra inspiración en las--%>
<%--                        historias de éxito de otros. Juntos, celebramos cada pequeño paso hacia una vida más activa y--%>
<%--                        saludable.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Programas personalizados para tus necesidades</h5>--%>
<%--                    <p class="card-text">Sabemos que cada persona es única, con necesidades y objetivos diferentes. Por--%>
<%--                        eso, ofrecemos programas de entrenamiento personalizados. Trabaja con nuestros entrenadores para--%>
<%--                        crear un plan que se adapte a tus metas específicas. Ya sea que estés empezando tu viaje de--%>
<%--                        fitness o buscando llevar tu entrenamiento al siguiente nivel, estamos aquí para ayudarte a--%>
<%--                        diseñar un plan que funcione para ti.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Herramientas tecnológicas para optimizar tu entrenamiento</h5>--%>
<%--                    <p class="card-text">Nuestra plataforma aprovecha la tecnología para brindarte la mejor experiencia--%>
<%--                        posible. Usa nuestras herramientas de seguimiento para monitorizar tu progreso, ajusta tus--%>
<%--                        rutinas basándote en tus avances y recibe feedback instantáneo sobre tu rendimiento. Con--%>
<%--                        nuestras aplicaciones móviles, puedes llevar tu gimnasio contigo a donde vayas, asegurándote de--%>
<%--                        que nunca pierdas una sesión de entrenamiento.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Inspírate y alcanza nuevas alturas</h5>--%>
<%--                    <p class="card-text">Nuestro objetivo es inspirarte a ser la mejor versión de ti mismo. Creemos en--%>
<%--                        el poder de la disciplina, la constancia y el esfuerzo diario. Cada entrenamiento es una--%>
<%--                        oportunidad para desafiar tus límites y descubrir de lo que eres capaz. No importa dónde--%>
<%--                        comiences, lo importante es dar el primer paso y continuar avanzando.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <div class="card h-100">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title">Bienvenido a tu gimnasio online</h5>--%>
<%--                    <p class="card-text">En nuestro gimnasio virtual, te proporcionamos el entorno, las herramientas y--%>
<%--                        el apoyo necesarios para que transformes tu vida. No solo es un lugar para hacer ejercicio, sino--%>
<%--                        un espacio donde se forjan hábitos saludables, se construyen cuerpos fuertes y se cultivan--%>
<%--                        mentes resilientes. Te invitamos a unirte a nuestra comunidad y comenzar tu viaje hacia una vida--%>
<%--                        más activa, saludable y plena. ¡Vamos juntos hacia el éxito, un entrenamiento a la vez!</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

    ¡Vamos juntos hacia el éxito, un entrenamiento a la vez! ¡Bienvenido a tu gimnasio online, donde cada día es una
    oportunidad para ser mejor que ayer!
</div>

<!-- Bootstrap Javascript Dependencies -->

</body>
<jsp:include page="components/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</html>
