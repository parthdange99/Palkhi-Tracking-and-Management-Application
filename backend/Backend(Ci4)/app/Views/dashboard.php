<?php include('main.php'); ?>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.9.3/dist/leaflet.css" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #6a6a6a 0%, #a8a8a8 100%);
            color: #fff;
            min-height: 100vh;
        }
        .card {
            margin-bottom: 20px;
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            background-color: #343A40; /* Dark grey background */
            color: #fff; /* White text for contrast */
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        .map-container {
            height: 500px;
            margin-bottom: 20px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        .full-width {
            width: calc(100% - 250px);
            margin-left: 250px;
        }
        .animated-heading {
            animation: fadeIn 1.5s ease-in-out;
        }
        .form-select {
            background-color: rgba(255, 255, 255, 0.8);
            border: none;
            color: #000;
        }
        h2 {
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid full-width">
        <!-- Statistics Cards -->
        <div class="row animated-heading">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="font-semibold">Total Users</h5>
                        <p class="text-3xl font-bold"><?= $totalUsers; ?></p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="font-semibold">Volunteers</h5>
                        <p class="text-3xl font-bold"><?= $totalVolunteers; ?></p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="font-semibold">Schedules</h5>
                        <p class="text-3xl font-bold"><?= $totalSchedules; ?></p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="font-semibold">Palkhis</h5>
                        <p class="text-3xl font-bold"><?= $totalPalkhis; ?></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Palkhi Tracking Section -->
        <div class="row">
            <div class="col-12">
                <h2 class="my-4 animated-heading">Palkhi Tracking</h2>
                <div class="mb-3">
                    <label for="dindiSelect" class="form-label">Select Palkhi</label>
                    <select id="dindiSelect" class="form-select">
                        <option value="palkhi1">Palkhi 1</option>
                        <option value="palkhi2">Palkhi 2</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Map Section -->
        <div class="row">
            <div class="col-12">
                <div id="map" class="map-container bg-light"></div>
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://cdn.jsdelivr.net/npm/leaflet@1.9.3/dist/leaflet.js"></script>

    <script>
        // Initialize the map
        const map = L.map('map').setView([19.9975, 73.7898], 10); // Default center
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Function to update markers dynamically
        function updateMarkers(palkhi) {
            fetch(`real-time-location/${palkhi}`) // Replace with actual backend URL
                .then(response => response.json())
                .then(data => {
                    // Clear existing markers
                    map.eachLayer(layer => {
                        if (layer instanceof L.Marker) {
                            map.removeLayer(layer);
                        }
                    });

                    // Add new markers
                    data.locations.forEach(location => {
                        L.marker([location.lat, location.lng])
                            .addTo(map)
                            .bindPopup(location.name);
                    });
                });
        }

        // Event listener for Palkhi selection dropdown
        document.getElementById('dindiSelect').addEventListener('change', event => {
            updateMarkers(event.target.value);
        });

        // Load initial data for Palkhi 1
        updateMarkers('palkhi1');
    </script>
</body>
</html>
