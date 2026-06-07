<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px;
            display: block;
        }
        .sidebar a:hover, .sidebar a.bg-primary {
            background-color: #495057;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .header {
            background-color: white;
            padding: 10px 20px;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header .nav-link {
            color: #495057;
        }
        .header .nav-link:hover {
            color: #007bff;
        }
        .breadcrumb-item.active span {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="text-center mb-4">
            <img src="<?= base_url('public/Screenshot 2025-01-08 123643.png') ?>" class="img-fluid" alt="Your Logo" />
        </div>
        <nav>
            <?php
                $active_section = $active_section ?? ''; // Fallback for undefined variable
                $nav_items = [
                    ['Dashboard', 'admin/dashboard', 'fas fa-tachometer-alt'],
                    ['Users', 'admin/users', 'fas fa-users'],
                    ['Volunteers', 'volunteers', 'fas fa-hands-helping'],
                    ['Schedule', 'admin/schedule', 'fas fa-calendar-alt'],
                    ['Media', 'admin/media', 'fas fa-photo-video'],
                    ['Palkhi Info', 'admin/palkhi', 'fas fa-info-circle'],
                    ['Settings', 'admin/settings', 'fas fa-cogs'],
                    ['Logout', 'admin/logout', 'fas fa-sign-out-alt']
                ];

                foreach ($nav_items as $item) {
                    [$name, $url, $icon] = $item;
                    $active_class = ($active_section === $name) ? 'bg-primary' : '';
                    echo "<a href='" . base_url($url) . "' class='$active_class'><i class='$icon mr-3'></i> $name</a>";
                }
            ?>
        </nav>
    </div>
    <div class="main-content">
        <div class="header">
            <nav class="d-none d-lg-flex">
                <?php
                foreach ($nav_items as $item) {
                    [$name, $url, $icon] = $item;
                    if (in_array($name, ['Dashboard', 'Users', 'Settings'])) {
                        $active_class = ($active_section === $name) ? 'active' : '';
                        echo "<a class='nav-link $active_class' href='" . base_url($url) . "'>$name</a>";
                    }
                }
                ?>
            </nav>
            <div class="d-flex align-items-center">
                <a class="nav-link" href="#"><i class="fas fa-bell"></i></a>
                <a class="nav-link" href="#"><i class="fas fa-th-large"></i></a>
                <a class="nav-link" href="#"><i class="fas fa-envelope"></i></a>
                <div class="dropdown">
                    <a aria-expanded="false" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" id="userDropdown" role="button">
                        <img alt="User Avatar" class="rounded-circle" height="40" src="<?= $user['avatar'] ?? 'https://placehold.co/40x40' ?>" width="40"/>
                    </a>
                    <ul aria-labelledby="userDropdown" class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="#">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container-fluid px-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb my-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active"><span><?= htmlspecialchars($active_section) ?></span></li>
                </ol>
            </nav>
        </div>
        <div class="container-fluid mt-4">
            <?= $this->renderSection('content') ?>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</body>
</html>