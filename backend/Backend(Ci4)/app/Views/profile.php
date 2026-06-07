<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile</title>
    <link rel="stylesheet" href="<?= base_url('css/style.css') ?>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div style="padding: 20px; max-width: 600px; margin: 50px auto; border: 1px solid #ddd; border-radius: 10px;">
        <h1 style="text-align: center;">Admin Profile</h1>
        <table style="width: 100%; border-collapse: collapse;">
            <tr>
                <th style="text-align: left; padding: 10px; border-bottom: 1px solid #ddd;">Name</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;"><?= $user['name'] ?></td>
            </tr>
            <tr>
                <th style="text-align: left; padding: 10px; border-bottom: 1px solid #ddd;">Email</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;"><?= $user['email'] ?></td>
            </tr>
            <tr>
                <th style="text-align: left; padding: 10px; border-bottom: 1px solid #ddd;">ID</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;"><?= $user['id'] ?></td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: 20px;">
            <button onclick="window.location.href='<?= base_url('admin/logout') ?>'" 
                    style="padding: 10px 20px; background-color: #f00; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
                Logout
            </button>
        </div>
    </div>
</body>
</html>
