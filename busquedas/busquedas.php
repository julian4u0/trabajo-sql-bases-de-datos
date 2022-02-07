<!-- En esta pagina puede encontrar mas informacion acerca de la estructura de un documento html 
    http://www.iuma.ulpgc.es/users/jmiranda/docencia/Tutorial_HTML/estruct.htm-->
<!DOCTYPE html>
<html lang="en">
<!--cabecera del html -->

<head>
    <!--configuraciones basicas del html-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!--titrulo de la pagina-->
    <title>inicio</title>
    <!--CDN de boostraps: Libreria de estilos SCSS y CSS para darle unas buena apariencia a la aplicacion
        para mas informacion buscar documentacion de boostraps en: https://getbootstrap.com/docs/4.3/getting-started/introduction/ -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!--CDN de forntawesome: Libreria de estilos SCSS y CSS incluir iconos y formas 
         para mas informacion : https://fontawesome.com/start-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
        integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
</head>

<body>
    <!--Barra de navegacion-->
    <?php include("../elementos/cabezera.php"); ?>

    <div class="container">
        <div class="row my-2">
            <div class="col-6">
                <p>Para realizar una busqueda de tiquetes primero selecciona la opción y luego y llena los parametros de la busqueda.</p>
                <form action="buscar1.php" target="_blank"  method="POST">
                    <div class="form-check">
                        <input class="form-check-input" onclick="posicion(this);" type="radio" name="exampleRadios" id="exampleRadios1"
                            value="p">
                        <label class="form-check-label" for="exampleRadios1">
                            Posición respecto a los puntos totales
                        </label>
                    </div>
                    <div id="selectPosicion" class="input-group ">
                        <input type="number" name="pos" id="pos" class="form-control">
                        <button class="btn  btn-primary"  title="Buscar1" type="submit">
                            <i class="fas fa-search-plus mx-0 my-0"> </i></button>
                    </div>
                    <!--librerias para usar jquery-->
                    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
                    <!--controlador de los tipo radio-->
                    <script>
                        $("#selectPosicion").hide();
                        function posicion(myRadio) {

                                        
                            if(myRadio.value==="p"){
                                       
                                $("#selectPosicion").show();
                            }
                            $("#pos").val('');
                        }
                    </script>
                </form>

                <form action="buscar2.php" target="_blank"  method="POST">
                    <div class="form-check">
                        <input class="form-check-input" onclick="fechas(this);" type="radio" name="exampleRadios" id="exampleRadios1"
                            value="f">
                        <label class="form-check-label" for="exampleRadios1">
                            Usuarios que no tienen tiquetes registrados entre las fechas
                        </label>
                    </div>
                    <div id="selectFechas" class="input-group ">
                        <input type="date" name="f1" id="f1" class="form-control">
                        <input type="date" name="f2" id="f2" class="form-control">
                        <button class="btn  btn-primary"  title="Buscar2" type="submit">
                            <i class="fas fa-search-plus mx-0 my-0"> </i></button>
                    </div>
                    <!--librerias para usar jquery-->
                    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
                    <!--controlador de los tipo radio-->
                    <script>
                        $("#selectFechas").hide();
                        function fechas(myRadio) {

                                        
                            if(myRadio.value==="f"){
                                       
                                $("#selectFechas").show();
                            }
                            $("#pos").val('');
                        }
                    </script>
                </form>


            </div>
            
        </div>
    </div>




</body>

</html>