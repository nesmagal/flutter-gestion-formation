
const {setGlobalOptions} = require("firebase-functions");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

setGlobalOptions({ maxInstances: 10 });

const functions = require("firebase-functions");
const fetch = require("node-fetch");

exports.chatbot = functions.https.onRequest(async (req, res) => {
  try {
    const message = req.body.message;

    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent?key=${functions.config().gemini.key}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contents: [
            { parts: [{ text: message }] }
          ]
        }),
      }
    );

    const data = await response.json();
    let reply = "Erreur";
        if (data.candidates && data.candidates.length > 0) {
        const first = data.candidates[0];
        if (first.content && first.content.parts && first.content.parts.length > 0) {
            reply = first.content.parts[0].text || "Erreur";
        }
    }


    res.json({ reply });
  } catch (e) {
    res.status(500).json({ error: e.toString() });
  }
});

