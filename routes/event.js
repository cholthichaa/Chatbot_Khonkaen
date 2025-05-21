const express = require("express");
const router = express.Router();

// router.post("/", async (req, res) => {
//   console.log("📩 Received data:", req.body);

//   try {
//     let {
//       event_name,
//       description,
//       activity_time,
//       opening_hours,
//       event_month,
//       address,
//       image_link,
//       image_detail,
//     } = req.body;

//     activity_time = activity_time && activity_time.trim() !== "" ? activity_time : null;
//     opening_hours = opening_hours && opening_hours.trim() !== "" ? opening_hours : null;
//     event_month = event_month && event_month.trim() !== "" ? event_month : null;
//     address = address && address.trim() !== "" ? address : null;
//     image_link = image_link && image_link.trim() !== "" ? image_link : null;
//     image_detail =
//       image_detail && image_detail.trim() !== "" ? image_detail : null;

//     if (!event_name || event_name.trim() === "") {
//       return res.status(400).json({ error: "Event name is required" });
//     }

//     const query = `
//       INSERT INTO event (event_name, description, activity_time, opening_hours, event_month, address, image_link, image_detail)
//       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
//       RETURNING *;
//     `;

//     const result = await req.client.query(query, [
//       event_name,
//       description,
//       activity_time,
//       opening_hours,
//       event_month,
//       address,
//       image_link,
//       image_detail,
//     ]);

//     console.log("✅ Event created:", result.rows[0]);
//     res.status(201).json(result.rows[0]);
//   } catch (err) {
//     console.error("❌ Error creating event:", err.stack);
//     res.status(500).json({ error: err.message || "Internal Server Error" });
//   }
// });

router.post("/", async (req, res) => {
  console.log("📩 Received data:", req.body);

  try {
    const events = Array.isArray(req.body) ? req.body : [req.body]; // รองรับทั้ง 1 หรือหลายตัว
    if (events.length === 0) {
      return res.status(400).json({ error: "No event data provided" });
    }

    const values = [];
    const placeholders = [];

    events.forEach((event, index) => {
      const {
        event_name,
        description,
        activity_time,
        opening_hours,
        event_month,
        address,
        image_link,
        image_detail,
      } = event;

      if (!event_name || event_name.trim() === "") {
        return res.status(400).json({ error: "Event name is required for all events" });
      }

      values.push(
        event_name,
        description || null,
        activity_time || null,
        opening_hours || null,
        event_month || null,
        address || null,
        image_link || null,
        image_detail || null
      );

      const startIndex = index * 8 + 1;
      placeholders.push(`($${startIndex}, $${startIndex + 1}, $${startIndex + 2}, $${startIndex + 3}, $${startIndex + 4}, $${startIndex + 5}, $${startIndex + 6}, $${startIndex + 7})`);
    });

    const query = `
      INSERT INTO event (event_name, description, activity_time, opening_hours, event_month, address, image_link, image_detail)
      VALUES ${placeholders.join(", ")}
      RETURNING *;
    `;

    const result = await req.client.query(query, values);
    console.log("✅ Events created:", result.rows);
    res.status(201).json(result.rows);
  } catch (err) {
    console.error("❌ Error creating events:", err.stack);
    res.status(500).json({ error: err.message || "Internal Server Error" });
  }
});


router.get("/", async (req, res) => {
  try {
    const query = "SELECT * FROM event;";
    const result = await req.client.query(query);
    res.json(result.rows);
  } catch (err) {
    console.error("Error fetching event", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const query = "SELECT * FROM event WHERE id = $1;";
    const result = await req.client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Event not found" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error fetching event", err.stack);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.patch("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const {
      event_name,
      description,
      activity_time ,
      opening_hours ,
      address,
      event_month,
      image_link,
      image_detail,
    } = req.body;

    const existingEvent = await req.client.query(
      "SELECT * FROM event WHERE id = $1;",
      [id]
    );
    if (existingEvent.rows.length === 0) {
      return res.status(404).json({ error: "Event not found" });
    }

    const updates = {
      event_name: event_name || existingEvent.rows[0].event_name,
      description: description || existingEvent.rows[0].description,
      activity_time: activity_time || existingEvent.rows[0].activity_time,
      opening_hours: opening_hours || existingEvent.rows[0].opening_hours,
      address: address || existingEvent.rows[0].address,
      event_month: event_month || existingEvent.rows[0].event_month,
      image_link: image_link || existingEvent.rows[0].image_link,
      image_detail: image_detail || existingEvent.rows[0].image_detail,
    };

    const query = `
      UPDATE event
      SET event_name = $1, description = $2, activity_time = $3, opening_hours = $4, address = $5, event_month = $6, image_link = $7, image_detail = $8
      WHERE id = $9
      RETURNING *;
    `;

    const result = await req.client.query(query, [
      updates.event_name,
      updates.description,
      updates.activity_time,
      updates.opening_hours,
      updates.address,
      updates.event_month,
      updates.image_link,
      updates.image_detail,
      id,
    ]);

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error updating event:", err);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    console.log("🗑️ Attempting to delete event with ID:", id);

    if (!id) {
      return res.status(400).json({ error: "Event ID is required" });
    }

    const query = "DELETE FROM event WHERE id = $1 RETURNING *;";
    const result = await req.client.query(query, [id]);

    if (result.rows.length === 0) {
      console.warn("⚠️ Event not found, ID:", id);
      return res.status(404).json({ error: "Event not found" });
    }

    console.log("✅ Event deleted:", result.rows[0]);
    res.status(200).json({ message: "Event deleted successfully" });
  } catch (err) {
    console.error("❌ Error deleting event:", err.stack);
    res.status(500).json({ error: err.message || "Internal Server Error" });
  }
});

module.exports = router;
