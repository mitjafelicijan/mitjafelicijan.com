---
title: "Make B/W SVG charts with matplotlib"
url: make-b-w-svg-charts-with-matplotlib.html
date: 2023-08-01T17:04:10+02:00
type: note
draft: false
---

Install pip requirements.

```sh
pip install matplotlib
pip install numpy
pip install pandas
```

Now execute the script.

```python
import csv
import sys

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Read the data
df = pd.read_csv("data.csv")

# Settings
plt.title("Connect median NLB vs ALB")
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

![SVG Chart](/notes/plot.svg)
