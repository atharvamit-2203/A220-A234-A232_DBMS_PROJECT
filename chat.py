import mysql.connector

# Database Connection
try:
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='0809202327',
        database='Hospital'
    )
    cursor = connection.cursor()
    print("Database connected successfully!")
except Exception as e:
    print("Error connecting to database:", e)

def bookAppointment():
    name = input("Please enter your name: ").capitalize()
    location = input("Enter your location : ").capitalize()

    try:
        cursor.execute("SELECT name FROM hospital WHERE location = %s", (location,))
        hospitals = cursor.fetchall()

        if not hospitals:
            print(f"Sorry. We Couldn't found hospitals in {location}. Please try again.")
            return

        print("Here are the available hospitals:")
        for index, hospital in enumerate(hospitals, start=1):
            print(f"{index}. {hospital[0]}")

        hospital_choice = int(input("Select a hospital by entering the corresponding number: "))
        hospital_name = hospitals[hospital_choice - 1][0]

        specialization = input("Which specialization do you want to consult? ").capitalize()

        cursor.execute(
            "SELECT doctor_id, full_name FROM doctor WHERE specialization = %s AND hospital_name = %s",
            (specialization, hospital_name)
        )
        doctors = cursor.fetchall()

        if not doctors:
            print(f"No {specialization} doctors available at {hospital_name}. Try again.")
            return

        print("Here are the available doctors:")
        for doc in doctors:
            print(f"Doctor ID: {doc[0]}, Name: {doc[1]}")

        doctor_id = input("Please select a doctor by entering their Doctor ID: ")

        time = input("What time would you prefer for the appointment? ")

        cursor.execute(
            "INSERT INTO patients (name, doctor_id, hospital_name, location, time) VALUES (%s, %s, %s, %s, %s)",
            (name, doctor_id, hospital_name, location, time)
        )
        connection.commit()
        print(f"Appointment booked successfully for {name} with {specialization} Doctor (ID {doctor_id}) at {hospital_name}, {location} at {time}.")

    except Exception as e:
        print("Failed to book appointment.")
        print("Error:", e)

def viewAppointments():
    try:
        cursor.execute("SELECT * FROM patients")
        results = cursor.fetchall()
        if not results:
            print("No appointments found.")
        else:
            print("Here are the current appointments:")
            for row in results:
                print(row)
    except Exception as e:
        print("Error:", e)

def execute():
    choice = input("Welcome! Do you want to book an appointment or view existing appointments? ").lower()

    if "book" in choice:
        bookAppointment()
    elif "view" in choice:
        viewAppointments()
    else:
        print("Invalid choice. Please try again.")

if __name__ == "__main__":
    execute()
    cursor.close()
    connection.close()
