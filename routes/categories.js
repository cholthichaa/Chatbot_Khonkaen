const express = require("express");
const router = express.Router();

router.post("/", async (req, res) => {
  const { categories_name } = req.body;

  if (!categories_name || categories_name.trim() === "") {
    return res.status(400).json({ error: "Category name is required" });
  }

  const query = `
    INSERT INTO categories (categories_name)
    VALUES ($1)
    RETURNING *;
  `;

  try {
    const result = await req.client.query(query, [categories_name]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Error creating category:", error.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.get("/", async (req, res) => {
  const query = "SELECT * FROM categories;";

  try {
    const result = await req.client.query(query);
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching categories:", error.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  const query = "SELECT * FROM categories WHERE id = $1;";

  try {
    const result = await req.client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Category not found" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error("Error fetching category:", error.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.patch("/:id", async (req, res) => {
  const { id } = req.params;
  const { categories_name } = req.body;

  if (!categories_name || categories_name.trim() === "") {
    return res.status(400).json({ error: "Category name is required" });
  }

  const query = `
    UPDATE categories
    SET categories_name = $1
    WHERE id = $2
    RETURNING *;
  `;

  try {
    const result = await req.client.query(query, [categories_name, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Category not found" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error("Error updating category:", error.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  const query = "DELETE FROM categories WHERE id = $1 RETURNING *;";

  try {
    const result = await req.client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Category not found" });
    }

    res.status(204).send(); // 204 = No Content
  } catch (error) {
    console.error("Error deleting category:", error.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;
