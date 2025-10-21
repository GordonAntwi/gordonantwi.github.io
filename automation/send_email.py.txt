import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# --- CONFIGURATION ---
SENDER_EMAIL = os.getenv("antwivamax@gmail.com") 
SENDER_PASSWORD = os.getenv("kfwr kksk rxev upeh")
RECEIVER_EMAIL = os.getenv("antwivamax@gmail.com")

def send_email(subject, message):
    try:
        msg = MIMEMultipart()
        msg["From"] = SENDER_EMAIL
        msg["To"] = RECEIVER_EMAIL
        msg["Subject"] = subject

        msg.attach(MIMEText(message, "plain"))

        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(SENDER_EMAIL, SENDER_PASSWORD)
            server.send_message(msg)

        print("Email sent successfully!")
    except Exception as e:
        print(f"❌ Failed to send email: {e}")

if __name__ == "__main__":
    subject = input("Enter the email subject: ")
    message = input("Enter your message: ")
    send_email(subject, message)
