<!-- En esta pagina puede encontrar mas informacion acerca de la estructura de un documento html 
    http://www.iuma.ulpgc.es/users/jmiranda/docencia/Tutorial_HTML/estruct.htm-->
<!DOCTYPE html>
<html lang="en">
<!--cabezera del html -->

<head>
    <!--configuraciones basicas del html-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!--titrulo de la pagina-->
    <title>Facturas</title>
    <!--CDN de boostraps: Libreria de estilos SCSS y CSS para darle unas buena apariencia a la aplicacion
    para mas informacion buscar documentacion de boostraps en: https://getbootstrap.com/docs/4.3/getting-started/introduction/ -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!--CDN de forntawesome: Libreria de estilos SCSS y CSS incluir icononos y formas 
     para mas informacio : https://fontawesome.com/start-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
        crossorigin="anonymous">
</head>

<body>
    <!--Barra de navegacion-->
    <?php include("../elementos/cabezera.php"); ?>

    <div class="container mt-3">
        <div class="row">
            <div class="col-6 px-2">
                <div class="card">
                    <div class="card-header">
                        Insertar Tiquete
                    </div>
                    <div class="card-body">
                        <!--formulario para insertar una persona mediante el metodo post-->
                        <form action="insert_t.php" class="form-group" method="post">
                            <div class="form-group">
                                <label for="codigo">Código</label>
                                <input type="text" name="codigo" id="codigo" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Fecha de  Creación</label>
                                <input type="date" name="creacion" id="creacion" class="form-control">
                            </div>
                            
                            <div class="form-group">
                                <label for="">Puntos</label>
                                <input type="text" name="puntos" id="puntos" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Viaje asociado</label>
                                <div class="form-check">
                                    <input class="form-check-input" onclick="cambioViaje(this);" type="radio" name="exampleRadios2" id="exampleRadios2"
                                        value="v">
                                    <label class="form-check-label" for="exampleRadios1">
                                        Viaje
                                    </label>
                                </div>
                            </div>
                            <div id="selectViaje" class="form-group">
                                <label for="exampleFormControlSelect2">Viajes</label>
                                <select name="viaje" id="viaje" multiple class="form-control" id="exampleFormControlSelect2">
                                    <?php
                                    require('select_v.php');
                                    if($resultP){
                                        foreach ($resultP as $fila){
                                    ?>
                                            <option value=<?=$fila['codigo'];?>  ><b>Cod:</b> <?=$fila['codigo'];?><b> - Ciudad: </b><?=$fila['ciudad'];?></option>
                                    <?php
                                        }
                                    }
                        
                                    ?>    
                                      
                                </select>
                            </div>
                            <!--librerias para usar jquery-->
                            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
                             <!--controlador de los tipo radio-->
                            <script>
                                $("#selectViaje").hide();
                                function cambioViaje(myRadio) {
                                    
                                    
                                    if(myRadio.value==="v"){
                                       
                                        $("#selectViaje").show();
                                    }
                                    $("#viaje").val('');
                                }
                            </script>
                            <div  name="taskOption" class="form-group">
                                <label for="exampleFormControlSelect">¿Se efectuará una reserva o una compra?</label>
                                <select class="form-control" onclick="cambioTipo(this)" name="tipo" id="exampleFormControlSelect">
                                <option value="R">Reservación</option>
                                <option value="C">Compra</option>
                                
                                </select>
                            </div>
                            <div id="reservacion" class="form-group">
                                <label for="">Vencimiento de reserva</label>
                                <input type="date" name="vencimiento" id="vencimiento" class="form-control">
                            </div>
                            <div id="compra" class="form-group">
                                <label for="">Fecha de compra</label>
                                <input type="date" name="compra" id="compra" class="form-control">
                            </div>  
                            <!--controlador de los tipo radio-->
                            <script>
                                function cambioTipo(select) {
                                    
                                    if(select.value==="R"){
                                       
                                        $("#reservacion").show();
                                        $("#compra").hide();
                                        $("compra").val(null);
                                    }
                                    if(select.value==="C"){

                                        $("#compra").show();
                                        $("#reservacion").hide();
                                        $("vencimiento").val(null);
                                    }
                                   
                                }
                            </script>
                            <div class="form-group">
                                <label for="">Cliente</label>
                                <div class="form-check">
                                    <input class="form-check-input" onclick="cambioCliente1(this);" type="radio" name="exampleRadios3" id="exampleRadios3"
                                        value="u">
                                    <label class="form-check-label" for="exampleRadios3">
                                        Usuario
                                    </label>
                                </div>
                            </div>
                            <div id="selectUsuario" class="form-group">
                                <label for="exampleFormControlSelect3">Usuarios</label>
                                <select name="usuario" id="usuario" multiple class="form-control" id="exampleFormControlSelect3">
                                    <?php
                                    require('select_u.php');
                                    if($resultP){
                                        foreach ($resultP as $fila){
                                    ?>
                                            <option value=<?=$fila['cedula'];?>  ><b>CC:</b> <?=$fila['cedula'];?><b> - Nombre: </b><?=$fila['nombre'];?></option>
                                    <?php
                                        }
                                    }
                        
                                    ?>    
                                      
                                </select>
                            </div>
                            <!--librerias para usar jquery-->
                            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
                             <!--controlador de los tipo radio-->
                            <script>
                                $("#selectUsuario").hide();
                                function cambioCliente1(myRadio) {
                                    
                                    
                                    if(myRadio.value==="u"){
                                       
                                        $("#selectUsuario").show();
                                    }
                                    $("#usuario").val('');
                                }
                            </script>
      
                           
                            <div class="form-group">
                                <input type="submit" class="btn btn-primary" value="Insertar">
                                <a href="tiquetes.php" class="btn btn-success">Reiniciar</a>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>

        
    </div>




</body>

</html>