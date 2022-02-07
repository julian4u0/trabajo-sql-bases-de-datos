<?php
 
// Create connection
require('../configuraciones/conexion.php');

//query

$query="INSERT INTO tiquete(codigo,fecha_creacion,puntos,viaje,vencimiento_reserva,fecha_compra,usuario)
VALUES('$_POST[codigo]','$_POST[creacion]','$_POST[puntos]','$_POST[viaje]','$_POST[vencimiento]','$_POST[compra]','$_POST[usuario]')";

$result = mysqli_query($conn, $query) or die(mysqli_error($conn));

if($result){
    header ("Location: tiquetes.php");
        
         
}else{
 	echo "Ha ocurrido un error al ingresar el tiquete";
}



?>
