#Task 2: Analytics performance monitoring (decorators & lambda)


import time
import functools
from typing import Callable, Any

# Module-level constants
PERFORMANCE_LOG_PREFIX = "[PERF_LOG]"  # log line prefix
TIME_DECIMALS = 8  # decimals for elapsed time


def performance_logger(func: Callable[..., Any]) -> Callable[..., Any]:
    """A decorator that measures the execution time of the wrapped function.

    Args:
        func (Callable[..., Any]): The original function to be wrapped.

    Returns:
        Callable[..., Any]: The wrapper function that calls func, measures elapsed time,
            and returns the original function's result.
    """
    # functools.wraps preserves the original function's __name__ and docstring on wrapper
    @functools.wraps(func)
    def wrapper(*args: Any, **kwargs: Any) -> Any:
        # *args  — collects all positional arguments into a tuple
        # **kwargs — collects all keyword arguments into a dict
        start_time = time.perf_counter()  # start timestamp

        # Run the original function with whatever arguments were passed to wrapper
        result = func(*args, **kwargs)

        elapsed = round(time.perf_counter() - start_time, TIME_DECIMALS)
        print(f"{PERFORMANCE_LOG_PREFIX} Функция '{func.__name__}' выполнена за {elapsed} сек.")

        return result
    return wrapper


@performance_logger
def get_sorted_report(genre_data: list[dict[str, str | float]]) -> list[dict[str, str | float]]:
    """Sorts a list of genre revenue records by the total_sales field, descending.

    Args:
        genre_data (list[dict[str, str | float]]):  A list of dictionaries shaped like {"category": str, "total_sales": float}.

    Returns:
        list[dict[str, str | float]]: The list sorted in descending order of total_sales.
    """

    # lambda item: item["total_sales"] — an anonymous key function for sorted():
    # for each dict item it returns the value used for sorting.
    # reverse=True flips the order to "descending".
    return sorted(genre_data, key=lambda item: item["total_sales"], reverse=True)


if __name__ == "__main__":
    test_sets = [
        [
            {"category": "Action", "total_sales": 4311.85},
            {"category": "Animation", "total_sales": 4656.30},
            {"category": "Children", "total_sales": 3655.55},
        ],
        [
            {"category": "Classics", "total_sales": 1200.10},
            {"category": "Comedy", "total_sales": 4000.00},
            {"category": "Documentary", "total_sales": 4000.00},
        ],
        [
            {"category": "Drama", "total_sales": 500.00},
        ],
    ]

    print("=== ТЕСТИРОВАНИЕ ПРОИЗВОДИТЕЛЬНОСТИ ===")
    for i, data_set in enumerate(test_sets, start=1):
        print(f"--- ТЕСТ {i} ---")
        report = get_sorted_report(data_set)
        print("Топ категорий по выручке:")
        for rank, entry in enumerate(report, start=1):
            print(f"{rank}. {entry['category']}: {entry['total_sales']}")
        print()
