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
considers jointly a number of common fallacies: confirmation bias, loss
aversion, gambler’s fallacy, availability cascade, hot-hand fallacy,
bandwagon effect, and Dunning–Kruger effect, which have hitherto been
studied separately. The paper aims to highlight the diverse range of
investor’s profiles which are characterised by such fallacies, and the
considerable differences observed based on their age, gender, stock
market experience and perception of market trends.

### The aim of RR project

In this project we are trying to gather new observations based on new
surveyed data to do the comparison between the results of the original
paper and the result of the newly gathered data. The justification is
that Iran’s economy has been through a major changes ever since we
published the paper and we want to examine the change from the point of
investors.

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
    ├── in                         # Input folder for survey's data
    │   ├── survey_data.csv        # Surveyed data from the investors in May 2022
    └──
    ├── src                        # Source files
    │   ├── comparitive_analysis.R # R file for analysis
    │   ├── func.R                 # Functions
    └──
    ├── out                        # Presentation
    │   ├── presentation.RMD       # RMarkdown for presentation
    └──
    ├── LICENSE
    └── README.md
