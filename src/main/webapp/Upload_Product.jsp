<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Product</title>
    <style>
        /* Optional: Add some basic styling for the form */
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="file"], input[type="number"], button {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h2>Upload Product</h2>
<form action="UploadProductServlet" method="POST" enctype="multipart/form-data">
    <label for="name">Product Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter the product name" required><br>

    <label for="description">Description:</label>
    <input type="text" id="description" name="description" placeholder="Enter a brief description" required><br>

    <label for="price">Price ($):</label>
    <input type="text" id="price" name="price" placeholder="Enter the product price" pattern="\d+(\.\d{2})?" title="Please enter a valid price (e.g., 19.99)" required><br>

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" placeholder="Enter the product quantity" min="1" required><br>

    <label for="image">Product Image:</label>
    <input type="file" id="image" name="image" accept="image/*" required><br>

    <button type="submit">Upload Product</button>
</form>

<!-- Optional: Add a progress indicator for the file upload -->
<script>
    const form = document.querySelector('form');
    const imageInput = document.getElementById('image');

    form.onsubmit = function() {
        const fileSize = imageInput.files[0].size / 1024 / 1024; // in MB
        if (fileSize > 5) {
            alert("File size exceeds 5MB. Please choose a smaller image.");
            return false;
        }
        // Add progress indicator here if necessary
    };
</script>

</body>
</html>
