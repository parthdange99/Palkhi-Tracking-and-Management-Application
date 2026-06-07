<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Palkhi</title>
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

        input[type="text"], textarea {
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

    <!-- Back button redirecting to dashboard -->
    <button class="back-btn" onclick="window.location.href='/admin/palkhi';">Back</button>

    <h1>Add Palkhi</h1>

    <!-- Add Palkhi Form -->
    <form action="/events/add-palkhi" method="POST">
        <?= csrf_field() ?> <!-- CSRF token for security -->

        <label for="title">Title:</label><br>
        <input type="text" id="title" name="title" placeholder="Enter the title of the Palkhi" required><br><br>

        <label for="description">Description:</label><br>
        <textarea id="description" name="description" rows="5" placeholder="Provide a detailed description"></textarea><br><br>

        <button type="submit" class="submit-btn">Save</button>
    </form>

</body>
</html>
