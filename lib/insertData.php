<?php
include "dbController.php";
// REGISTER USER


$name = mysqli_real_escape_string($connect, $_POST['name']);
$email = mysqli_real_escape_string($connect, $_POST['email']);
$phone = mysqli_real_escape_string($connect, $_POST['phone']);


$query = "INSERT INTO registereduser (name, email, phone) VALUES('$name', '$email','$phone')";
$results = mysqli_query($connect, $query);
if ($results > 0) {
    echo "user added successfully";
}
