import csv

import matplotlib.pyplot as plt
import pandas as pd

# Read the data
df = pd.read_csv("benchmarks.csv")

# Settings
plt.title("Encode to FASTA speed over time")
plt.tight_layout(pad=2)
fig = plt.gcf()
fig.set_size_inches(10, 4)

# Plotting
plt.plot(df["Packages"], df["Encode to FASTA (ms)"], label = "ALB", color="black", linestyle="--")

# Adding x and y axis labels
plt.xlabel("Size of an input file", fontstyle="italic")
plt.ylabel("Encoding time (ms)", fontstyle="italic")

# Export as SVG
plt.savefig("chart-speed.svg", format="svg")
