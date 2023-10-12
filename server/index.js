require("dotenv").config();
//IMPORTS FROM PACKAGES
const express = require("express");
const cors = require("cors");
const app = express();
const mongoose = require("mongoose");
//IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
//INIT
const PORT = process.env.PORT || 8000;

const url = process.env.MONGO_URL;
//middleware
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
//Connections
mongoose.connect(url).then(() => {
  console.log("mongodb server started successfully");
});

app.all("*", (req, res, next) => {
  return res.status(404).json({
    status: "Error",
    message: "This resource does not exist!"
  });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
