<?php
include 'db.php';

$id = $_GET['id'];
$result = mysqli_query($conn, "SELECT * FROM students WHERE id=$id");
$student = mysqli_fetch_assoc($result);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
</head>
<body>

<h2>Edit Student</h2>
<form method="POST" action="update.php">
    <input type="hidden" name="id" value="<?= $student['id'] ?>">

    Name: <input type="text" name="name" value="<?= $student['name'] ?>" required><br><br>
    Email: <input type="email" name="email" value="<?= $student['email'] ?>" required><br><br>
    Course: <input type="text" name="course" value="<?= $student['course'] ?>" required><br><br>

    <button type="submit">Update</button>
</form>

</body>
</html>