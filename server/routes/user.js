const express = require("express");
const auth = require("../middlewares/authMiddleware");
const { Product } = require("../models/product");
const User = require("../models/user");
const userRouter = express.Router();

userRouter.post("/api/addToCart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let found = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          found = true;
        }
      }

      if (found) {
        let foundedProduct = user.cart.find((prod) =>
          prod.product._id.equals(product._id)
        );
        foundedProduct.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }

    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});

module.exports = userRouter;
