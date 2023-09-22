//IMPORTS FROM PACKAGES
const express = require("express");
const app = express();
const mongoose = require("mongoose");
//IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
//INIT
//const PORT = 3000;
const PORT = 3000;
// const PORT = 50274;

const url =
  "mongodb+srv://ibmf796:ibmf171996@amazon-clone-db.wg4ihqg.mongodb.net/AmazonClone?retryWrites=true&w=majority";
// "mongodb+srv://ibmf796:01156789207h@cluster0.npuouyo.mongodb.net/?retryWrites=true&w=majority";
// "mongodb+srv://ibrahim:ibrahim1796@cluster0.an8qzvz.mongodb.net/?retryWrites=true&w=majority";
//middleware
app.use(express.json());
app.use(authRouter);
//Connections
mongoose.connect(url).then(() => {
  console.log("mongodb server started successfully");
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
