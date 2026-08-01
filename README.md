# Digital Wellbeing in Asia

This project develops a prototype machine learning pipeline to predict public sentiment and behaviour related to digital wellbeing issues in Asia using real-world social media data.

## Project Overview

The study uses a filtered subset of the Exorde social media dataset, combined with DuckDB for scalable data storage and SQL-based filtering. The workflow compares two preprocessing strategies and three classification models to evaluate which approach best predicts sentiment in multilingual and culturally nuanced online discussions.

## Objectives

- Build a reproducible NLP pipeline for social media sentiment analysis
- Compare traditional feature engineering with modern multilingual embeddings
- Evaluate model performance in an Asian policy and public discourse context
- Generate insights relevant to digital wellbeing and online behaviour trends

## Methods

- Data handling and filtering using DuckDB
- Text preprocessing with TF-IDF and multilingual sentence embeddings
- Model comparison across Elastic Net, XGBoost, and Neural Networks
- Evaluation with Accuracy, Weighted F1, Precision, and Recall

## Key Findings

- The most common topic was Screen Time & Device Dependency
- Neutral sentiment was the largest share within this dominant topic
- Multilingual sentence embeddings outperformed traditional TF-IDF features
- Elastic Net achieved the best overall balance between performance and generalization

## Repository Contents

- `final.rmd` — R Markdown source report
- `final.html` — rendered HTML report
- `filtered_by_topics_with_url.csv` — filtered input dataset
- `filtered_by_topics_tidy_2024_rendered.csv` — processed analysis dataset
- `watch_render.ps1` and `render_report.R` — scripts to regenerate the report
- `Digital Wellbeing Final Report.docx` — final Word report
- `digital_wellbeing_project_brief.pdf` — project brief

## Reproducibility

To render the report locally, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\watch_render.ps1 -Once
```

## Tech Stack

- Python
- R / R Markdown
- DuckDB
- scikit-learn / sentence-transformers / XGBoost
- NLP and text preprocessing pipelines
