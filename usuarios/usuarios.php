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
    <title>inicio</title>
    <!--CDN de boostraps: Libreria de estilos SCSS y CSS para darle unas buena apariencia a la aplicacion
    para mas informacion buscar documentacion de boostraps en: https://getbootstrap.com/docs/4.3/getting-started/introduction/ -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!--CDN de forntawesome: Libreria de estilos SCSS y CSS incluir icononos y formas 
     para mas informacio : https://fontawesome.com/start-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
        integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
</head>

<body>
    <!--Barra de navegacion-->
    <?php include("../elementos/cabezera.php"); ?>

    <div class="container mt-3">
        <div class="row">
            <?php
                if(isset($_GET["cedula"])){
             ?>
            <div class="col-6 px-2">
                <div class="card">
                    <div class="card-header">
                        Editar Usuario
                    </div>
                    <div class="card-body">
                        <!--formulario para insertar una persona mediante el metodo post-->
                        <form action="update_u.php" class="form-group" method="post">
                            <div class="form-group">
                                <label for="cedula">Cédula</label>
                                <input type="text" readonly name="cedula" value=<?=$_GET["cedula"];?> id="cedula"
                                    class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Nombre</label>
                                <input type="text" name="nombre" value='<?=$_GET["nombre"];?>' id="name" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Fecha de Nacimiento</label>
                                <input type="date" name="nacimiento" value='<?=$_GET["fecha_nacimiento"];?>' id="nacimiento" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Email</label>
                                <input type="text" name="email" value='<?=$_GET["email"];?>' id="email" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Teléfono</label>
                                <input type="text" name="telefono" value=<?=$_GET["telefono"];?> id="telefono" class="form-control">
                            </div>

                            <div class="form-group">
                                <input type="submit" class="btn btn-primary" value="Guardar">
                                <a href="personas.php" class="btn btn-danger">descartar</a>
                                
                            </div>

                        </form>

                    </div>
                </div>
            </div>
            <?php
           }
        else{
             ?>
            <div class="col-6 px-2">
                <div class="card">
                    <div class="card-header">
                        Insertar Usuario
                    </div>
                    <div class="card-body">
                        <!--formulario para insertar una persona mediante el metodo post-->
                        <form action="insert_u.php" class="form-group" method="post">
                            <div class="form-group">
                                <label for="cedula">Cédula</label>
                                <input type="text" name="cedula" id="cedula" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Nombre</label>
                                <input type="text" name="name" id="name" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Fecha de Nacimiento</label>
                                <input type="date" name="nacimiento" id="nacimiento" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Email</label>
                                <input type="text" name="email" id="email" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="">Teléfono</label>
                                <input type="text" name="telefono" id="telefono" class="form-control">
                            </div>

                            <div class="form-group">
                                <input type="submit" class="btn btn-primary" value="insertar">
                                <a href="usuarios.php" class="btn btn-success">Reiniciar</a>
                            </div>
                            

                        </form>

                    </div>
                </div>
            </div>

            <?php
        }
        ?>
            <div class="col-6 px-2">

                <table class="table border-rounded">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Cédula</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Nacimiento</th>
                            <th scope="col">Email</th>
                            <th scope="col">Teléfono</th>
                            <th scope="col">Opciones</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        require('select_u.php');
                        if($result){
                            foreach ($result as $fila){
                        ?>
                        <tr>
                            <td><?=$fila['cedula'];?></td>
                            <td><?=$fila['nombre'];?></td>
                            <td><?=$fila['fecha_nacimiento'];?></td>
                            <td><?=$fila['email'];?></td>
                            <td><?=$fila['telefono'];?></td>
                            <td>

                                <form action="delete_u.php" method="POST">
                                    <input type="text" value=<?=$fila['cedula'];?> hidden>
                                    <input type="text" name="d" value=<?=$fila['cedula'];?> hidden>
                                    <button class="btn btn-danger" title="eliminar" type="submit"><i
                                            class="fas fa-trash-alt"></i></button>
                                </form>
                            </td>
                            <td class="mx-0 pr-2">
                                <form action="usuarios.php" method="GET">
                                    
                                    <input type="text" name="cedula" value=<?=$fila['cedula'];?> hidden>
                                    <input type="text" name="nombre" value='<?=$fila['nombre'];?>' hidden>
                                    <input type="text" name="nacimiento" value='<?=$fila['fecha_nacimiento'];?>' hidden>
                                    <input type="text" name="email" value='<?=$fila['email'];?>' hidden>
                                    <input type="text" name="telefono" value=<?=$fila['telefono'];?> hidden>

                                    <button class="btn btn-primary" title="editar" type="submit"><i
                                            class="far fa-edit"></i></button>
                                </form>
                            </td>



                        </tr>
                        <?php                    

                                }
                            }
                            
                            ?>
                    </tbody>
                </table>

            </div>
        </div>


    </div>




</body>

</html>