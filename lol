import sqlite3
import csv

def fetch_data(database_file):
    conn = sqlite3.connect(database_file)
    c = conn.cursor()

    # Получение данных о мирах
    c.execute("SELECT id, name, danger_id FROM Worlds")
    worlds_data = c.fetchall()

    # Получение данных об опасностях
    c.execute("SELECT id, danger, character, level FROM Dangers")
    dangers_data = c.fetchall()

    conn.close()
    return worlds_data, dangers_data

def write_to_csv(filtered_worlds, filename):
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, delimiter=',')
        writer.writerow(['no', 'world', 'danger', 'character'])
        writer.writerows(filtered_worlds)

def filter_worlds(worlds_data, dangers_data, levels, word):
    filtered_worlds = []
    for world_id, world_name, danger_id in worlds_data:
        for danger_id_db, danger_name, character, danger_level in dangers_data:
            if danger_id_db == danger_id and danger_level in levels:
                if word.lower() in world_name.lower():
                    filtered_worlds.append([world_id, world_name, danger_name, character])
                    break
    return filtered_worlds

def main():
    database_file = input().strip()
    levels = input().strip().split()
    word = input().strip()

    worlds_data, dangers_data = fetch_data(database_file)
    filtered_worlds = filter_worlds(worlds_data, dangers_data, levels, word)
    write_to_csv(filtered_worlds, 'snakehounds.csv')

if __name__ == "__main__":
    main()

