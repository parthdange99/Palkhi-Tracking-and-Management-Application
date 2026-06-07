<?php include('main.php'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        .container {
            width: 100%;
        }
        .edit-form {
            display: none;
            margin-top: 20px;
        }
        .message {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
    <script>
        function showEditForm(id, name, email, role) {
            document.getElementById("editForm").style.display = "block";
            document.getElementById("userId").value = id;
            document.getElementById("name").value = name;
            document.getElementById("email").value = email;
            document.getElementById("role").value = role;
        }
    </script>
</head>
<body>
    <div class="content">
        <div class="container">
            <h2>User Management</h2>

            <!-- Success and Error Messages -->
            <?php if (session()->getFlashdata('success')): ?>
                <div class="message"><?= session()->getFlashdata('success'); ?></div>
            <?php elseif (session()->getFlashdata('error')): ?>
                <div class="error"><?= session()->getFlashdata('error'); ?></div>
            <?php endif; ?>

            <!-- Back Button -->
            <button onclick="window.location.href='<?= base_url('/admin/dashboard'); ?>'">Back to Dashboard</button>

            <!-- User Table -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($users as $user): ?>
                        <tr>
                            <td><?= $user['id']; ?></td>
                            <td><?= $user['name']; ?></td>
                            <td><?= $user['email']; ?></td>
                            <td><?= $user['role']; ?></td>
                            <td>
                                <button onclick="showEditForm(<?= $user['id']; ?>, '<?= $user['name']; ?>', '<?= $user['email']; ?>', '<?= $user['role']; ?>')">Edit</button>
                                <a href="<?= base_url('admin/delete/' . $user['id']); ?>" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

            <!-- Edit Form -->
            <div id="editForm" class="edit-form">
                <h3>Edit User</h3>
                <form action="<?= base_url('admin/update'); ?>" method="post">
                    <input type="hidden" name="id" id="userId">
                    <div>
                        <label for="name">Name:</label>
                        <input type="text" name="name" id="name" required>
                    </div>
                    <div>
                        <label for="email">Email:</label>
                        <input type="email" name="email" id="email" required>
                    </div>
                    <div>
                        <label for="role">Role:</label>
                        <input type="text" name="role" id="role" required>
                    </div>
                    <button type="submit">Update User</button>
                    <button type="button" onclick="document.getElementById('editForm').style.display='none';">Cancel</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
