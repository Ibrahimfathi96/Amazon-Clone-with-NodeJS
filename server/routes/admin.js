const express = require("express");
const admin = require("../middlewares/adminMiddleware");
const { Product } = require("../models/product");
const adminRouter = express.Router();

//!Add Product
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

//!GET ALL Products
adminRouter.get("/admin/getAllProducts", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//!DELETE A PRODUCT
adminRouter.post("/admin/deleteProduct", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
module.exports = adminRouter;
