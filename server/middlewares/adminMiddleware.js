const jwt = require("jsonwebtoken");
const User = require("../models/user");
const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied." });

    const verifiedToken = jwt.verify(token, "passwordKey");
    if (!verifiedToken)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });

    const user = await User.findById(verifiedToken.id);
    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ msg: "You're not an admin!" });
    }
    req.user = verifiedToken.id;
    req.token = token;
    next();
  } catch (err) {
    console.error("Authentication Error:", err);
    res.status(500).json({ error: "Authentication failed." });
    res.status(500).json({ error: err.message });
  }
};
module.exports = admin;
