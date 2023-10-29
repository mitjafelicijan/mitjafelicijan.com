import csv

import matplotlib.pyplot as plt
import pandas as pd

# Read the data
df = pd.read_csv("benchmarks.csv")

# Settings
plt.title("Encode to FASTA out filesize")
plt.tight_layout(pad=2)
fig = plt.gcf()
fig.set_size_inches(10, 4)

# Plotting
plt.plot(df["Packages"], df["FASTA file size (KB)"], label = "Raw", color="black", linestyle="-")
plt.plot(df["Packages"], df["FASTA gzipped (KB)"], label = "Gzipped", color="black", linestyle="--")

# Adding x and y axis labels
plt.xlabel("Size of an input file", fontstyle="italic")
plt.ylabel("File size (KB)", fontstyle="italic")

# Legend
legend = plt.legend()
legend.get_frame().set_linewidth(0)

# Export as SVG
plt.savefig("chart-size.svg", format="svg")
