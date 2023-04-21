console.log('Hello, World');
//it's like importing files in dart
const express = require('express');
const app = express();//initializing
const PORT = 3000;
//Creating an api using node js
//GET,POST,PUT,DELETE,UPDATE => CRUD
app.listen(PORT,"0.0.0.0",()=>{
console.log(`connected at port ${PORT}`);
});
// localhost => 127.0.0.1 computer is talking to itself