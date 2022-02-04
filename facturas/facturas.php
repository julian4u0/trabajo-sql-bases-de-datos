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
                        Insertar Factura
                    </div>
                    <div class="card-body">
                        <!--formulario para insertar una persona mediante el metodo post-->
                        <form action="insert_f.php" class="form-group" method="post">
                            <div class="form-group">
                                <label for="cedula">Codigo</label>
                                <input type="text" name="codigo" id="codigo" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Fecha Radicada</label>
                                <input type="date" name="fecha" id="fecha" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Valor</label>
                                <input type="text" name="valor" id="valor" class="form-control">
                            </div>
                            
                            <div  name="taskOption" class="form-group">
                                <label for="exampleFormControlSelect2">Tipo</label>
                                <select class="form-control" onchange="cambioTipo(this)" name="tipo" id="exampleFormControlSelect2">
                                <option value="P"> Prestamo</option>
                                <option value="C">Compra</option>
                                
                                </select>
                            </div>
                            <div id="tipoFactura" class="form-group">
                                <label for="">Fecha Devololucion</label>
                                <input type="date" name="fechar" id="fechar" class="form-control">
                            </div>
                            <!--controlador de los tipo radio-->
                            <script>
                                
                                function cambioTipo(select) {
                                 
                                    
                                    if(select.value==="P"){
                                       
                                        $("#tipoFactura").show();
                                    }
                                    if(select.value==="C"){
                                        $("#tipoFactura").hide();
                                        $("#fechar").val(null);
                                    }
                                   
                                }
                            </script>
                            <div class="form-group">
                                <label for="">Cliente</label>
                                <div class="form-check">
                                    <input class="form-check-input" onclick="cambioCliente(this);" type="radio" name="exampleRadios2" id="exampleRadios2"
                                        value="hotel" checked>
                                    <label class="form-check-label" for="exampleRadios1">
                                        Hotel
                                    </label>
                                </div>
                            </div>
                            <div id="selectHotel" class="form-group">
                                <label for="exampleFormControlSelect2">Hoteles</label>
                                <select name="identificacion" id="identificacion" multiple class="form-control" id="exampleFormControlSelect2">
                                    <?php
                                    require('select_p.php');
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
                                $("#selectHotel").hide();
                                function cambioCliente(myRadio) {
                                    
                                    
                                    if(myRadio.value==="hotel"){
                                       
                                        $("#selectHotel").show();
                                    }
                                    $("#identificacion").val('');
                                }
                            </script>
                          
                           
                            <div class="form-group">
                                <input type="submit" class="btn btn-primary" value="Insertar">
                                <a href="facturas.php" class="btn btn-success">Reiniciar</a>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>
</body>

</html>