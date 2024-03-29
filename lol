import sqlite3
import csv

# Функция для чтения данных из базы данных
def read_from_database(database_file):
    conn = sqlite3.connect(database_file)
    c = conn.cursor()

    # Получаем данные о мирах
    c.execute("SELECT id, name, danger_id FROM Worlds")
    worlds_data = c.fetchall()

    # Получаем данные об опасностях
    c.execute("SELECT id, danger, character, level FROM Dangers")
    dangers_data = c.fetchall()

    conn.close()
    return worlds_data, dangers_data

# Функция для записи данных в CSV файл
def write_to_csv(filtered_worlds, filename):
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=',')
        writer.writerow(['no', 'world', 'danger', 'character'])
        for row in filtered_worlds:
            writer.writerow(row)

# Функция для фильтрации данных
def filter_worlds(worlds_data, dangers_data, levels, word):
    filtered_worlds = []
    for world in worlds_data:
        world_id, world_name, danger_id = world
        for danger in dangers_data:
            danger_id_db, danger_name, character, danger_level = danger
            if danger_id_db == danger_id and danger_level in levels:
                if word.lower() in world_name.lower():
                    filtered_worlds.append([world_id, world_name, danger_name, character])
                    break
    return filtered_worlds

# Основная часть программы
database_file = input().strip()
levels = input().strip().split()
word = input().strip()

worlds_data, dangers_data = read_from_database(database_file)
filtered_worlds = filter_worlds(worlds_data, dangers_data, levels, word)
write_to_csv(filtered_worlds, 'snakehounds.csv')
