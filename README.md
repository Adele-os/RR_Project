## Reproducible Reserach Project

This is the repository for the RR course project. In this project we
aimed to recalculate the results of the paper [Cognitive Biases on the
Iran Stock Exchange: Unsupervised Learning Approach to Examining Feature
Bundles in Investors’
Portfolios](https://www.mdpi.com/2076-3417/11/22/10916) which has been
done by **Adele Ossareh**, **Mohammad Saeed Pourjafar** and **Dr. Tomasz
Kopczewski** and published in journal of applied science in November
2021.

### The paper

The paper innovatively analyses the joint occurrence of cognitive biases
in groups of stock exchange investors in Tehran Stock Exchange (TSE). It
considers jointly a number of common fallacies, which have hitherto been
studied separately. The paper aims to highlight the diverse range of
investor’s profiles which are characterised by such fallacies, and the
considerable differences observed based on their age, gender, stock
market experience and perception of market trends. The biases are as
follow:

-   Confirmation bias
-   Loss aversion
-   Gambler’s fallacy
-   Availability cascade
-   Hot-hand fallacy
-   Bandwagon effect
-   Dunning–Kruger effect

### The aim of RR project

In this project we are trying to gather new observations based on new
surveyed data to do the comparison between the results of the original
paper and the result of the newly gathered data. The justification is
that Iran’s economy has been through a major changes ever since we
published the paper and we want to examine the change from the point of
investors. For this purpose of chnage in investors’ view on TSE, one of
the measure we use to distinguish the previous state of Iran’s economy
from today’s situation (June 2022), is
[CPI](https://en.wikipedia.org/wiki/Consumer_price_index) which can be
calculated as:

$$
\\begin{aligned}
CPI=\\frac{C_t}{C_0}\*100
\\end{aligned}
$$

in which the **CPI** is consumer price index in current period,
***C*<sub>*t*</sub>** is cost of market basket in current period and
***C*<sub>0</sub>** is cost of market basket in base period. This
increase in **CPI** has also been reflected in Iran’s central bank
report:

<center>
<img src="https://github.com/SaeedPourjafar/RR_Project/blob/main/fig/Iran_CPI.png">
</center>

### Data

The data for the paper can be found
[here](https://github.com/tomvar/Cognitive_Biases_on_the_Iran_Stock_Exchange).
The newly gathered data from the recent survey can be found in [this
folder](https://github.com/SaeedPourjafar/RR_Project/tree/main/in). 32
investors participated in the survey through Google Forms during May
2022 in which they were the stock market holders in TSE (Tehran Stock
Exchange)

### Folder structure

    .
    ├── fig                           # Folder for images and figures
    │   ├── Iran_CPI.png              # Iran's CPI graph
    └──
    ├── in                            # Input folder for survey's data
    │   ├── survey_data.csv           # Surveyed data from the investors in May 2022
    └──
    ├── src                           # Source files
    │   ├── comparative_analysis.R    # R file for analysis
    │   ├── func.R                    # Functions
    │   ├── presentation.RMD          # RMarkdown for presentation
    └──
    ├── out                           # Presentation
    │   ├── presentation.HTML         # HTML for presentation
    └──
    ├── LICENSE
    └── README.md
