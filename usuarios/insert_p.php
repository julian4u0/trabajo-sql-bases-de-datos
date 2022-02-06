<?php
 
// Create connection
require('../configuraciones/conexion.php');

$cedula = $_POST["cedula"];

//query
if($cedula<0){
	echo "cedula debe ser positiva";
}

else{
	$query="INSERT INTO `usuario`(`cedula`,`nombre`, `fecha_nacimiento`, `email`, `telefono`)
 	VALUES ('$_POST[cedula]','$_POST[name]','$_POST[nacimiento]','$_POST[email]','$_POST[telefono]')";
	$result = mysqli_query($conn, $query) or die(mysqli_error($conn));

 	if($result){
        header ("Location: usuarios.php");
        
         
 	}else{
 		echo "Ha ocurrido un error al crear el usuario";
 	}


}

?>
