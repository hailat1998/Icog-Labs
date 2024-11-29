
def quick_sort( arr: list, low: int, high: int) -> list:
    # Create a new list instead of modifying the original
    new_array = arr.copy()

    if low < high:
    # partition now returns a tuple of (array, pivot_index)
      partitioned_array, pivot_index = partition(new_array, low, high)

    # Recursively sort left part
      left_sorted = quick_sort(partitioned_array, low, pivot_index - 1)

    # Recursively sort right part
      result = quick_sort(left_sorted, pivot_index + 1, high)

      return result

    return new_array

def partition( arr: list, low: int, high: int) -> tuple:
        new_array = arr.copy()
        pivot = new_array[high]
        i = low - 1

        for j in range(low, high):
            if new_array[j] <= pivot:
                i += 1
                # Create new array with swapped elements
                new_array[i], new_array[j] = new_array[j], new_array[i]

        # Place pivot in correct position
        new_array[i + 1], new_array[high] = new_array[high], new_array[i + 1]

        return new_array, i + 1



def main():
    # Basic usage

    original_array = [64, 34, 25, 12, 22, 11, 90]

    print(f"Original array: {original_array}")

    sorted_array = quick_sort(original_array, 0, len(original_array) - 1)

    print(f"Original array after sort: {original_array}")
    print(f"New sorted array: {sorted_array}")


    arrays_to_sort = [
        [5, 4, 3, 2, 1],
        [1, 2, 3, 4, 5],
        [2, 1, 4, 3, 5]
    ]

    sorted_results = [
        quick_sort(arr, 0, len(arr) - 1)
        for arr in arrays_to_sort
    ]

    print("\nSorting multiple arrays:")
    for original, sorted_arr in zip(arrays_to_sort, sorted_results):
        print(f"Original: {original}")
        print(f"Sorted: {sorted_arr}\n")


if __name__ == "__main__":
    main()
