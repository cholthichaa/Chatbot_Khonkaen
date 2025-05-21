const express = require("express");
const { Client } = require("pg");
const cors = require("cors");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const webRouter = require("./routes/web_ans");
const placesRouter = require("./routes/places");
const flexmessageRouter = require("./routes/flexmessage");
const { handleWebhookRequest } = require("./webhook");
require("dotenv").config();
const usersRouter = require("./routes/users");
const conversationsRouter = require("./routes/conversations");
const tableCountsRouter = require("./routes/tablecounts");
const eventsRouter = require("./routes/event");

const app = express();

const lineConfig = {
  channelAccessToken:
    "gB3fJXlbvN1POdqcQnuVhOqCbmbuwsAL58VzpbLHgvlTZT0e9fhseI/ydqZ3VBK/4qOu0DtO1vKMXxN7tMOZ34uWdw2Vf3O0KbQEi1WWCCdIz88bBdcGtn9A+2TATloNMe3qYWQKr4xXbOY/Gh6AEQdB04t89/1O/w1cDnyilFU=",
  channelSecret: "95f66230911106142aac60f5f420976c",
};

app.use(
  cors({
    origin: "http://localhost:5173",
  })
);
app.use(morgan("dev"));
app.use(bodyParser.json());

const client = new Client({
  user: process.env.DB_USERNAME,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

client
  .connect()
  .then(() => {
    console.log("Connected to PostgreSQL");
    createTables();
  })
  .catch((err) => console.error("Error connecting to PostgreSQL", err.stack));

const createTables = async () => {
  const createUsersTable = `
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      line_id VARCHAR(255) UNIQUE NOT NULL,
      display_name VARCHAR(255),
      picture_url VARCHAR(255),
      status_message VARCHAR(255),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;

  const createPlacesTable = `
    CREATE TABLE IF NOT EXISTS places (
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        admission_fee TEXT,
        address TEXT,
        contact_link TEXT,
        opening_hours VARCHAR(255),
        latitude DOUBLE PRECISION,  
        longitude DOUBLE PRECISION, 
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;

  const createPlaceImagesTable = `
 CREATE TABLE IF NOT EXISTS place_images (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  place_id INT REFERENCES places(id) ON DELETE CASCADE,
  image_link TEXT NOT NULL,
  image_detail VARCHAR(255)
);
`;

  const createEventTable = `
      CREATE TABLE IF NOT EXISTS event (
      id SERIAL PRIMARY KEY,
      event_name VARCHAR(255) NOT NULL,
      description TEXT,
      event_month TEXT,
      activity_time TEXT,
      opening_hours VARCHAR(255),
      address TEXT,
      image_link TEXT,
      image_detail TEXT, 
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
  `;

  const createFlexTouristTable = `
  CREATE TABLE IF NOT EXISTS tourist_destinations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    place_id INTEGER NOT NULL,
    FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
`;

  const createWabAnswerTable = `
    CREATE TABLE IF NOT EXISTS web_answer (
      id SERIAL PRIMARY KEY,
      place_name VARCHAR(255),
      answer_text TEXT NOT NULL,
      intent_type VARCHAR(50) NOT NULL,
      image_link TEXT,
      image_detail VARCHAR(255),
      contact_link TEXT,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;

  const createConversationsTable = `
    CREATE TABLE IF NOT EXISTS conversations (
      id SERIAL PRIMARY KEY,
      answer_text TEXT,
      question_text TEXT NOT NULL,
      user_id INT NOT NULL,
      web_answer_id INT,
      place_id INT,
      event_id INT,
      source_type VARCHAR(50) NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id),
      FOREIGN KEY (place_id) REFERENCES places(id),
      FOREIGN KEY (web_answer_id) REFERENCES web_answer(id),
      FOREIGN KEY (event_id) REFERENCES event(id),
      CONSTRAINT unique_user_place UNIQUE (user_id, place_id,event_id)
    );
  `;

  const createDashboardTable = `
    CREATE TABLE IF NOT EXISTS table_counts (
      table_name VARCHAR(255) PRIMARY KEY,
      row_count INT,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;

  try {
    await client.query(createUsersTable);
    await client.query(createPlacesTable);
    await client.query(createPlaceImagesTable);
    await client.query(createEventTable);
    await client.query(createFlexTouristTable);
    await client.query(createWabAnswerTable);
    await client.query(createConversationsTable);
    await client.query(createDashboardTable);

    console.log("Tables are created or already exist.");
  } catch (err) {
    console.error("Error creating tables", err.stack);
  }
};

app.use((req, res, next) => {
  req.client = client;
  next();
});

app.post("/webhook", (req, res) => {
  handleWebhookRequest(req, res, client);
});
app.get("/api/data", (req, res) => {
  res.json({ message: "Hello from Node.js backend!" });
});
app.use("/places", placesRouter);
app.use("/flexmessage", flexmessageRouter);
app.use("/users", usersRouter);
app.use("/conversations", conversationsRouter);
app.use("/web", webRouter);
app.use("/api/tableCounts", tableCountsRouter);
app.use("/events", eventsRouter);

module.exports = app;
