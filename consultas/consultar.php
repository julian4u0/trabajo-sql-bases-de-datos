<!DOCTYPE html>
<html lang="en">
<head>
    <!--configuraciones basicas del html-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!--titrulo de la pagina-->
    <title>inicio</title>
    <!--CDN de boostraps: Libreria de estilos SCSS y CSS para darle unas buena apariencia a la aplicacion
        para mas informacion buscar documentacion de boostraps en: https://getbootstrap.com/docs/4.3/getting-started/introduction/ -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!--CDN de forntawesome: Libreria de estilos SCSS y CSS incluir iconos y formas 
         para mas informacion : https://fontawesome.com/start-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
        integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
</head>

<body>
    <div class="col-6 px-2">
        <?php 
        if($_POST["exampleRadios"]==="sumapuntos"){
        ?>
            <table class="table border-rounded">
                <thead class="thead ">
                    <tr>
                        <th scope="col">Cédula</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Sumapuntos</th>
                    </tr>
                </thead>

                <?php
                require('../configuraciones/conexion.php');
                $query ="SELECT cedula,nombre,SUM(puntos) AS sumapuntos  
                FROM tiquete JOIN usuario WHERE tiquete.usuario = usuario.cedula
                GROUP BY cedula LIMIT 2";

                $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
                if($result){
                    foreach($result as $fila){
                    ?>
                    <tbody>
                        <tr>
                            <td><?=$fila['cedula'];?></td>
                            <td><?=$fila['nombre'];?></td>
                            <td><?=$fila['sumapuntos'];?></td>
                        </tr>
                    </tbody>
                    <?php
                    }
                }
                else{
                    echo "Ha ocurrido un error al buscar, intenta de nuevo";
                }
    
        }
        else{
            ?>
            <table class="table border-rounded">
                <thead class="thead ">
                    <tr>
                        <th scope="col">Cédula</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Mes</th>
                        <th scope="col">Tiquetes totales</th>
                        <th scope="col">Sumapuntos</th>
                    </tr>
                </thead>

                <?php
                require('../configuraciones/conexion.php');
                $query ="SELECT cedula,nombre,MONTH(fecha_creacion) AS mes,COUNT(*) AS 'tiquetes totales', SUM(puntos) AS sumapuntos 
                FROM tiquete JOIN usuario WHERE tiquete.usuario = usuario.cedula
                GROUP BY MONTH(fecha_creacion),cedula";

                $result = mysqli_query($conn, $query) or die(mysqli_error($conn));
                if($result){
                    foreach($result as $fila){
                    ?>
                    <tbody>
                        <tr>
                            <td><?=$fila['cedula'];?></td>
                            <td><?=$fila['nombre'];?></td>
                            <td><?=$fila['mes'];?></td>
                            <td><?=$fila['tiquetes totales'];?></td>
                            <td><?=$fila['sumapuntos'];?></td>
                        </tr>
                    </tbody>
                    <?php
                    }
                }
                else{
                    echo "Ha ocurrido un error al buscar, intenta de nuevo";
                }
                    
                        
                    }
            ?>

            </table>
    </div>
</body>
</html>

