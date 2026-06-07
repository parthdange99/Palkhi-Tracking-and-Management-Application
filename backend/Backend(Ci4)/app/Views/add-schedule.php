<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Schedule</title>
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

        form {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            max-width: 400px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"], input[type="date"], textarea {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }
    </style>
</head>
<body>

    <!-- Back button redirecting to schedule page -->
    <button class="back-btn" onclick="window.location.href='/admin/schedule';">Back</button>

    <h1>Add Schedule</h1>

    <!-- Add Schedule Form -->
    <form action="/events/add-schedule" method="POST">
        <?= csrf_field() ?> <!-- CSRF token for security -->

        <label for="date">Date:</label><br>
        <input type="date" id="Date" name="date" required><br><br>

        <label for="event">Event:</label><br>
        <textarea id="event" name="event" rows="5" placeholder="Provide details about the event"></textarea><br><br>

        <button type="submit" class="submit-btn">Save</button>
    </form>

</body>
</html>
