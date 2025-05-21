const express = require("express");
const router = express.Router();

router.post("/", async (req, res) => {
  const { name, place_id } = req.body;

  if (!name || name.trim() === "") {
    return res.status(400).json({ error: "Name is required." });
  }
  if (!place_id || isNaN(place_id)) {
    return res.status(400).json({ error: "place_id must be a valid integer." });
  }

  try {
    // ตรวจสอบว่า place_id มีอยู่จริงในตาราง places หรือไม่
    const checkPlaceQuery = "SELECT id FROM places WHERE id = $1";
    const placeResult = await req.client.query(checkPlaceQuery, [place_id]);

    if (placeResult.rows.length === 0) {
      return res.status(400).json({ error: "Invalid place_id. Place does not exist." });
    }

    const query = `
      INSERT INTO tourist_destinations (name, place_id)
      VALUES ($1, $2)
      RETURNING *;
    `;
    const result = await req.client.query(query, [name, parseInt(place_id, 10)]);
    
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating tourist destination:", err.message);
    res.status(500).json({ error: "Internal Server Error." });
  }
});

router.get("/", async (req, res) => {
  const query = `
    SELECT 
      td.id AS tourist_id, 
      td.name AS tourist_name, 
      td.place_id, 
      td.created_at, 
      p.name AS place_name,
      p.description, 
      p.admission_fee, 
      p.address, 
      p.contact_link, 
      p.opening_hours,
      COALESCE(json_agg(json_build_object('image_link', pi.image_link, 'image_detail', pi.image_detail)) 
        FILTER (WHERE pi.image_link IS NOT NULL), '[]') AS images
    FROM tourist_destinations td
    LEFT JOIN places p ON td.place_id = p.id
    LEFT JOIN place_images pi ON p.id = pi.place_id  
    GROUP BY td.id, p.id;
  `;

  try {
    const result = await req.client.query(query);
    res.status(200).json(result.rows);
  } catch (err) {
    console.error("Error fetching tourist destinations:", err.message);
    res.status(500).json({ error: "Internal Server Error." });
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  const query = `
    SELECT 
      td.id AS tourist_id, 
      td.name AS tourist_name, 
      td.place_id, 
      td.created_at, 
      p.name AS place_name,
      p.description, 
      p.admission_fee, 
      p.address, 
      p.contact_link, 
      p.opening_hours, 
      p.image_link, 
      p.image_detail 
    FROM tourist_destinations td
    LEFT JOIN places p ON td.place_id = p.id
    WHERE td.id = $1;
  `;

  try {
    const result = await req.client.query(query, [id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Tourist destination not found." });
    }
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error("Error fetching tourist destination:", err.message);
    res.status(500).json({ error: "Internal Server Error." });
  }
});

router.patch("/:id", async (req, res) => {
  const { id } = req.params;
  const { name, place_id } = req.body;

  console.log("📥 Received update request:", req.body); // ✅ ตรวจสอบค่าที่ Frontend ส่งมา

  try {
    if (!place_id) {
      console.warn("⚠️ No place_id provided, using existing value");
    }

    const query = `
      UPDATE tourist_destinations
      SET name = COALESCE($1, name),
          place_id = COALESCE($2, place_id)
      WHERE id = $3
      RETURNING *;
    `;

    const result = await req.client.query(query, [name, place_id, id]);

    console.log("✅ Updated successfully:", result.rows[0]); // ✅ ดูว่ามันอัปเดตจริงไหม

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Tourist destination not found." });
    }
    
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error("❌ Error updating tourist destination:", err.message);
    res.status(500).json({ error: "Internal Server Error." });
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    // ลบข้อมูลที่เกี่ยวข้องใน images ก่อน
    const deleteImagesQuery = "DELETE FROM place_images WHERE place_id IN (SELECT place_id FROM tourist_destinations WHERE id = $1)";
    await req.client.query(deleteImagesQuery, [id]);

    const query = `
      DELETE FROM tourist_destinations
      WHERE id = $1
      RETURNING *;
    `;

    const result = await req.client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Tourist destination not found." });
    }
    res.status(204).send();
  } catch (err) {
    console.error("Error deleting tourist destination:", err.message);
    res.status(500).json({ error: "Internal Server Error." });
  }
});

module.exports = router;
