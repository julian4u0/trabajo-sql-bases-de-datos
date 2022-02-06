<?php
 
// Create connection
require('../configuraciones/conexion.php');

//query
$query="UPDATE usuario SET nombre='$_POST[nombre]',fecha_nacimiento='$_POST[nacimiento]',email='$_POST[email]',telefono='$_POST[telefono]' WHERE cedula='$_POST[cedula]'";
$result = mysqli_query($conn, $query) or 
die(mysqli_error($conn));
 
if($result){
    header ("Location: usuarios.php");
    
     
 }else{
     echo "Ha ocurrido un error al Eliminar  el usuario";
 }
 
mysqli_close($conn);



?>