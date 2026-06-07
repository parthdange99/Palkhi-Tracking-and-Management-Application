<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Volunteer</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        body {
            background-color: white;
        }

        header, footer {
            background-color: orange;
            color: white;
            text-align: center;
            padding: 15px;
        }

        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }

        .mb-3 {
            margin-bottom: 20px;
        }

        .form-label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        .back-button {
            background-color: #f0ad4e;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            display: inline-block;
            margin-bottom: 20px;
        }

        .back-button:hover {
            background-color:rgb(2, 77, 38);
            color: white;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Add Volunteer</h1>
    </header>

    <!-- Back Button -->
    <div class="container mt-3">
        <a href="/volunteers" class="back-button">&larr; Back</a>
    </div>

    <!-- Form -->
    <div class="container mt-4">
        <form action="/volunteers/add" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" name="name" id="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="state" class="form-label">State</label>
                <select name="state" id="state" class="form-select" required>
                    <option value="">Select State</option>
                    <?php foreach ($states as $state): ?>
                        <option value="<?= $state; ?>"><?= $state; ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="mb-3">
                <label for="city" class="form-label">City</label>
                <select name="city" id="city" class="form-select" required>
                    <option value="">Select City</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="preference" class="form-label">Preference</label>
                <select name="preference" id="preference" class="form-select" required>
                    <option value="">Select Preference</option>
                    <option value="Food Cooking">Food Cooking</option>
                    <option value="Garbage Collection">Garbage Collection</option>
                    <option value="Event Coordination">Event Coordination</option>
                    <option value="Medical Assistance">Medical Assistance</option>
                    <option value="Logistics">Logistics</option>
                    <option value="Crowd Management">Crowd Management</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="availability" class="form-label">Availability</label>
                <select name="availability" id="availability" class="form-select" required>
                    <option value="">Select availability</option>
                    <option value="morning">Morning</option>
                    <option value="afternoon">Afternoon</option>
                    <option value="evening">Evening</option>
                    <option value="full_day">Full Day</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Add Volunteer</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Volunteer Management</p>
    </footer>

    <script>
        const stateElement = document.getElementById('state');
        const cityElement = document.getElementById('city');
        const cities = <?= json_encode($cities); ?>;

        stateElement.addEventListener('change', function() {
            const selectedState = this.value;
            const options = cities[selectedState] || [];
            cityElement.innerHTML = '<option value="">Select City</option>';
            options.forEach(city => {
                const option = document.createElement('option');
                option.value = city;
                option.textContent = city;
                cityElement.appendChild(option);
            });
        });
    </script>
</body>
</html>
