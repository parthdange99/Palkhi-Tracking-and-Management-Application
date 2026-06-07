<?php include('main.php'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Volunteer Management</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: white;
        }

        .content {
            margin-left: 250px; /* Leave space for the sidebar */
            margin-top: 60px; /* Leave space for the header */
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: orange;
            color: white;
        }

        .actions button {
            margin-right: 5px;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }

        .actions .assign {
            background-color: blue;
            color: white;
        }

        .actions .delete {
            background-color: red;
            color: white;
        }

        .btn {
            background-color: green;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="content">
        <!-- Back and Add Volunteer Buttons -->
        <button class="btn" onclick="window.location.href='<?= base_url('/dashboard'); ?>'">Back to Dashboard</button>
        <button class="btn" onclick="window.location.href='<?= base_url('/volunteers/add'); ?>'">Add Volunteer</button>

        <!-- Volunteer List Table -->
        <h2>Volunteer List</h2>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>State</th>
                    <th>City</th>
                    <th>Preference</th>
                    <th>Availability</th>
                    <th>Assigned Task</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($volunteers as $volunteer): ?>
                    <tr>
                        <td><?= htmlspecialchars($volunteer['name'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td><?= htmlspecialchars($volunteer['email'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td><?= htmlspecialchars($volunteer['state'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td><?= htmlspecialchars($volunteer['city'], ENT_QUOTES, 'UTF-8'); ?></td>
                        
                        <td><?= htmlspecialchars($volunteer['availability'], ENT_QUOTES, 'UTF-8'); ?></td>
                        <td><?= htmlspecialchars($volunteer['assigned_task'], ENT_QUOTES, 'UTF-8'); ?></td>

                        <td class="actions">
                            <!-- Task Assignment Form -->
                            <form action="<?= base_url('/volunteer/assign-task/' . $volunteer['id']); ?>" method="POST" style="display: inline-block;">
                                <input type="text" name="task" placeholder="Assign Task" required>
                                <button type="submit" class="assign">Assign Task</button>
                            </form>

                            <!-- Delete Volunteer Form -->
                            <form action="<?= base_url('/volunteer/delete/' . $volunteer['id']); ?>" method="POST" style="display: inline-block;">
                                <button type="submit" class="delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</body>
</html>
