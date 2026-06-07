<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Media Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        table th {
            background-color: #333;
            color: #fff;
        }

        .btn {
            padding: 5px 10px;
            border: none;
            color: #fff;
            cursor: pointer;
        }

        .btn-delete {
            background-color: #e74c3c;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .form-section {
            margin-top: 40px;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-section h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input[type="text"], 
        .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Media Management</h1>


        <!-- Add Media Form -->
        <div class="form-section">
            <h2>Add New Media</h2>
            <form action="<?= base_url('media/addMedia') ?>" method="POST" enctype="multipart/form-data">
                <?= csrf_field() ?>
                <div class="form-group">
                    <label for="mediaType">Media Type:</label>
                    <input type="text" id="mediaType" name="type" placeholder="Enter media type (e.g., image, video)" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description" placeholder="Enter a short description" required>
                </div>
                <div class="form-group">
                    <label for="file">Upload File:</label>
                    <input type="file" id="file" name="file" required>
                </div>
                <div class="form-group">
                    <button type="submit">Add Media</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const deleteMedia = async (id) => {
            if (!confirm('Are you sure you want to delete this media?')) return;

            try {
                const response = await fetch(`<?= base_url('media/delete/') ?>${id}`, {
                    method: 'DELETE',
                    headers: { 'X-Requested-With': 'XMLHttpRequest' }
                });
                const result = await response.json();

                if (result.status === 'success') {
                    alert(result.message);
                    location.reload(); // Reload the page to refresh data
                } else {
                    alert(result.message);
                }
            } catch (error) {
                console.error('Error deleting media:', error);
            }
        };
    </script>
</body>
</html>