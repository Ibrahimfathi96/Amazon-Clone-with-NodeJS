const jwt = require("jsonwebtoken");
const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied." });

    const verifiedToken = jwt.verify(token, "passwordKey");
    if (!verifiedToken)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });

    req.user = verifiedToken.id;
    req.token = token;
    next();
  } catch (err) {
    console.error("Authentication Error:", err);
    res.status(500).json({ error: "Authentication failed." });
    res.status(500).json({ error: err.message });
  }
};
module.exports = auth;
