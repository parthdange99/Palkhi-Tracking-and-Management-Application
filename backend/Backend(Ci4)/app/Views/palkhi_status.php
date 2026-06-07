<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Palkhi Status</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 50%; margin: auto; text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>

<div class="container">
    <h2>Live Palkhi Status</h2>
    <form id="palkhiForm">
        <input type="text" id="palkhi_number" placeholder="Enter Palkhi Number" required>
        <button type="submit">Get Status</button>
    </form>

    <table id="statusTable" style="display:none;">
        <thead>
            <tr>
                <th>Source</th>
                <th>Arrival</th>
                <th>Departure</th>
                <th>Distance (km)</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
    $(document).ready(function() {
        $("#palkhiForm").submit(function(e) {
            e.preventDefault();
            var palkhiNumber = $("#palkhi_number").val();

            $.post("/fetch-status", { palkhi_number: palkhiNumber }, function(response) {
                if (response.status === 200) {
                    var tableBody = $("#statusTable tbody");
                    tableBody.empty();
                    response.palkhi.forEach(function(source) {
                        tableBody.append(`
                            <tr>
                                <td>${source.source_name}</td>
                                <td>${source.arrival_time}</td>
                                <td>${source.departure_time}</td>
                                <td>${source.distance_km} km</td>
                            </tr>
                        `);
                    });
                    $("#statusTable").show();
                } else {
                    alert(response.message);
                    $("#statusTable").hide();
                }
            }, "json");
        });
    });
</script>

</body>
</html>
