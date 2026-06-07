<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Volunteer List</title>
    <style>
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar {
            flex-grow: 1;
            margin-right: 10px;
        }

        .add-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        .back-btn {
            background-color: #f1f1f1;
            padding: 10px;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <button class="back-btn" onclick="window.location.href='/admin/dashboard';">Back</button>
        <form method="get" class="search-bar">
            <input type="text" name="search" placeholder="Search volunteers..." value="<?= esc($this->request->getGet('search')) ?>">
            <button type="submit">Search</button>
        </form>
        <button class="add-btn" onclick="window.location.href='/volunteer/add';">Add Volunteer</button>
    </div>

    <h1>Volunteer List</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Task</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($volunteers as $volunteer): ?>
                <tr>
                    <td><?= esc($volunteer['name']); ?></td>
                    <td><?= esc($volunteer['email']); ?></td>
                    <td><?= $volunteer['task'] ? esc($volunteer['task']) : 'Not Assigned'; ?></td>
                    <td>
                        <form method="post" action="<?= site_url('/volunteer/assign-task/' . $volunteer['id']); ?>">
                            <?= csrf_field(); ?>
                            <input type="text" name="task" placeholder="Assign Task">
                            <button type="submit">Assign</button>
                        </form>
                        <form method="post" action="<?= site_url('/volunteer/delete/' . $volunteer['id']); ?>">
                            <?= csrf_field(); ?>
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
