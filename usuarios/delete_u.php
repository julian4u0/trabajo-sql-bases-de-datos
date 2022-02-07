<?php
 
// Create connection
require('../configuraciones/conexion.php');

//query
$query="delete FROM usuario where cedula='$_POST[d]'";
$result = mysqli_query($conn, $query) or 
die(mysqli_error($conn));
 
if($result){
    header ("Location: usuarios.php");
    
     
 }else{
     echo "Ha ocurrido un error al Eliminar  el usuario";
 }
 
mysqli_close($conn);



?>