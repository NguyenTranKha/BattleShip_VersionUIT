<?php
  session_start();
  
  $servername = "localhost";
  $username = "battleship";
  $password = "qwerty12345678";
  $dbname = "BATTLESHIP";

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  // Check connection
  if ($conn->connect_error) {
      die("Connection failed: " . $conn->connect_error);
  } 
  
  $room = test_input($_GET["room"]);
  
  $sql = "SELECT TIME_NOW FROM TIME WHERE ROOM = '$room'";
  $result = $conn->query($sql);
  $row = $result->fetch_assoc();
  
  echo $row["TIME_NOW"];
  
  function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
  }
?>