<?php include 'db.php'; ?>

<!DOCTYPE html>
<html>
<head>
    <title>Student Records</title>
</head>
<body>

<h2>Add Student</h2>
<form method="POST" action="studentrecord.php">
    Name: <input type="text" name="name" required><br><br>
    Email: <input type="email" name="email" required><br><br>
    Course: <input type="text" name="course" required><br><br>
    <button type="submit">Save</button>
</form>

<hr>

<h2>Student List</h2>
<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Course</th>
        <th>Actions</th>
    </tr>

    <?php
    $result = mysqli_query($conn, "SELECT * FROM students");

    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr>
                <td>{$row['id']}</td>
                <td>{$row['name']}</td>
                <td>{$row['email']}</td>
                <td>{$row['course']}</td>
                <td>
                    <a href='edit.php?id={$row['id']}'>Edit</a> |
                    <a href='delete.php?id={$row['id']}' onclick='return confirm(\"Are you sure?\")'>Delete</a>
                </td>
              </tr>";
    }
    ?>
</table>

</body>
</html>