<?php include('main.php'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #0056b3;
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
</head>
<body>
    <div class="container">
        <h1>Settings</h1>

        <!-- Success Message -->
        <?php if (session()->getFlashdata('success')): ?>
            <p class="message"><?= session()->getFlashdata('success'); ?></p>
        <?php endif; ?>

        <!-- Error Messages -->
        <?php if (session()->getFlashdata('errors')): ?>
            <div class="error">
                <ul>
                    <?php foreach (session()->getFlashdata('errors') as $error): ?>
                        <li><?= $error; ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <!-- Settings Form -->
        <form action="<?= base_url('/settings/update'); ?>" method="POST">
            <div class="form-group">
                <label for="site_name">Site Name:</label>
                <input type="text" id="site_name" name="site_name" value="<?= $settings['site_name'] ?? ''; ?>" required>
            </div>
            <div class="form-group">
                <label for="timezone">Timezone:</label>
                <select id="timezone" name="timezone" required>
                    <option value="UTC" <?= ($settings['timezone'] ?? '') === 'UTC' ? 'selected' : ''; ?>>UTC</option>
                    <option value="America/New_York" <?= ($settings['timezone'] ?? '') === 'America/New_York' ? 'selected' : ''; ?>>America/New_York</option>
                    <option value="Asia/Kolkata" <?= ($settings['timezone'] ?? '') === 'Asia/Kolkata' ? 'selected' : ''; ?>>Asia/Kolkata</option>
                </select>
            </div>
            <div class="form-group">
                <label for="email_from">Email From Address:</label>
                <input type="email" id="email_from" name="email_from" value="<?= $settings['email_from'] ?? ''; ?>" required>
            </div>
            <div class="form-group">
                <button type="submit">Save Settings</button>
            </div>
        </form>
    </div>
</body>
</html>
