<!DOCTYPE html>
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
            background: #f9f9f9;
        }

        /* Sidebar styling */
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background: linear-gradient(180deg, #2c3e50, #34495e);
            color: white;
            padding-top: 20px;
            box-shadow: 3px 0 8px rgba(0, 0, 0, 0.2);
        }

        .sidebar img {
            max-width: 150px;
            border-radius: 50%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px 20px;
            display: block;
            font-weight: 500;
            transition: all 0.3s ease-in-out;
            border-radius: 5px;
        }

        .sidebar a i {
            margin-right: 10px;
        }

        .sidebar a:hover, .sidebar a.bg-primary {
            background: linear-gradient(90deg, #1abc9c, #16a085);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        /* Header styling */
        .header {
            background: #ffffff;
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .nav-link {
            color: #495057;
            transition: all 0.3s ease;
        }

        .header .nav-link:hover {
            color: #007bff;
            transform: scale(1.1);
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
        }

        .breadcrumb-item.active span {
            font-weight: bold;
            color: #007bff;
        }

        /* Main content styling */
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        /* Add subtle shadow to cards or containers */
        .container-fluid, .card {
            background: white;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
        }

        .nav-item.active {
            font-weight: bold;
            color: #007bff !important;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="text-center mb-4">
            <img src="<?= base_url('public/file.png') ?>" class="img-fluid" alt="PALKHI TRACKER" />
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
                    echo "<a href='" . base_url($url) . "' class='$active_class'><i class='$icon'></i> $name</a>";
                }
            ?>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
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
        <img alt="User Avatar" class="rounded-circle" height="40" src="<?= base_url('public/images/avatar.png') ?>" width="40" />
    </a>
    <ul aria-labelledby="userDropdown" class="dropdown-menu dropdown-menu-end">
        <li><a class="dropdown-item" href="<?= base_url('admin/profile') ?>">Profile</a></li>
        <li><a class="dropdown-item" href="<?= base_url('admin/settings') ?>">Settings</a></li>
        <li><a class="dropdown-item" href="<?= base_url('admin/logout') ?>">Logout</a></li>
    </ul>
</div>


            </div>
        </div>

        <!-- Breadcrumb -->
        <div class="container-fluid px-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb my-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active"><span><?= htmlspecialchars($active_section) ?></span></li>
                </ol>
            </nav>
        </div>

        <!-- Content Section -->
        <div class="container-fluid mt-4">
            <?= $this->renderSection('content') ?>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
