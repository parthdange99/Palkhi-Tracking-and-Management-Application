<?php include('main.php'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Palkhi Information</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .content {
            margin-left: 250px; /* Leave space for the sidebar */
            margin-top: 60px; /* Leave space for the header */
            padding: 20px;
        }
        /* Styling for buttons */
        .btn-back, .btn-add, .btn-delete {
            padding: 10px 20px;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn-back {
            background: #555;
        }
        .btn-add {
            background: #17a2b8;
        }
        .btn-delete {
            background: #dc3545;
            padding: 5px 10px;
            font-size: 14px;
        }
        table {
            width: 100%;
            margin-top: 20px; /* Adjusted for button space */
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="content">
        <!-- Back and Add Palkhi Buttons -->
        <button class="btn-back" onclick="window.location.href='<?= base_url('/admin/dashboard'); ?>'">Back</button>
        <button class="btn-add" onclick="window.location.href='<?= base_url('/events/add-palkhi'); ?>'">Add Palkhi</button>

        <!-- Palkhi Information Table -->
        <h1>Palkhi Information</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($palkhis as $palkhi): ?>
                    <tr>
                        <td><?= htmlspecialchars($palkhi['id'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td><?= htmlspecialchars($palkhi['title'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td><?= htmlspecialchars($palkhi['description'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td>
                            <button class="btn-delete" onclick="if(confirm('Are you sure?')) window.location.href='<?= base_url('/events/delete-palkhi/' . $palkhi['id']); ?>'">Delete</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</body>
</html>
