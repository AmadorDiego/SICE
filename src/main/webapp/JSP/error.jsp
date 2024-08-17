<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 08/08/2024
  Time: 10:45 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error 404</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            height: 100vh;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
            font-family: "vazir", sans-serif;
            background: var(--P_color6);
            color: rgba(255, 255, 255, 0.8);
            overflow: hidden !important;
        }

        a {
            text-decoration: none;
        }

        .texts {
            z-index: 5;
            padding: .8rem;
            margin: .3rem;
            width: 500px;
        }

        .texts h4 {
            font-size: 1.5rem;
        }

        .Square404 {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 50%;
        }

        .Square {
            width: 20vw;
            height: 20vw;
            position: absolute;
            border-radius: 1.2rem;
            background: var(--P_color1);
            box-shadow: var(--P_color2) 0 0 5px 30px,
            var(--P_color3) 0 0 10px 60px,
            var(--P_color4) 0 0 15px 90px,
            var(--P_color5) 0 0 20px 120px,
            var(--P_color6) 0 0 25px 150px;
            transform: rotateZ(-21deg);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1;
        }

        .Square h1 {
            font-size: 10vw;
            color: var(--P_color6);
            transform: translateZ(90px);
            text-shadow: 0 0 2px rgba(0, 0, 0, .6);
            user-select: none;
        }

        .btn:hover {
            color: #212529;
            background-color: #009475;
            border-color: #009475;
        }

        .btn {
            cursor: pointer;
            display: inline-block;
            font-weight: 400;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            border: #f8f9fa 1px solid;
            padding: .375rem .75rem;
            margin: .375rem;
            font-size: 1rem;
            border-radius: .25rem;
            color: #f8f9fa;
            transition: all .5s ease-in-out;
            user-select: none;
        }

        #search_box {
            width: 60%;
            border-radius: 10px;
            box-shadow: none;
            padding: .7rem .8rem;
            margin: 10px 0;
            background-color: rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.5);
            color: rgba(255, 255, 255, 0.5);
        }

        :root {
            --P_color1: #009475;
            --P_color2: #009475;
            --P_color3: #0e3a4d;
            --P_color4: #0c2e3b;
            --P_color5: #0c2e3d;
            --P_color6: #0d1737;
        }

        @media (max-width: 768px) {
            body {
                flex-direction: column;
                justify-content: space-evenly;
            }
            .Square404{
                width: 100%;
            }
            .Square{
                width: 150px;
                height: 150px;
            }
            .Square h1{
                font-size: 70px;
            }
            .texts {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<!--Square-->
<div class="Square404" id="Square">
    <div class="Square">
        <!--404 inside the square-->
        <h1>404</h1>
    </div>
</div>

<!--Texts-->
<div class="texts">
    <h1>Oops! Página no encontrada</h1>
    <br>
    <p>La página que estás buscando no existe. Puedes volver a la página principal</p>
    <br>
    <a href="../../index.jsp" class="btn-primary">Volver a la página de inicio</a>
</div>

<script>
    let container1 = document.getElementById('Square');
    <!--The main square movement script when moving the mouse-->
    window.onmousemove = function (e) {
        let x = -e.x / 90,
            y = -e.y / 90;

        container1.style.right = x + 'px';
        container1.style.bottom = y + 'px';
    }
    /* Mobile gyroscope */
    window.addEventListener("deviceorientation", function (e) {
        container1.style.right = e.gamma/3 + "px"
        container1.style.bottom = e.beta/3 + "px"
    })
</script>
</body>
</html>
