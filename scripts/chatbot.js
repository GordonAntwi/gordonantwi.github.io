// Simple Chatbot Script with Email Support via Formspree

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("chatForm");
  const input = document.getElementById("userInput");
  const chatBox = document.getElementById("chatBox");

  if (!form || !input || !chatBox) {
    console.error("Chatbot elements not found. Make sure #chatForm, #userInput, and #chatBox exist.");
    return;
  }

  form.addEventListener("submit", function (e) {
    e.preventDefault();
    const userMessage = input.value.trim();
    if (!userMessage) return;

    // Display user message in chat box
    const userBubble = document.createElement("div");
    userBubble.className = "user-message";
    userBubble.textContent = userMessage;
    chatBox.appendChild(userBubble);

    input.value = "";

    // Send message to Formspree
    fetch("https://formspree.io/f/mblzeovd", {
      method: "POST",
      headers: {
        "Accept": "application/json"
      },
      body: new FormData(Object.assign(document.createElement("form"), {
        elements: [
          { name: "message", value: userMessage }
        ]
      }))
    })
      .then(response => {
        const botReply = document.createElement("div");
        botReply.className = "bot-message";
        if (response.ok) {
          botReply.textContent = "✅ Your message was sent to my email!";
        } else {
          botReply.textContent = "⚠️ Sorry, I couldn’t send your message.";
        }
        chatBox.appendChild(botReply);
        chatBox.scrollTop = chatBox.scrollHeight;
      })
      .catch(error => {
        const botReply = document.createElement("div");
        botReply.className = "bot-message";
        botReply.textContent = "❌ Error sending your message. Try again later.";
        chatBox.appendChild(botReply);
        chatBox.scrollTop = chatBox.scrollHeight;
        console.error("Error:", error);
      });
  });
});
