import json
import requests

def fetch_data(host, port):
    url = f"http://{host}:{port}"
    response = requests.get(url)
    data = response.json()
    return data

def find_solace_books(data, words, max_length):
    solace_books = []
    for title, description in data.items():
        if any(word in title for word in words) and len(title) <= max_length:
            unique_plots = set(description.split(", "))
            if len(unique_plots) <= len(title.split()):
                solace_books.append(title)
    return sorted(solace_books)

def main():
    # Чтение данных из файла solace.json
    with open("solace.json", "r") as file:
        solace_data = json.load(file)

    # Получение данных с сервера
    server_data = fetch_data(solace_data["host"], solace_data["port"])

    # Поиск утешительных книг
    solace_books = find_solace_books(server_data, solace_data["words"], solace_data["long"])

    # Вывод результатов
    for book in solace_books:
        print(book)

if __name__ == "__main__":
    main()
