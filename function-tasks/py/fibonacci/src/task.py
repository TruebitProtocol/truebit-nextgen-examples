def fibonacci(n):
    """Calculate the nth Fibonacci number iteratively."""
    if n == 0:
        return 0
    elif n == 1:
        return 1

    a, b = 0, 1
    for _ in range(2, n + 1):
        c = a + b
        a = b
        b = c
    return c

def run_task(input_string):
    """Convert input string to integer, compute Fibonacci, and return as string."""
    return str(fibonacci(int(input_string)))

def main():
    """Main function to read, process, and write Fibonacci number to a file."""
    try:
        with open("input.txt", "r") as file:
            input_string = file.read().strip()
    except FileNotFoundError:
        print("Error: The file 'input.txt' does not exist.")
        return
    except Exception as e:
        print(f"An error occurred while reading 'input.txt': {e}")
        return

    try:
        output_string = run_task(input_string)
    except ValueError:
        print("Error: Input must be an integer.")
        return
    except Exception as e:
        print(f"An error occurred while processing the input: {e}")
        return

    try:
        with open("output.txt", "w") as file:
            file.write(output_string)
    except Exception as e:
        print(f"An error occurred while writing to 'output.txt': {e}")

if __name__ == "__main__":
    main()
