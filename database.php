<?php
  $host='localhost';
  $user='root';
  $password='';
  $db='inventory';

  $conection= @mysqli_connect($host,$user,$password,$db);

  if (!$conection) {
    echo "Error";
  }
 ?>
