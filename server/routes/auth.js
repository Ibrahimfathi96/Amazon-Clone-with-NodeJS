const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
//SIGN UP
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    //validation the email if it already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email is already exists!" });
    }
    const hashedPassword = await bcryptjs.hash(password,8);

    let newUser = new User({
      email,
      password :hashedPassword,
      name,
    });
    newUser = await newUser.save();
    res.json(newUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
