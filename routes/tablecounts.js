const express = require("express");
const router = express.Router();

const updateTableCounts = async (client, counts) => {
  try {
    console.log("Updating table counts...");
    for (const [tableName, count] of Object.entries(counts)) {
      const query = `
        INSERT INTO table_counts (table_name, row_count, updated_at)
        VALUES ($1, $2, CURRENT_TIMESTAMP)
        ON CONFLICT (table_name)
        DO UPDATE SET row_count = $2, updated_at = CURRENT_TIMESTAMP;
      `;
      await client.query(query, [tableName, count]);
    }
  } catch (err) {
    console.error("Error updating table counts:", err.stack);
    throw err;
  }
};

const getTableCounts = async (client) => {
  try {
    const queries = [
      { tableName: "users", query: "SELECT COUNT(*) FROM users" },
      { tableName: "web_answer", query: "SELECT COUNT(*) FROM web_answer" },
      {
        tableName: "conversations",
        query: "SELECT COUNT(*) FROM conversations",
      },
      { tableName: "places", query: "SELECT COUNT(*) FROM places" },
    ];

    const counts = {};
    for (const { tableName, query } of queries) {
      const res = await client.query(query);
      console.log(`Query result for ${tableName}:`, res.rows); // เพิ่ม log
      counts[tableName] = parseInt(res.rows[0].count, 10); // เก็บจำนวนแถวในแต่ละตาราง
    }

    console.log("Final counts before calling update:", counts); // เพิ่ม log

    // เรียกใช้ updateTableCounts หลังจากได้ข้อมูลแล้ว
    await updateTableCounts(client, counts);

    return counts;
  } catch (err) {
    console.error("Error fetching table counts", err.stack);
    throw err;
  }
};

router.get("/counts", async (req, res) => {
  const client = req.client;
  try {
    const counts = await getTableCounts(client);
    res.json(counts);
  } catch (err) {
    res.status(500).json({ error: "Error fetching table counts" });
  }
});

module.exports = router;


module.exports = router;
