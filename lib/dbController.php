<?php
    $username="root";
    $password="33421109";
    $host="localhost";
    $db_name="crud1";

    $connect=mysqli_connect($host,$username,$password,$db_name);

    if(!$connect)
    {
        echo json_encode("Connection Failed");
    }
?>
