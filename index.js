const dialogflow = require("@google-cloud/dialogflow");
const uuid = require("uuid");
require("dotenv").config();
const trainingPhrases = require("./trainingPhrases");

async function addTrainingPhrasesToIntent(projectId, intentId, newPhrases) {
  const intentsClient = new dialogflow.IntentsClient({
    keyFilename: process.env.GOOGLE_APPLICATION_CREDENTIALS,
  });

  const intentPath = intentsClient.projectAgentIntentPath(projectId, intentId);

  const [intent] = await intentsClient.getIntent({
    name: intentPath,
    intentView: "INTENT_VIEW_FULL",
  });

  // console.log(
  //   "Existing Training Phrases:",
  //   intent.trainingPhrases?.map((tp) => tp.parts.map((p) => p.text).join(""))
  // );

  const existingTrainingPhrases = intent.trainingPhrases || [];
  const updatedTrainingPhrases = [...existingTrainingPhrases];

  newPhrases.forEach((phrase) => {
    const isDuplicate = updatedTrainingPhrases.some(
      (tp) => tp.parts && tp.parts.map((part) => part.text).join("") === phrase
    );
    if (!isDuplicate) {
      updatedTrainingPhrases.push({
        parts: [{ text: phrase }],
      });
    }
  });

  // console.log(
  //   "Updated Training Phrases:",
  //   updatedTrainingPhrases.map((tp) => tp.parts.map((p) => p.text).join(""))
  // );

  const updatedIntent = {
    name: intent.name,
    trainingPhrases: updatedTrainingPhrases,
  };

  const updateMask = { paths: ["training_phrases"] };

  try {
    await intentsClient.updateIntent({ intent: updatedIntent, updateMask });
    console.log(`Updated intent: ${intent.displayName}`);
  } catch (err) {
    console.error("Error updating intent:", err.message);
  }
}

const projectId = "ivytravel-saf9";
const intentId = "6d8689ef-4ff4-4c2a-9275-4699adfcdf43";
const newPhrases = trainingPhrases.qadata;

addTrainingPhrasesToIntent(projectId, intentId, newPhrases).catch((err) => {
  console.error("Error:", err);
});
