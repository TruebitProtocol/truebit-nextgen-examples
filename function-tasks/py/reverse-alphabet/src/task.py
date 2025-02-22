def run_task(input_str):
    """Reverses the input string.

    Args:
        input_str: The string to be reversed. 

    Returns:
        The reversed string.
    """

    return input_str[::-1]

if __name__ == "__main__":
    with open("input.txt", "r") as input_file:
        input_str = input_file.read()

    output_str = run_task(input_str)

    with open("output.txt", "w") as output_file:
        output_file.write(output_str)

    print(output_str)