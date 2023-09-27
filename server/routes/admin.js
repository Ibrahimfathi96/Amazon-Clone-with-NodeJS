const express = require("express");
const admin = require("../middlewares/adminMiddleware");
const Product = require("../models/product");
const adminRouter = express.Router();

//Add Product
adminRouter.post("/admin/addProduct", admin, async (req, res) => {
  try {
    const { name, description, quantity, price, images, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category
    });
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});
module.exports = adminRouter;
