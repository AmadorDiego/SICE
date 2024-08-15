<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Examenes Realizados</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/bootstrap.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/fondo.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/adicionalesEBM.css'>
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
</head>
<body>
<!--/////////////////////////////////// Fondo //////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>

            <div class="d-flex">
                <a href="indexAlumno.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">Home</span>
                </a>
                <a href="alumnoRelizados.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">task</span>
                </a>
            </div>
        </div>
    </nav>
</header>


<!--////////////////////////// Encabezado ////////////////////////////////////-->
<div class="container-fluid">
    <div class="row align-items-center">
        <div class="col-6 p-4">
            <h1 class="text-white">¡Bienvenido Alumno!</h1>
            <h2 class="gray-SICE">Examenes Relizados:</h2>
        </div>
    </div>


    <hr style="color: white">


    <!--////////////////////////////// Filtros ////////////////////////////-->

    <div class="row">
        <div class="col-12 col-md-1 me-5 ms-4 d-flex d-inline">
            <h3 class="green-SICE-obscuro">Filtros:</h3>
        </div>
        <div class="col-10 col-md-3 me-2 py-1 d-flex d-inline">
            <select class="form-select me-2 ms-2 bg-green-SICE green-SICE-obscuro border-0"
                    aria-label="Default select example">
                <option selected>Docente</option>
                <option value="1">Celin</option>
                <option value="2">Evelyn</option>
                <option value="3">Mauro</option>
            </select>
        </div>

        <div class="col-10 col-md-3 me-2 py-1 d-flex d-inline">
            <select class="form-select me-2 ms-2 bg-green-SICE green-SICE-obscuro border-0"
                    aria-label="Default select example">
                <option selected>Calificacion</option>
                <option value="1">Pendiente</option>
                <option value="2">Calificado</option>
            </select>
        </div>
    </div>


    <!--////////////////////////////// Contenido principal(Tabla) ////////////////////////////-->
    <div class="row position-relative">
        <div class="col-12 p-5">
            <div class="rounded-4 table-responsive d-flex">
                <table class="table table-striped rounded-5" style="table-layout: fixed">
                    <thead>
                    <tr class="bg-green-SICE-obscuro text-white">
                        <th scope="col" style="width: 35px">#</th>
                        <th scope="col">Nombre</th>
                        <th scope="col" style="width: 60px">Grado</th>
                        <th scope="col" class="d-none d-md-table-cell">Fecha de relizacion</th>
                        <th scope="col" class="d-none d-md-table-cell">Docente</th>
                        <th scope="col" class="d-none d-md-table-cell">Calificacion</th>
                        <th scope="col">Ver Examen</th>

                    </tr>
                    </thead>

                    <tbody class="bg-green-SICE">
                    <tr>
                        <th scope="row">1</th>
                        <td><h6>Examen Probabilidad U2</h6></td>
                        <td><h6>3</h6></td>
                        <td class="d-none d-md-table-cell"><h6>03/08/2024/10:19AM</h6></td>
                        <td class="d-none d-md-table-cell"><h6>Celin</h6></td>
                        <td class="d-none d-md-table-cell"><h6>15/40</h6></td>
                        <td>
                            <a class=" btn bg-blue-utz btn-brillo-efecto"><h6 class="text-white mb-0">Ver</h6></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">2</th>
                        <td><h6>Examen Probabilidad U2</h6></td>
                        <td><h6>3</h6></td>
                        <td class="d-none d-md-table-cell"><h6>03/08/2024/10:19AM</h6></td>
                        <td class="d-none d-md-table-cell"><h6>Celin</h6></td>
                        <td class="d-none d-md-table-cell"><h6>Pendiente</h6></td>
                        <td><h6>No disponible</h6></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
</body>
</html>
