const express = require('express');
const router = express.Router();


router.get('/', async (req, res) => {
  try {
    const result = await req.client.query(`SELECT * FROM conversations`);
    res.status(200).json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
