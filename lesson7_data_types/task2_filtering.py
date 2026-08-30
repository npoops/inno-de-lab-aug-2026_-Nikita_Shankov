# Задача 2: Фильтрация транзакций платежного шлюза
# Список транзакций, полученных от платежного шлюза

raw_transactions = ["SUCCESS:100", "FAILED:50", "SUCCESS:-10",
                    "SUCCESS:0", "SUCCESS:250", "ERROR:200"]
# Filter transactions using a single List Comprehension expression:
# Keep only transactions with "SUCCESS" status
# Extract the numeric amount from the string (part after ":")
# Exclude anomalous transactions where the amount is zero or negative
# сonvert valid amounts to integer type (int)
cleaned_transactions = [
    int(t.split(":")[1])
    for t in raw_transactions
    if t.split(":")[0] == "SUCCESS" and int(t.split(":")[1]) > 0
]

print(f"Очищенные транзакции: {cleaned_transactions}")