import sys
import json

def transform_numbers(numbers, positive_divisor=4, odd_remainder=None):
    transformed_numbers = []
    for num in numbers:
        if num % 2 == 0 and num > 0:
            transformed_num = -1 * (num // positive_divisor)
        elif odd_remainder is not None and num % 2 != 0:
            transformed_num = num + (num % odd_remainder)
        else:
            transformed_num = num
        transformed_numbers.append(transformed_num)
    return transformed_numbers

def process_witchcraft(witchcraft_data, positive_divisor=4, odd_remainder=None):
    transformed_numbers = transform_numbers(witchcraft_data, positive_divisor, odd_remainder)
    negative_count = sum(1 for num in transformed_numbers if num < sum(transformed_numbers) / len(transformed_numbers))
    biggest = max(transformed_numbers)
    return {"witchcraft": witchcraft, "negative": negative_count, "biggest": biggest}

def main():
    # Парсим аргументы командной строки
    host = sys.argv[1]
    port = int(sys.argv[2])
    witchcraft_list = sys.argv[3:]

    # Парсим дополнительные опции
    positive_divisor = 4
    odd_remainder = None
    if "--positive" in witchcraft_list:
        positive_index = witchcraft_list.index("--positive")
        positive_divisor = int(witchcraft_list[positive_index + 1])
        del witchcraft_list[positive_index:positive_index+2]
    if "--odd" in witchcraft_list:
        odd_index = witchcraft_list.index("--odd")
        odd_remainder = int(witchcraft_list[odd_index + 1])
        del witchcraft_list[odd_index:odd_index+2]

    # Запрос к серверу
    server_data = {
        "scare": [152, 51, -66],
        "enchant": [70, -103, 131, 17, -30, 182, -111],
        "repair": [207, -38, -45, 172, 96],
        "create": [197, 156, -6, 16, 255, -284]
    }

    # Обработка данных с сервера
    result = []
    for witchcraft in witchcraft_list:
        if witchcraft in server_data:
            witchcraft_data = server_data[witchcraft]
            processed_data = process_witchcraft(witchcraft_data, positive_divisor, odd_remainder)
            result.append(processed_data)

    # Сортировка по видам колдовства
    result.sort(key=lambda x: x["witchcraft"])

    # Запись в файл
    with open("witchcraft.json", "w") as f:
        json.dump(result, f, indent=4)

if __name__ == "__main__":
    main()
