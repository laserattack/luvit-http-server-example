local function index(req, res)
    res.code = 200
    res.headers["Content-Type"] = "text/html; charset=utf-8"
    res.body =
[[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel="stylesheet" href="styles.css" type="text/css">
</head>
<body>
    <div class="container">
        <h1>Welcome to Our Website!</h1>
        <p>This is the home page served from a weblit/luvit application.</p>
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
        </ul>
    </div>
</body>
</html>
]]
end

return index