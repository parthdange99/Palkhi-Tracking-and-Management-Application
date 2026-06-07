<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h3>Admin Profile</h3>
            </div>
            <div class="card-body">
                <table class="table">
                    <tr>
                        <th>Name:</th>
                        <td><?= $admin['name'] ?></td>
                    </tr>
                    <tr>
                        <th>Email:</th>
                        <td><?= $admin['email'] ?></td>
                    </tr>
                    <tr>
                        <th>ID:</th>
                        <td><?= $admin['id'] ?></td>
                    </tr>
                </table>
                <div class="text-center mt-4">
                    <a href="<?= base_url('admin/settings') ?>" class="btn btn-warning">Edit Profile</a>
                    <a href="<?= base_url('admin/logout') ?>" class="btn btn-danger">Logout</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
