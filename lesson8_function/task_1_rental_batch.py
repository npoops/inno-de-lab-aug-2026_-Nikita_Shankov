#Task 1: Calculating the cost of bulk movie rental orders

# Module-level constants
# Written in UPPERCASE and never modified inside function
MAX_RENTAL_BATCH_LIMIT = 150.0  # auto-approval limit


def calculate_rental_batch(
    quantity: int,
    rental_rate: float,
    discount: float = 0.0
) -> tuple[float, bool]:
    """
    Calculates the total cost of a batch of rented discs, applying a discount.

    Args:
        quantity (int): Number of discs in the batch.
        rental_rate (float): Rental price per single disc, in dollars.
        discount (float, optional): Discount as a fraction (0.1 = 10%). Defaults to 0.0.

    Returns:
        tuple[float, bool]: A tuple of the final rounded sum and a flag showing whether
            the MAX_RENTAL_BATCH_LIMIT was exceeded.
    """
    # Calculate the final sum with the discount applied, rounded to 2 decimal places
    final_sum = round(quantity * rental_rate * (1 - discount), 2)

    # Compare the final sum with the limit constant -> get a bool
    is_limit_exceeded = final_sum > MAX_RENTAL_BATCH_LIMIT

    # Return a tuple of two values in a single return statement
    return final_sum, is_limit_exceeded


if __name__ == "__main__":
    print("=== ОТЧЕТ ПО ПАРТИЯМ АРЕНДЫ ===")

    # Вызов №1: позиционные аргументы (positional arguments)
    # Порядок важен: quantity, затем rental_rate
    sum_1, exceeded_1 = calculate_rental_batch(30, 2.99)
    print(f"Партия 1 (Academy Dinosaur): Сумма {sum_1}$. Превышение лимита: {exceeded_1}")

    # Вызов №2: именованные аргументы (keyword arguments)
    # Порядок не важен, т.к. аргументы передаются по имени
    sum_2, exceeded_2 = calculate_rental_batch(quantity=40, rental_rate=4.99, discount=0.10)
    print(f"Партия 2 (Affair Prejudice): Сумма {sum_2}$. Превышение лимита: {exceeded_2}")

    sum_3, exceeded_3 = calculate_rental_batch(10, 1.99)
    print(f"Партия 3 (Agent Truman): Сумма {sum_3}$. Превышение лимита: {exceeded_3}")

    sum_4, exceeded_4 = calculate_rental_batch(quantity=50, rental_rate=3.50, discount=0.20)
    print(f"Партия 4 (African Egg): Сумма {sum_4}$. Превышение лимита: {exceeded_4}")
