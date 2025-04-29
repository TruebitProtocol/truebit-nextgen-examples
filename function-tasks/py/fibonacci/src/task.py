import sys 

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

def main():
    """Main function to read, process, and write Fibonacci number to a file."""
    try:
        with open("input.txt", "r") as file:
            input_string = file.read().strip()
    except FileNotFoundError:
        print("The input file does not exist", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Cannot read input: {e}", file=sys.stderr)
        sys.exit(1)

    try:
        # Validate that input is a valid integer
        if not input_string.isdigit():
            print("Input must be a valid non-negative integer", file=sys.stderr)
            sys.exit(1)
        output_string = str(fibonacci(int(input_string)))
    except Exception as e:
        print(f"Error processing the input: {e}", file=sys.stderr)
        sys.exit(1)

    try:
        with open("output.txt", "w") as file:
            file.write(output_string)
    except Exception as e:
        print(f"Cannot write to 'output.txt': {e}")

if __name__ == "__main__":
    main()
