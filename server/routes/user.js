const express = require("express");
const auth = require("../middlewares/authMiddleware");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");
const userRouter = express.Router();

//! ADD TO CART
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

//! REMOVE FROM CART
userRouter.delete("/api/removeFromCart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }

    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});

//! SAVE USER ADDRESS
userRouter.post("/api/saveUserAddress", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});

//! order Product
userRouter.post("/api/orderProduct", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];
    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res.status(400).json({ msg: `${product.name} is out of stock` });
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});

module.exports = userRouter;
