#Task 3: Fault-tolerant handling of movie returns (try-except-finally)

from typing import Any
# Module-level constants
DEFAULT_RETURN_INDEX_BASE = 10.0  # base for the turnover index


def calculate_overdue_fine(
    movie_title: str,
    days_overdue: Any,
    fine_rate: float
) -> tuple[float, float] | None:
    """
    Calculates the overdue fine and the turnover index, safely handling
    invalid-input errors.

    Errors handled by this function:
        - TypeError: days_overdue is of a type that cannot be
          converted to float (e.g. a list).
        - ValueError: days_overdue is a string that is not a
          valid number (e.g. "пять").
        - ZeroDivisionError: days_overdue equals 0,
          causing a division by zero when computing the index.

    Args:
        movie_title (str): The movie title (used in the log/error messages).
        days_overdue (Any): Raw data for the number of overdue days — the type is not
            guaranteed in advance (may arrive as a string, list, etc.).
        fine_rate (float): The fine rate per overdue day, in dollars.

    Returns:
        tuple[float, float] | None:
            A tuple (total_fine, return_index) on success, or None if a
            handled error occurred.
    """
    try:
        # float(days_overdue) — the point where exceptions may occur:
        # ValueError (non-numeric string) or TypeError (list, None, etc.)
        numeric_days = float(days_overdue)

        total_fine = numeric_days * fine_rate

        # Division by numeric_days — this may raise ZeroDivisionError
        return_index = DEFAULT_RETURN_INDEX_BASE / numeric_days

        total_fine = round(total_fine, 2)
        return_index = round(return_index, 2)

        print(f"Фильм: '{movie_title}' | Итоговый штраф: {total_fine}$ | Индекс: {return_index}")
        return total_fine, return_index

    except TypeError as e:
        # "as e" captures the exception object so its message can be printed
        print(f"[ОШИБКА ТИПА] Некорректный тип данных для '{movie_title}': {e}")
        return None

    except ValueError as e:
        print(f"[ОШИБКА ЗНАЧЕНИЯ] Невозможно преобразовать дни в число для '{movie_title}': {e}")
        return None

    except ZeroDivisionError as e:
        print(f"[ОШИБКА ДЕЛЕНИЯ НА НОЛЬ] Возврат без просрочки для '{movie_title}': {e}")
        return None

    finally:
        # finally always runs: both on success and on any of the three excepts
        print("--- Проверка транзакции возврата завершена ---")


if __name__ == "__main__":
    print("=== ПРОВЕРКА ВОЗВРАТОВ ===")

    calculate_overdue_fine("Matrix", 5, 1.5)
    calculate_overdue_fine("Inception", "пять", 2.0)
    calculate_overdue_fine("Avatar", 0, 2.5)
    calculate_overdue_fine("Interstellar", [3, ], 3.0)
