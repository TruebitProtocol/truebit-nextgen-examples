import pandas as pd
import numpy as np
import os

def main():
	# Load filepath of input CSV
	try:
		with open("input.txt", "r") as file:
		    input_file = file.read().strip()
	except FileNotFoundError:
		print("Error: The file 'input.txt' does not exist.")
		return
	except Exception as e:
		print(f"An error occurred while reading 'input.txt': {e}")
		return

	print("\ninput_file: '" + input_file + "'\n")

	# Read the CSV file
	##############################
	## Pandas WIP: can't open file
	##############################
#	df = pd.read_csv(os.path.abspath(input_file))

	#rng = np.random.default_rng()
	#data = {
	#	'A': rng.integers(low=1, high=100, size=10),
	#	'B': rng.random(10),
	#	'C': rng.choice(['X', 'Y', 'Z'], 10)
	#}

	########################################################
	## Python WIP: most float values in column 'B' are 'nan'
	########################################################
	data = {
		'A': [ 17,31,18,69,8,58,54,63,91,35 ],
		'B': [ 0.98545,0.199326,0.432207,0.609930,0.193569,0.11393507449416629,0.6563809560437724,0.26977118642752007,0.7907362091441835,0.9990610723341307],
		'C': [ 'Y','Y','Z','Z','Y','Y','Y','Z','X','Z' ]
	}

	print (data)
	df = pd.DataFrame(data)
	print (df.to_string(index=False))

	# Display the original DataFrame
	original_output = "Original DataFrame:\n" + df.to_string(index=False)

	# Calculate basic statistics using numpy
	mean_A = np.mean(df['A'])
	std_A = np.std(df['A'])
	sum_B = np.sum(df['B'])
	max_B = np.max(df['B'])

	statistics = (
		f"\nMean of column 'A': {mean_A}\n"
		f"Standard deviation of column 'A': {std_A}\n"
		f"Sum of column 'B': {sum_B}\n"
		f"Maximum value of column 'B': {max_B}"
	)

	# Add a new column with the natural logarithm of 'B' values using numpy
	df['log_B'] = np.log(df['B'] + 1)  # +1 to avoid log(0)

	# Create a correlation matrix using numpy
	correlation_matrix = np.corrcoef(df[['A', 'B']].T)
	correlation_output = "Correlation matrix between 'A' and 'B':\n" + str(correlation_matrix)

	# Normalize column 'A' using numpy
	df['A_normalized'] = (df['A'] - np.mean(df['A'])) / np.std(df['A'])

	# Filter rows where column 'A' is greater than its mean
	filtered_df = df[df['A'] > mean_A]

	# Add a date column
	df['date'] = pd.date_range(start='2024-01-01', periods=len(df), freq='D')

	# Group by column 'C' and calculate the mean of 'A' for each group
	grouped = df.groupby('C')['A'].mean().reset_index()
	grouped_output = "Mean of 'A' grouped by 'C':\n" + grouped.to_string(index=False)

	# Apply a lambda function to create a new column 'A_category'
	df['A_category'] = df['A'].apply(lambda x: 'High' if x > 50 else 'Low')

	# Handling missing values: introduce some NaN values in 'B' and then fill them
	df.loc[::3, 'B'] = np.nan
	df['B_filled'] = df['B'].fillna(df['B'].mean())

	# Prepare the output to be written to output.txt
	output_content = (
		original_output + statistics + "\n\n" +
		"Modified DataFrame:\n" + df.to_string(index=False) + "\n\n" +
		"Filtered DataFrame (A > Mean of A):\n" + filtered_df.to_string(index=False) + "\n\n" +
		correlation_output + "\n\n" +
		grouped_output
	)

	# Save the results to output.txt
	with open('output.txt', 'w') as file:
		file.write(output_content)

	print(f"Results written to 'output.txt'.")

if __name__ == "__main__":
    main()
