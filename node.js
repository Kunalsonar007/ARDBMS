https://chatgpt.com/share/681501ea-e2c4-8012-9190-de57089d8bde

// Program 1: Display Message using Node.js
console.log("Hello world");

// Program 2: TodoList using Express
const express = require("express");
const app = express();
const PORT = 3000;

app.use(express.json());

let todos = [{ id: 1, task: "Learn Node.js", completed: false }];

app.get("/todos", (req, res) => {
  res.json(todos);
});

app.post("/todos", (req, res) => {
  const newTodo = {
    id: todos.length + 1,
    task: req.body.task,
    completed: false,
  };
  todos.push(newTodo);
  res.status(201).json(newTodo);
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

// Program 3: Implementation of pwd command
const currentDirectory = process.cwd();
console.log("Current Work Directory:", currentDirectory);

const fs = require("fs");
fs.readFile("somefile.txt", "utf8", (err, data) => {
  if (err) {
    console.error("Error reading file:", err);
    return;
  }
  console.log("File content:", data);
});

// Program 4: User defined date module
// mydatetime.js
module.exports.getDateTime = () => {
  return new Date().toLocaleString();
};

// date.js
const myDate = require("./mydatetime");
console.log("Date and Time:", myDate.getDateTime());

// Program 5: Math module with operations
// math.js
function addition(a, b) {
  return a + b;
}

function subtraction(a, b) {
  return a - b;
}

function multiplication(a, b) {
  return a * b;
}

function division(a, b) {
  if (b == 0) return "Error: Division by zero";
  return a / b;
}

module.exports = { addition, subtraction, multiplication, division };

// app.js
const math = require("./math");
const operation = process.argv[2];
const num1 = parseFloat(process.argv[3]);
const num2 = parseFloat(process.argv[4]);

let result;
switch (operation) {
  case "add":
    result = math.addition(num1, num2);
    break;
  case "sub":
    result = math.subtraction(num1, num2);
    break;
  case "mul":
    result = math.multiplication(num1, num2);
    break;
  case "div":
    result = math.division(num1, num2);
    break;
  default:
    result = 'Invalid operation. Use "add", "sub", "mul", or "div"';
}
console.log(`Result: ${result}`);

// Program 6: Display message with delay using setTimeout
function displayMessage(i, times) {
  if (i < times) {
    setTimeout(() => {
      console.log("Welcome to Node.js");
      displayMessage(i + 1, times);
    }, 1000);
  }
}
displayMessage(0, 5);

// Program 7: Convert string to upper/lower case
const message = "Hello World";
console.log(message.toUpperCase());
console.log(message.toLowerCase());

// Program 8: Serve file content to client
const http = require("http");
const fs = require("fs");
const path = require("path");

const server = http.createServer((req, res) => {
  const filepath = path.join(__dirname, "pr.txt");
  fs.readFile(filepath, "utf8", (err, data) => {
    if (err) {
      res.writeHead(500, { "Content-Type": "text/plain" });
      res.end("Error reading file");
    } else {
      res.writeHead(200, { "Content-Type": "text/plain" });
      res.end(data);
    }
  });
});

server.listen(8000, () => {
  console.log("Server running at http://localhost:8000");
});

// Program 9: File System operations
const fs = require("fs");
const fileName = "demo.txt";

fs.writeFile(fileName, "File system demo", (err) => {
  if (err) throw err;
  console.log("File created and data written");

  fs.readFile(fileName, "utf8", (err, data) => {
    if (err) throw err;
    console.log("Data:", data);

    const newFileName = "new_demo.txt";
    fs.rename(fileName, newFileName, (err) => {
      if (err) throw err;
      console.log("File renamed");

      fs.unlink(newFileName, (err) => {
        if (err) throw err;
        console.log("File deleted");
      });
    });
  });
});

// Program 10: REST API with Express
const express = require("express");
const app = express();
const PORT = 3000;

app.use(express.json());

let users = [
  { id: 1, name: "John Doe", email: "john@example.com" },
  { id: 2, name: "Jane Doe", email: "jane@example.com" },
];

// GET all users
app.get("/users", (req, res) => res.json(users));

// GET single user
app.get("/users/:id", (req, res) => {
  const user = users.find((u) => u.id === parseInt(req.params.id));
  if (!user) return res.status(404).json({ message: "User not found" });
  res.json(user);
});

// POST new user
app.post("/users", (req, res) => {
  const newUser = {
    id: users.length + 1,
    name: req.body.name,
    email: req.body.email,
  };
  users.push(newUser);
  res.status(201).json(newUser);
});

// PUT update user
app.put("/users/:id", (req, res) => {
  const user = users.find((u) => u.id === parseInt(req.params.id));
  if (!user) return res.status(404).json({ message: "User not found" });
  user.name = req.body.name || user.name;
  user.email = req.body.email || user.email;
  res.json(user);
});

// DELETE user
app.delete("/users/:id", (req, res) => {
  users = users.filter((u) => u.id !== parseInt(req.params.id));
  res.json({ message: "User deleted" });
});

app.listen(PORT, () =>
  console.log(`Server running on http://localhost:${PORT}`)
);

// Program 11: MySQL Connection
const mysql = require("mysql");
const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "student_db",
});

