// scripts/chatbot.js
document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("chatForm");
  const chatBox = document.getElementById("chatBox");
  const input = document.getElementById("userInput");

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const message = input.value.trim();
    if (!message) return;

    // Show user message in chat
    chatBox.innerHTML += `<p><strong>You:</strong> ${message}</p>`;
    input.value = "";

    // Send to Formspree (replace YOUR_FORM_ID with your real one)
    try {
      const response = await fetch("https://formspree.io/f/mblzeovd", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message })
      });

      if (response.ok) {
        chatBox.innerHTML += `<p><em>✅ Message sent successfully!</em></p>`;
      } else {
        chatBox.innerHTML += `<p><em>⚠️ Error sending message.</em></p>`;
      }
    } catch (error) {
      chatBox.innerHTML += `<p><em>❌ Network error.</em></p>`;
    }

    // Scroll to bottom automatically
    chatBox.scrollTop = chatBox.scrollHeight;
  });
});


