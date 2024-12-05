<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Product</title>
</head>
<body>
<h2>Upload Product</h2>
<form action="UploadProductServlet" method="POST" enctype="multipart/form-data">
    <label for="name">Product Name:</label>
    <input type="text" id="name" name="name" required><br><br>

    <label for="description">Description:</label>
    <input type="text" id="description" name="description" required><br><br>

    <label for="price">Price:</label>
    <input type="text" id="price" name="price" required><br><br>

    <label for="image">Product Image:</label>
    <input type="file" id="image" name="image" accept="image/*" required><br><br>

    <button type="submit">Upload Product</button>
</form>
</body>
</html>