con.connect((err) => {
  if (err) throw err;
  console.log("Connected to MySQL!");
  con.query(
    "CREATE TABLE IF NOT EXISTS students (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), age INT)",
    (err) => {
      if (err) throw err;
      console.log("Table created");
    }
  );
});

// Program 12: Node JS Application for Login Credentials
const express = require("express");
const session = require("express-session");
const app = express();
const port = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(
  session({
    secret: "yourSecretKey",
    resave: false,
    saveUninitialized: true,
  })
);

const users = {
  admin: { username: "admin", password: "admin123" },
  user: { username: "user", password: "user123" },
};

app.use(express.static("public"));

app.get("/", (req, res) => {
  if (req.session.user) return res.redirect("/dashboard");
  res.sendFile(__dirname + "/login.html");
});

app.post("/login", (req, res) => {
  const { username, password } = req.body;
  if (users[username] && users[username].password === password) {
    req.session.user = users[username];
    return res.redirect("/dashboard");
  }
  res.send("Invalid credentials. Please try again.");
});

app.get("/dashboard", (req, res) => {
  if (!req.session.user) return res.redirect("/");
  res.send(
    `<h1>Welcome ${req.session.user.username}</h1><a href="/logout">Logout</a>`
  );
});

app.get("/logout", (req, res) => {
  req.session.destroy();
  res.redirect("/");
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

// login.html would be in a separate file
/*
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Login Form</h2>
    <form action="/login" method="POST">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
    </form>
</body>
</html>
*/

// Program 13: Display Student Information
const express = require("express");
const app = express();
const port = 4000;

const students = [
  { id: 1, name: "John Doe", age: 20, major: "Computer Science" },
  { id: 2, name: "Jane Smith", age: 22, major: "Mechanical Engineering" },
  { id: 3, name: "Alice Johnson", age: 21, major: "Biology" },
];

app.get("/", (req, res) => {
  res.send(
    '<h1>Welcome to Student Information Page!</h1><a href="/students">View Students</a>'
  );
});

app.get("/students", (req, res) => {
  let studentList = "<h1>Student Information</h1><ul>";
  students.forEach((student) => {
    studentList += `<li><strong>${student.name}</strong>, Age: ${student.age}, Major: ${student.major}</li>`;
  });
  studentList += "</ul>";
  res.send(studentList);
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

// Program 14: CRUD Operations for Student Information
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const port = 5000;

app.use(bodyParser.json());

let students = [
  { id: 1, name: "John Doe", age: 20, major: "Computer Science" },
  { id: 2, name: "Jane Smith", age: 22, major: "Mechanical Engineering" },
  { id: 3, name: "Alice Johnson", age: 21, major: "Biology" },
];

// Get all students
app.get("/students", (req, res) => {
  res.json(students);
});

// Get single student
app.get("/students/:id", (req, res) => {
  const student = students.find((s) => s.id === parseInt(req.params.id));
  if (!student) return res.status(404).send("Student not found");
  res.json(student);
});

// Add new student
app.post("/students", (req, res) => {
  const { name, age, major } = req.body;
  const newStudent = {
    id: students.length + 1,
    name,
    age,
    major,
  };
  students.push(newStudent);
  res.status(201).json(newStudent);
});

// Update student
app.put("/students/:id", (req, res) => {
  const student = students.find((s) => s.id === parseInt(req.params.id));
  if (!student) return res.status(404).send("Student not found");

  student.name = req.body.name || student.name;
  student.age = req.body.age || student.age;
  student.major = req.body.major || student.major;

  res.json(student);
});

// Delete student
app.delete("/students/:id", (req, res) => {
  const index = students.findIndex((s) => s.id === parseInt(req.params.id));
  if (index === -1) return res.status(404).send("Student not found");

  students.splice(index, 1);
  res.status(200).send("Student deleted");
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

// Program 15: Function Execution in Node.js
function greet(name) {
  console.log(`Hello, ${name}!`);
}

function sum(a, b) {
  return a + b;
}

function sub(a, b) {
  return a - b;
}

function mul(a, b) {
  return a * b;
}

function div(a, b) {
  if (b === 0) return "Error: Division by zero";
  return a / b;
}

// Execute functions
greet("Alice");
console.log("Sum:", sum(3, 4));
console.log("Subtraction:", sub(3, 4));
console.log("Multiplication:", mul(3, 4));
console.log("Division:", div(3, 4));

// Program 16: Web Server Workflow
const http = require("http");

const server = http.createServer((req, res) => {
  res.setHeader("Content-Type", "application/json");

  if (req.url === "/") {
    res.end(JSON.stringify({ message: "Welcome to Node.js Web Server!" }));
  } else if (req.url === "/about") {
    res.end(JSON.stringify({ message: "About Page" }));
  } else {
    res.statusCode = 404;
    res.end(JSON.stringify({ message: "Not Found" }));
  }
});

server.listen(8000, () => {
  console.log("Server running at http://localhost:8000");
});

// Program 17: Restarting Node Application
console.log("Node.js Application Running...");

// Simulate long-running process
setInterval(() => {
  console.log("Application still running...");
}, 5000);

// Program 18: Create Text File
const fs = require("fs");

fs.writeFile("src.txt", "Mongo, Express", (err) => {
  if (err) throw err;
  console.log("File src.txt created successfully");
});

// Program 19: Adventure Trails Routing
// File: routes/route.js
const express = require("express");
const router = express.Router();

router.get("/", (req, res) => {
  res.send("Welcome to Adventure Trails!");
});

router.get("/trails", (req, res) => {
  const trails = [
    { name: "Mountain Adventure", difficulty: "Hard" },
    { name: "River Exploration", difficulty: "Medium" },
    { name: "Forest Trek", difficulty: "Easy" },
  ];
  res.json(trails);
});

router.get("/trails/:id", (req, res) => {
  const trails = [
    {
      id: 1,
      name: "Mountain Adventure",
      difficulty: "Hard",
      description: "Challenging hike",
    },
    {
      id: 2,
      name: "River Exploration",
      difficulty: "Medium",
      description: "Scenic river walk",
    },
    {
      id: 3,
      name: "Forest Trek",
      difficulty: "Easy",
      description: "Peaceful forest walk",
    },
  ];

  const trail = trails.find((t) => t.id === parseInt(req.params.id));
  if (!trail) return res.status(404).send("Trail not found");
  res.json(trail);
});

module.exports = router;

// File: app.js
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use("/api", require("./routes/route"));

app.listen(port, () => {
  console.log(`Adventure Trails app running on http://localhost:${port}`);
});

// Program 20: Form Submission with Validation and Logging
const express = require("express");
const morgan = require("morgan");
const app = express();

app.use(express.json());
app.use(morgan("combined"));

app.post("/submit", (req, res) => {
  const { name, email } = req.body;

  if (!name || !email) {
    return res.status(400).json({
      error: "Name and email are required fields",
    });
  }

  res.status(200).json({
    message: `Submission received. Name: ${name}, Email: ${email}`,
  });
});

app.use((req, res) => {
  res.status(404).json({ error: "Not Found" });
});

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});

// Program 21: Web Design Page with EJS
const express = require("express");
const path = require("path");
const app = express();
const PORT = 3000;

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.static(path.join(__dirname, "public")));

app.get("/", (req, res) => {
  res.render("index", { title: "Web Design Lab" });
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

// index.ejs would be in views folder
/*
<!DOCTYPE html>
<html>
<head>
    <title><%= title %></title>
    <link rel="stylesheet" href="/style.css">
</head>
<body>
    <h1>Welcome to Node.js Lab</h1>
</body>
</html>
*/

// Program 22: Dynamic Date & Time Page
const express = require("express");
const app = express();
const PORT = 3000;

app.set("view engine", "ejs");
app.use(express.static("public"));

app.get("/", (req, res) => {
  res.render("datetime", {
    title: "Current Date & Time",
    time: new Date().toLocaleString(),
  });
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

// datetime.ejs would be in views folder
/*
<!DOCTYPE html>
<html>
<head>
    <title><%= title %></title>
</head>
<body>
    <h1>Current Date & Time</h1>
    <p><%= time %></p>
</body>
</html>
*/

// Program 23: Image Gallery
const express = require("express");
const app = express();
const PORT = 3000;

app.use(express.static("public"));

app.get("/", (req, res) => {
  res.send(`
        <h1>Image Gallery</h1>
        <img src="/images/image1.jpg" width="300">
        <img src="/images/image2.jpg" width="300">
    `);
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

// Program 24: Session Management with Cookies
const express = require("express");
const cookieParser = require("cookie-parser");
const app = express();
const PORT = 3000;

app.use(cookieParser());

app.get("/set-session", (req, res) => {
  res.cookie(
    "sessionData",
    JSON.stringify({
      username: "JohnDoe",
      role: "admin",
    }),
    {
      maxAge: 60000,
      httpOnly: true,
    }
  );
  res.send("Session cookie has been set!");
});

app.get("/get-session", (req, res) => {
  const sessionCookie = req.cookies.sessionData;
  if (sessionCookie) {
    res.send(`Session Data: ${sessionCookie}`);
  } else {
    res.send("No session found");
  }
});

app.get("/clear-session", (req, res) => {
  res.clearCookie("sessionData");
  res.send("Session has been cleared");
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

// Program 25: Session Management with Express-Session
const express = require("express");
const session = require("express-session");
const app = express();
const PORT = 3000;

app.use(
  session({
    secret: "mySecretKey",
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 60000 },
  })
);

app.get("/set-session", (req, res) => {
  req.session.username = "JohnDoe";
  req.session.role = "admin";
  res.send("Session data has been set!");
});

app.get("/get-session", (req, res) => {
  if (req.session.username) {
    res.send(
      `Session Data: Username - ${req.session.username}, Role - ${req.session.role}`
    );
  } else {
    res.send("No session found");
  }
});

app.get("/destroy-session", (req, res) => {
  req.session.destroy();
  res.send("Session has been destroyed");
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
