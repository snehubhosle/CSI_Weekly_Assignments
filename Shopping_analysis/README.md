# Shopping Dataset Analysis

## Project Overview
This assignment demonstrates a complete shopping dataset analysis using Python and Jupyter Notebook. The work focuses on dataset preparation, transformation, and exploratory analysis to support data-driven recommendations for e-commerce operations.

## Objectives
- Load and inspect shopping data with Pandas
- Clean and normalize values across price, rating, and text fields
- Detect and remove duplicates and inconsistent entries
- Create derived metrics for pricing and product popularity
- Analyze trends through visual summaries and category comparisons
- Produce actionable findings for merchandising and pricing decisions
- Save the processed dataset for future analysis

## Dataset Summary
The dataset contains product-level details from an online shopping catalog:
- Product ID
- Title and description text
- Rating and review count
- Original and discounted prices
- Discount offers
- Product category and seller attributes

Total records analyzed: 1000

## Technologies Used
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook

## Project Structure
- `data/`
  - `Combined_dataset.csv` — raw combined dataset used as input
  - `cleaned_dataset.csv` — output dataset after preprocessing
- `notebook/`
  - `shopping_analysis.ipynb` — notebook containing the full analysis workflow
- `README.md` — project summary and usage details

## Data Cleaning Steps
- Converted price columns from text to numeric values
- Standardized missing values and replaced empty fields with meaningful defaults
- Removed duplicate records to ensure accurate aggregation
- Validated rating and review fields for consistency
- Saved the cleaned dataset into `data/cleaned_dataset.csv`

## Feature Engineering
New features created to improve analysis:
- `price_difference` = original price − discounted price
- `popularity_score` = rating × ratings count
- Discount percentage derived from price and final price
- Price segments to classify products as low, medium, or high priced

## Exploratory Data Analysis
The analysis explores several dimensions of the dataset:
- Distribution of product prices and discounts
- Rating distribution and review activity
- Category-level counts, average ratings, and average prices
- Relationships between price, rating, and popularity

## Visualization Highlights
Included plots in the notebook:
1. Price distribution histogram
2. Category product counts bar chart
3. Category price comparison boxplots
4. Scatter plot of rating versus popularity

## Key Findings
- Most products are priced in the affordable segment
- A large share of products have ratings above 4.0
- A few categories dominate product counts
- Price ranges vary significantly across categories
- Higher-rated items with more reviews tend to have stronger popularity scores

## Business Insights
- Focus promotions on categories with the highest product volume
- Use popular high-rating products to enhance recommendations
- Monitor price ranges per category to stay competitive
- Target the largest customer segments with affordable, well-rated products

## Conclusion
This assignment proves a practical end-to-end data analysis process for shopping data. The cleaned dataset, derived features, and exploratory results enable stronger business decisions around pricing, inventory, and product performance.

## Author
Snehal Bhosale 

CEI Internship Program  
Computer Engineer Undergraduate

- Email: snehalbhosale1807@gmail.com
- GitHub: https://github.com/snehubhosle
- LinkedIn: https://www.linkedin.com/in/snehalbhosale23
