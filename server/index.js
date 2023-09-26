//IMPORTS FROM PACKAGES
const express = require("express");
const app = express();
const mongoose = require("mongoose");
//IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
//INIT
const PORT = 3000;

const url =
  "mongodb+srv://ibmf796:ibmf171996@amazon-clone-db.wg4ihqg.mongodb.net/AmazonClone?retryWrites=true&w=majority";
//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
//Connections
mongoose.connect(url).then(() => {
  console.log("mongodb server started successfully");
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
