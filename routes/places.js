const express = require("express");
const router = express.Router();

// ฟังก์ชันอัปเดตจำนวนแถวในฐานข้อมูล
const updateTableCount = async (dbClient, tableName, rowCount) => {
  try {
    const query = `
      INSERT INTO table_counts (table_name, row_count)
      VALUES ($1, $2)
      ON CONFLICT (table_name) 
      DO UPDATE SET row_count = EXCLUDED.row_count, updated_at = CURRENT_TIMESTAMP;
    `;
    await dbClient.query(query, [tableName, rowCount]);
  } catch (err) {
    console.error(`Error updating row count for ${tableName}:`, err.stack);
  }
};

const getTableCounts = async (client) => {
  try {
    const tables = ["users", "web_answer", "conversations", "places"];
    for (const table of tables) {
      const res = await client.query(`SELECT COUNT(*) FROM ${table}`);
      const rowCount = parseInt(res.rows[0].count, 10);
      await updateTableCount(client, table, rowCount);
    }
  } catch (err) {
    console.error("Error fetching table counts", err.stack);
    throw err;
  }
};

// สร้างสถานที่ใหม่
router.post("/", async (req, res) => {
  try {
    const places = Array.isArray(req.body) ? req.body : [req.body];
    if (!places.length) {
      return res
        .status(400)
        .json({ error: "Invalid input: At least one place is required" });
    }

    const placeValues = places.map((p) => [
      p.name,
      p.description || null,
      p.admission_fee || null,
      p.address,
      p.contact_link || null,
      p.opening_hours || null,
      p.latitude || null,
      p.longitude || null,
    ]);

    const placeQuery = `
      INSERT INTO places (name, description, admission_fee, address, contact_link, opening_hours, latitude, longitude)
      VALUES ${placeValues
        .map(
          (_, i) =>
            `($${i * 8 + 1}, $${i * 8 + 2}, $${i * 8 + 3}, $${i * 8 + 4}, $${
              i * 8 + 5
            }, $${i * 8 + 6}, $${i * 8 + 7}, $${i * 8 + 8})`
        )
        .join(", ")}
      RETURNING id, name;
    `;

    const placeResult = await req.client.query(placeQuery, placeValues.flat());
    const insertedPlaces = placeResult.rows;

    // เพิ่มข้อมูลรูปภาพถ้ามี
    const imageValues = [];
    insertedPlaces.forEach((place, index) => {
      (places[index].images || []).forEach((img) => {
        imageValues.push([place.id, img.image_link, img.image_detail || null]);
      });
    });

    if (imageValues.length) {
      const imageQuery = `
        INSERT INTO place_images (place_id, image_link, image_detail)
        VALUES ${imageValues
          .map((_, i) => `($${i * 3 + 1}, $${i * 3 + 2}, $${i * 3 + 3})`)
          .join(", ")}
        RETURNING *;
      `;
      await req.client.query(imageQuery, imageValues.flat());
    }

    await getTableCounts(req.client);
    res
      .status(201)
      .json({ message: "Places added successfully", places: insertedPlaces });
  } catch (err) {
    console.error("Error creating places", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.get("/", async (req, res) => {
  const query = `
    SELECT places.*, json_agg(json_build_object('image_link', place_images.image_link, 'image_detail', place_images.image_detail)) AS images
    FROM places
    LEFT JOIN place_images ON places.id = place_images.place_id
    GROUP BY places.id;
  `;

  try {
    const result = await req.client.query(query);
    res.json(result.rows);
  } catch (err) {
    console.error("Error fetching places", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const placeResult = await req.client.query(
      "SELECT * FROM places WHERE id = $1;",
      [id]
    );
    if (!placeResult.rows.length)
      return res.status(404).json({ error: "Place not found" });
    const imageResult = await req.client.query(
      "SELECT * FROM place_images WHERE place_id = $1;",
      [id]
    );
    res.json({ ...placeResult.rows[0], images: imageResult.rows });
  } catch (err) {
    console.error("Error fetching place", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.patch("/:id/images", async (req, res) => {
  const { id } = req.params;
  const { images } = req.body;

  if (!images || !images.length) {
    return res.status(400).json({ error: "No images provided for update" });
  }

  try {
    await req.client.query("DELETE FROM place_images WHERE place_id = $1;", [id]);

    // Insert new images
    const imageValues = images.map((img) => [
      id,
      img.image_link,
      img.image_detail || null,
    ]);

    const imageQuery = `
      INSERT INTO place_images (place_id, image_link, image_detail)
      VALUES ${imageValues
        .map((_, i) => `($${i * 3 + 1}, $${i * 3 + 2}, $${i * 3 + 3})`)
        .join(", ")}
      RETURNING *;
    `;
    
    const imageResult = await req.client.query(imageQuery, imageValues.flat());

    // Respond with the updated images
    res.json(imageResult.rows);
  } catch (err) {
    console.error("Error updating images", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.patch("/:id", async (req, res) => {
  const { id } = req.params;
  const {
    name,
    description,
    admission_fee,
    address,
    contact_link,
    opening_hours,
    latitude,
    longitude,
    images,
  } = req.body;

  const updateValues = [];
  const setClauses = [];

  // Update the place information
  if (name !== undefined) {
    setClauses.push(`name = $${updateValues.length + 1}`);
    updateValues.push(name);
  }
  if (description !== undefined) {
    setClauses.push(`description = $${updateValues.length + 1}`);
    updateValues.push(description);
  }
  if (admission_fee !== undefined) {
    setClauses.push(`admission_fee = $${updateValues.length + 1}`);
    updateValues.push(admission_fee);
  }
  if (address !== undefined) {
    setClauses.push(`address = $${updateValues.length + 1}`);
    updateValues.push(address);
  }
  if (contact_link !== undefined) {
    setClauses.push(`contact_link = $${updateValues.length + 1}`);
    updateValues.push(contact_link);
  }
  if (opening_hours !== undefined) {
    setClauses.push(`opening_hours = $${updateValues.length + 1}`);
    updateValues.push(opening_hours);
  }
  if (latitude !== undefined) {
    setClauses.push(`latitude = $${updateValues.length + 1}`);
    updateValues.push(latitude);
  }
  if (longitude !== undefined) {
    setClauses.push(`longitude = $${updateValues.length + 1}`);
    updateValues.push(longitude);
  }

  // If no fields to update, return an error
  if (setClauses.length === 0) {
    return res.status(400).json({ error: "No valid fields to update" });
  }

  // Add WHERE clause for place ID
  const whereClause = `WHERE id = $${updateValues.length + 1}`;
  updateValues.push(id);

  // Update the place information in the database
  const updateQuery = `
    UPDATE places
    SET ${setClauses.join(", ")} ${whereClause}
    RETURNING *;
  `;
  try {
    const placeResult = await req.client.query(updateQuery, updateValues);
    if (!placeResult.rows.length) {
      return res.status(404).json({ error: "Place not found" });
    }

    // Update images if present in the body
    if (images && images.length) {
      // Delete existing images
      await req.client.query("DELETE FROM place_images WHERE place_id = $1;", [id]);

      // Insert new images
      const imageValues = images.map((img) => [
        id,
        img.image_link,
        img.image_detail || null,
      ]);
      const imageQuery = `
        INSERT INTO place_images (place_id, image_link, image_detail)
        VALUES ${imageValues
          .map((_, i) => `($${i * 3 + 1}, $${i * 3 + 2}, $${i * 3 + 3})`)
          .join(", ")}
        RETURNING *;
      `;
      await req.client.query(imageQuery, imageValues.flat());
    }

    // Send back the updated place
    res.json(placeResult.rows[0]);
  } catch (err) {
    console.error("Error updating place", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// router.patch("/", async (req, res) => {
//   const places = Array.isArray(req.body) ? req.body : [req.body];

//   if (!places.length) {
//     return res.status(400).json({ error: "Invalid input: At least one place is required" });
//   }

//   const updateQueries = [];
//   const updateValues = [];

//   places.forEach((place) => {
//     if (!place.id || typeof place.id !== "number") {
//       return res.status(400).json({ error: `Invalid or missing ID for place` });
//     }

//     let setClause = [];
//     let values = [];

//     if (place.latitude !== undefined) {
//       if (typeof place.latitude === "number") {
//         setClause.push(`latitude = $${values.length + 1}::double precision`);
//         values.push(place.latitude);
//       } else {
//         return res.status(400).json({ error: `Invalid latitude value for place ID ${place.id}` });
//       }
//     }

//     if (place.longitude !== undefined) {
//       if (typeof place.longitude === "number") {
//         setClause.push(`longitude = $${values.length + 1}::double precision`);
//         values.push(place.longitude);
//       } else {
//         return res.status(400).json({ error: `Invalid longitude value for place ID ${place.id}` });
//       }
//     }

//     if (setClause.length > 0) {
//       values.push(place.id);
//       const query = `UPDATE places SET ${setClause.join(", ")} WHERE id = $${values.length} RETURNING *;`;
//       updateQueries.push({ query, values });
//     }
//   });

//   if (updateQueries.length === 0) {
//     return res.status(400).json({ error: "No valid fields to update" });
//   }

//   try {
//     const results = await Promise.all(
//       updateQueries.map(({ query, values }) => req.client.query(query, values))
//     );

//     res.json({
//       message: "Places updated successfully",
//       results: results.map((result) => result.rows),
//     });
//   } catch (err) {
//     console.error("Error updating places", err.stack);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });


router.get("/:id/images", async (req, res) => {
  const { id } = req.params;
  try {
    const imageResult = await req.client.query(
      "SELECT * FROM place_images WHERE place_id = $1;",
      [id]
    );
    if (!imageResult.rows.length)
      return res.status(404).json({ error: "Images not found" });
    res.json(imageResult.rows);
  } catch (err) {
    console.error("Error fetching images", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const result = await req.client.query(
      "DELETE FROM places WHERE id = $1 RETURNING *;",
      [req.params.id]
    );
    if (!result.rows.length)
      return res.status(404).json({ error: "Place not found" });
    res.status(204).send();
  } catch (err) {
    console.error("Error deleting place", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


module.exports = router;
