<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Volunteer</title>
    <style>
        .back-btn {
            background-color: #f1f1f1;
            padding: 10px;
            margin: 10px;
            font-size: 14px;
            cursor: pointer;
        }

        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <!-- Back button redirecting to dashboard -->
    <button class="back-btn" onclick="window.location.href='/admin/volunteer';">Back to Dashboard</button>

    <h1>Add Volunteer</h1>
    <form action="/volunteer/add" method="POST">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="task">Task:</label><br>
        <input type="text" id="task" name="task"><br><br>

        <button type="submit" class="submit-btn">Save</button>
    </form>

</body>
</html>