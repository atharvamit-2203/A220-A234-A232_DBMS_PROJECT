from flask import Flask, request, render_template, redirect
import mysql.connector
import os

app = Flask(__name__, template_folder=os.path.abspath("."))

# Load database credentials from environment variables (Recommended)
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "0809202327")
DB_NAME = os.getenv("DB_NAME", "Hospital")

def get_db_connection():
    """Creates a new database connection for each request."""
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME
    )

@app.route('/')
def home():
    return render_template('hospital.html')  # Make sure hospital.html is in the same directory

@app.route('/submit', methods=['POST'])
def submit():
    """Handles doctor registration."""
    try:
        doctor_id = request.form['doctor_id']
        full_name = request.form['full_name']
        date_of_birth = request.form['date_of_birth']
        gender = request.form['gender']
        email = request.form['email']
        phone_number = request.form['phone_number']
        specialization = request.form['specialization']
        experience = request.form['experience']
        license_number = request.form['license_number']
        hospital_name = request.form['hospital_name']
        location = request.form['location']

        db = get_db_connection()
        cursor = db.cursor()

        sql = """
        INSERT INTO Doctor (doctor_id, full_name, date_of_birth, gender, email, phone_number, specialization, experience, license_number, hospital_name, location)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (doctor_id, full_name, date_of_birth, gender, email, phone_number, specialization, experience, license_number, hospital_name, location)

        cursor.execute(sql, values)
        db.commit()

        return redirect('/')

    except mysql.connector.Error as err:
        return f"Database Error: {err}"

    except Exception as e:
        return f"Unexpected Error: {e}"

    finally:
        if cursor:
            cursor.close()
        if db:
            db.close()

if __name__ == '__main__':
    app.run(debug=True)
