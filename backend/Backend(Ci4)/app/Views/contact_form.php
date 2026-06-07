<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        .success {
            color: green;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h1>Contact Admin</h1>

    <?php if (session()->has('message')): ?>
        <div class="success"><?= session('message') ?></div>
    <?php endif; ?>

    <form action="/contact/submit" method="post">
        <div class="form-group">
            <label for="name">Your Name</label>
            <input type="text" id="name" name="name" value="<?= old('name') ?>">
            <?php if (session()->has('errors') && isset(session('errors')['name'])): ?>
                <div class="error"><?= session('errors')['name'] ?></div>
            <?php endif; ?>
        </div>

        <div class="form-group">
            <label for="email">Your Email</label>
            <input type="email" id="email" name="email" value="<?= old('email') ?>">
            <?php if (session()->has('errors') && isset(session('errors')['email'])): ?>
                <div class="error"><?= session('errors')['email'] ?></div>
            <?php endif; ?>
        </div>

        <div class="form-group">
            <label for="query">Your Query</label>
            <textarea id="query" name="query"><?= old('query') ?></textarea>
            <?php if (session()->has('errors') && isset(session('errors')['query'])): ?>
                <div class="error"><?= session('errors')['query'] ?></div>
            <?php endif; ?>
        </div>

        <div class="form-group">
            <button type="submit">Submit</button>
        </div>
    </form>
</body>
</html>