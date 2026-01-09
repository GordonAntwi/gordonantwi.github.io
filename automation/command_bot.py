print("Command Bot Ready! Type a task (or 'exit' to quit).")

while True:
    user_input = input("You: ")

    if user_input.lower() == "exit":
        print("Goodbye, Gordon!")
        break

    try:
        print(f"Processing your request: {user_input}")
        # Here you’ll add automation logic soon
    except Exception as e:
        print(f"Error: {e}")


