---
title: "Make B/W SVG charts with matplotlib"
permalink: /make-b-w-svg-charts-with-matplotlib.html
date: 2023-08-01T17:04:10+02:00
layout: post
type: note
draft: false
---

Install pip requirements.

```sh
pip install matplotlib
pip install pandas
```

Example of data being used.

```text
Epoch,Connect (NLB),Processing (NLB),Waiting (NLB),Total (NLB),Connect (ALB),Processing (ALB),Waiting (ALB),Total (ALB)
1,57.7,315.7,309.4,321.6,9,104.4,98.3,105.7
2,121.9,114.4,100.3,176.9,5.8,99.1,97.1,101.1
3,5.3,229.4,231.2,231.4,14.2,83,69.4,87.9
4,4.2,134.5,112.2,135.3,5.3,132.4,105.5,134.1
5,5.8,247.4,246.8,248.1,6,74.3,70.2,75.5
6,9.9,122.9,100.6,122.7,7.5,241.1,79.3,242.3
7,6.1,170.2,106.4,170.5,7.2,382.4,375.1,383.8
8,6.6,194.3,201.4,195.5,7.1,130.9,104.8,132.6
9,6.4,146.1,122.3,147.7,9.4,95.6,74,96.4
```

In the code you can use `df` as dataframes and use the headers like `df["Epoch"]`.
This is how you get a column data with pandas.

The Python code responsible for generating a chart:

```python
import csv
import sys

import matplotlib.pyplot as plt
import pandas as pd

# Read the data
df = pd.read_csv("data.csv")

# Settings
plt.title("Connect median NLB vs ALB")
plt.tight_layout(pad=2)
fig = plt.gcf()
fig.set_size_inches(10, 4)

# Plotting
plt.plot(df["Epoch"], df["Connect (ALB)"], label = "ALB", color="black", linestyle="-")
plt.plot(df["Epoch"], df["Connect (NLB)"], label = "NLB", color="black", linestyle="--")

# Adding x and y axis labels
plt.xlabel("Epoch", fontstyle="italic")
plt.ylabel("Median value (ms)", fontstyle="italic")

# Legend
legend = plt.legend()
legend.get_frame().set_linewidth(0)

# Export as SVG
plt.savefig("plot.svg", format="svg")
```

![SVG Chart](/assets/notes/plot.svg)

The image above is SVG and you can zoom in and out and check that the image is vector.
