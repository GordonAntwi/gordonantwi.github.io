async function sendMessage() {
    const inputField = document.getElementById('chat-input');
    const userQuery = inputField.value.trim();

    if (!userQuery) return;

    displayMessage(userQuery, 'user');
    inputField.value = "";

    showLoadingIndicator();

    // Step 1: Grab all visible website text
    const siteText = document.body.innerText.toLowerCase();

    // Step 2: Check if the query appears in the site content
    const found = siteText.includes(userQuery.toLowerCase());

    hideLoadingIndicator();

    if (found) {
        // Step 3A: If found on the site, reply instantly
        displayMessage("✅ I found information related to that on the site! Please scroll or check the relevant section for more details.", "assistant");
    } else {
        // Step 3B: If not found, send the message to your email
        try {
            await fetch("https://formspree.io/f/mblzeovd, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    message: userQuery,
                    email: "antwivamax@gmail.com"
                })
            });

            displayMessage("📩 That information isn’t currently available on the website. I’ve sent your question to Gordon for a direct follow-up.", "assistant");
        } catch (error) {
            console.error("Email send failed:", error);
            displayMessage("❌ Sorry, I couldn’t send your question right now. Please try again later.", "assistant");
        }
    }
}

