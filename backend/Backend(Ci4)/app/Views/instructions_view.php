<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructions</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2 class="mb-3">Instructions & Alerts</h2>

    <!-- Add Instruction Form -->
    <form id="addInstructionForm">
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" id="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea id="description" class="form-control" rows="3" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Add Instruction</button>
    </form>

    <hr>

    <!-- Instructions List -->
    <h4>All Instructions</h4>
    <ul id="instructionsList" class="list-group mt-3"></ul>

    <script>
        async function fetchInstructions() {
            const response = await fetch('/instructions');
            const data = await response.json();
            const list = document.getElementById('instructionsList');
            list.innerHTML = '';

            data.forEach(item => {
                const li = document.createElement('li');
                li.classList.add('list-group-item');
                li.innerHTML = `<strong>${item.title}</strong><br>${item.description}`;
                list.appendChild(li);
            });
        }

        document.getElementById('addInstructionForm').addEventListener('submit', async (event) => {
            event.preventDefault();
            const title = document.getElementById('title').value;
            const description = document.getElementById('description').value;

            const response = await fetch('/instructions', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ title, description })
            });

            if (response.ok) {
                document.getElementById('addInstructionForm').reset();
                fetchInstructions();
            } else {
                alert('Failed to add instruction.');
            }
        });

        // Fetch instructions on page load
        fetchInstructions();
    </script>

</body>
</html>
