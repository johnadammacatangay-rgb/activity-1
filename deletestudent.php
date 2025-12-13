<?php
include 'db.php';

$name = $_POST['name'];
$course = $_POST['course'];
$year = $_POST['year_level'];

$sql = "INSERT INTO students (name, course, year_level)
        VALUES ('$name', '$course', '$year')";

if ($conn->query($sql)) {
    header("Location: index.php");
} else {
    echo "Error: " . $conn->error;
}
?>
