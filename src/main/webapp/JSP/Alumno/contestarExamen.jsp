<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>*nombre examen*</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
</head>

<body>
<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>

            <div class="d-flex">
                <a href="indexAlumno.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">home</span>
                </a>
                <a href="alumnoRelizados.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">task</span>
                </a>
            </div>
        </div>
    </nav>
</header>


<!--/////////////////////////////////// Fondo //////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--////////////////////////// Encabezado ////////////////////////////////////-->
<div class="container-fluid">
    <div class="row align-items-center mt-4">
        <div class="col bg-green-SICE rounded-4 mx-5">
            <h1 class="text-white">*Nombre Examen*</h1>
        </div>
    </div>



<!--///////////////////////////// Contenido ///////////////////////////////////-->
    <div class="row align-items-center mt-3">
        <div class="col bg-green-SICE rounded-4 mx-5 p-3">
            <div class="card rounded-3">
                <div class="card-header bg-green-SICE">
                    <br>
                </div>
                <div class="card-body bg-green-SICE p-2">
                    <h6 class="card-title">Special title treatment</h6>
                    <div class="custom-radio mb-2">
                        <input type="radio" id="customRadio" name="customRadio" class="custom-radio-input">
                        <label for="customRadio" class="custom-radio-label">
                            <h6>*Respuesta 1*</h6>
                        </label>
                    </div>
                    <div class="custom-radio">
                        <input type="radio" id="customRadio2" name="customRadio" class="custom-radio-input">
                        <label for="customRadio2" class="custom-radio-label">
                            <h6>*Respuesta 2</h6>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>





</div>
<script href="../../JS/bootstrap.js"></script>
</body>
</html>
