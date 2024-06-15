import os
import matplotlib.pyplot as plt

# Use a dark style
plt.style.use('dark_background')

# Directory path
directory_path = "csv"

# Initialize lists to store avg-latency values and file names
avg_latencies = []
file_names = []  # Store file names corresponding to each avg latency

# List all files in the directory
try:
    files = os.listdir(directory_path)
    csv_files = [file for file in files if file.endswith('.csv')]
    
    # Read and store the value of "avg-latency" and file name from each CSV file
    for file in csv_files:
        file_path = os.path.join(directory_path, file)
        
        # Open and read the file
        with open(file_path, 'r') as f:
            for line in f:
                if "avg-latency" in line:
                    # Split the line into name-value pairs
                    pairs = line.split()
                    for pair in pairs:
                        if pair.startswith("avg-latency="):
                            # Extract the value of avg-latency
                            avg_latency_value = float(pair.split('=')[1])
                            # Append avg-latency and file name to respective lists
                            avg_latencies.append(avg_latency_value)
                            file_names.append(file)  # Store file name

except FileNotFoundError:
    print(f"The directory '{directory_path}' does not exist.")

# Plotting the line chart
if file_names and avg_latencies:
    # Plotting
    plt.figure(figsize=(10, 6))
    line, = plt.plot(file_names, avg_latencies, marker='o', markersize=2, linestyle='-', color='limegreen', linewidth=1)  # Using a bright green color
    
    # Adding labels and title
    plt.ylabel('Average Latency')
    plt.title('Average Latency by File Name')
    
    # Remove x-axis labels (ticks)
    plt.xticks([])
    
    # Display the plot
    plt.tight_layout()
    plt.show()
else:
    print("No data to plot.")
