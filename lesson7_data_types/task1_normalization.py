# Задача 1: Нормализация и сборка записи пользователя
# Задание: Разработать скрипт, который принимает на вход неочищенную строку с данными пользователя

# Initial raw string
raw_user_record = " 10827 ; aLeXanDer_vLaDimiRov ; mInSk ; ACTIVE "

# Split the string by semicolon
split_data = raw_user_record.split(";")

# Clean each element from extra spaces
uid_raw = split_data[0].strip()
name_raw = split_data[1].strip()
city_raw = split_data[2].strip()
status_raw = split_data[3].strip()

# Add prefix using f-string
uid = f"UID-{uid_raw}"

# Replace underscore with space and capitalize each word
name = name_raw.replace("_", " ").title()

# Convert city to uppercase
city = city_raw.upper()

# Convert status to lowercase
status = status_raw.lower()

# Join everything back into one string
normalized_list = [uid, name, city, status]
result = " | ".join(normalized_list)
print(f"Нормализованная запись: {result}")