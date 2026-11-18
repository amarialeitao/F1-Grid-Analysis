# Starting Grid vs. Final Position in Formula 1

[![Analysis](https://github.com/amarialeitao/F1-Grid-Analysis/actions/workflows/analysis.yml/badge.svg)](https://github.com/amarialeitao/F1-Grid-Analysis/actions/workflows/analysis.yml)
![R](https://img.shields.io/badge/R-tidyverse-276DC3?logo=r&logoColor=white)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

How much does the starting grid decide a Formula 1 race? This project answers that with data: a full analysis in R, from cleaning a real dataset of race results to a correlation test and a simple linear regression.

![Grid position vs. final position](plots/relacao_grid_posicao.png)

## Key findings

Computed from `data/results.csv` with the same steps as `scripts/analise_f1.r` (drivers who were classified at the finish and did not start from the pit lane):

| Measure | Value |
| --- | --- |
| Race results analysed | 15,746, from 1,125 races |
| Pearson correlation (grid vs. final position) | **0.65** |
| R² of the linear model | **0.42** |
| Slope | **+0.47** positions at the finish for each position further back on the grid |
| p-value | < 2e-16 |

- **Starting position matters a lot.** The correlation is strong and positive, and grid position alone explains about 42% of the variation in where a driver finishes.
- **But it is not destiny.** On average, each place lost on the grid costs about half a place at the finish, and 58% of the variation comes from everything else: car, driver, strategy, incidents and reliability.
- In practice, this supports how much a good qualifying session on Saturday matters for the result on Sunday.

## Data

The dataset is the [Formula 1 World Championship (1950 - 2020)](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020) on Kaggle. This project uses `results.csv`, with one row per driver per race (26,759 rows).

## Method

The script `scripts/analise_f1.r` follows these steps:

1. **Load** `results.csv` and keep the `grid` and `position` columns.
2. **Clean:** convert `position` to a number (non-numeric codes such as `\N` for non-classified drivers become `NA`), then drop rows with no final position and rows with `grid = 0`, which marks a pit lane start.
3. **Explore:** a scatter plot of grid vs. final position with a linear trend line, saved to `plots/relacao_grid_posicao.png`.
4. **Measure:** the Pearson correlation coefficient between the two variables.
5. **Model:** a simple linear regression, `lm(position ~ grid)`, and its summary (coefficients, R² and p-value).

## Limitations

- **Only classified finishers are included.** About 37% of starts did not end with a final position, mostly retirements. Front-runners who retire are left out, so the relationship is measured among drivers who finished.
- **Positions are ranks, not measurements.** A straight line is a useful first summary, but a rank-based correlation (Spearman) or an ordinal model would fit the nature of the data better.
- **Seventy years in one model.** Grids, car reliability and race rules changed a lot between 1950 and 2020. Splitting the analysis by era would show whether qualifying matters more today than in the past.

## Tools

- **R** and **RStudio**
- **tidyverse:** `dplyr` for cleaning and `ggplot2` for the chart

## How to run

1. Clone the repository:
   ```bash
   git clone https://github.com/amarialeitao/F1-Grid-Analysis.git
   cd F1-Grid-Analysis
   ```
2. The dataset is already in `data/results.csv`. To use a newer version, download it from [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020) and replace the file.
3. Open the project folder in RStudio and run `scripts/analise_f1.r` (click **Source**). The script installs `tidyverse` if needed, prints the correlation and the model summary, and saves the chart to `plots/`.

### Check the findings

```bash
Rscript tests/testa_resultados.R
```

This runs the full analysis and stops with an error if any number in the **Key findings** table no longer matches. The same check runs on every push in [GitHub Actions](https://github.com/amarialeitao/F1-Grid-Analysis/actions/workflows/analysis.yml), which also publishes the regenerated chart as a build artifact.

## Project structure

```
.
├── data/
│   └── results.csv              # Race results dataset
├── plots/
│   └── relacao_grid_posicao.png # Scatter plot with the trend line
├── scripts/
│   └── analise_f1.r             # Full analysis
├── tests/
│   └── testa_resultados.R       # Checks the README numbers
└── README.md
```

The code comments and chart labels are in Portuguese.

## License

[MIT](LICENSE)
