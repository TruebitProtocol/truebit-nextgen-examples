import pandas as pd
import numpy as np
import os

# Generate fake data without a fixed seed for different results each time
data = {
    'A': np.random.randint(1, 100, 10),  # Random integers between 1 and 100
    'B': np.random.random(10),  # Random floats between 0 and 1
    'C': np.random.choice(['X', 'Y', 'Z'], 10)  # Random choices from 'X', 'Y', 'Z'
}

df = pd.DataFrame(data)

# Ensure the "data" directory exists
os.makedirs('data', exist_ok=True)

# Determine the filename with incremental numbering
base_filename = 'data/frame'
extension = '.csv'
i = 1

while os.path.exists(f"{base_filename}{i}{extension}"):
    i += 1

filename = f"{base_filename}{i}{extension}"

# Save the DataFrame to a CSV file with the determined filename
df.to_csv(filename, index=False)

print(f"File '{filename}' successfully generated.")
