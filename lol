from flask import Flask, jsonify
import sqlite3

app = Flask(__name__)

# Загрузка данных из unclear.json
unclear_data = {
    "filename": "translate.db",
    "subjects": [
        "pixie",
        "teacher"
    ],
    "difficulty": 5
}

# Функция для получения данных из базы данных
def fetch_words():
    filename = unclear_data["filename"]
    subjects = unclear_data["subjects"]
    difficulty = unclear_data["difficulty"]

    conn = sqlite3.connect(filename)
    c = conn.cursor()

    words = {}

    for subject in subjects:
        c.execute("SELECT word, means FROM Talks WHERE who_said=? AND understanding<=?", (subject, difficulty))
        words[subject] = dict(c.fetchall())

    conn.close()

    return words

@app.route('/words')
def get_words():
    words = fetch_words()
    return jsonify(words)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8000)
