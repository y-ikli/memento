
## Introduction to Pandas
**What is Pandas?**
- Pandas is a powerful open-source data analysis and manipulation library for Python.
- It provides data structures like DataFrame and Series, which are perfect for handling structured data.
- Commonly used for data cleaning, exploration, and analysis.

## Prerequisites
**Before starting, you’ll need:**
- Python (3.x or higher)
- Pandas installed (use `pip install pandas` or `conda install pandas`)
- A basic understanding of Python and data analysis concepts

## Importing Pandas
**Importing the Pandas library:**
```python
import pandas as pd
```

## Creating DataFrames
**Create a DataFrame from a dictionary:**
```python
data = {'Name': ['Alice', 'Bob', 'Charlie'], 'Age': [25, 30, 35]}
df = pd.DataFrame(data)
print(df)
```

**Create a DataFrame from a CSV file:**
```python
df = pd.read_csv('file.csv')
```

## Basic DataFrame Operations
**View the first few rows of the DataFrame:**
```python
df.head()
```

**View basic summary statistics of the DataFrame:**
```python
df.describe()
```

**Get DataFrame info (e.g., number of non-null entries):**
```python
df.info()
```

**Access a single column:**
```python
df['Name']
```

**Access multiple columns:**
```python
df[['Name', 'Age']]
```

## Data Selection and Filtering
**Select rows based on condition:**
```python
df[df['Age'] > 30]
```

**Select specific rows and columns using `.loc[]`:**
```python
df.loc[0:2, ['Name', 'Age']]
```

**Select specific rows and columns using `.iloc[]`:**
```python
df.iloc[0:2, [0, 1]]
```

## Modifying DataFrames
**Add a new column:**
```python
df['Salary'] = [50000, 60000, 70000]
```

**Remove a column:**
```python
df.drop('Salary', axis=1, inplace=True)
```

**Rename columns:**
```python
df.rename(columns={'Name': 'Full Name'}, inplace=True)
```

**Sort values by a column:**
```python
df.sort_values(by='Age', ascending=False)
```

## Handling Missing Data
**Check for missing values:**
```python
df.isnull().sum()
```

**Fill missing values with a specific value:**
```python
df.fillna(0, inplace=True)
```

**Drop rows with missing values:**
```python
df.dropna(inplace=True)
```

## Grouping and Aggregating
**Group data by a column and calculate the mean:**
```python
df.groupby('Age')['Salary'].mean()
```

**Group by multiple columns and apply aggregation:**
```python
df.groupby(['Age', 'Salary']).agg({'Name': 'count'})
```

## Merging DataFrames
**Merge two DataFrames on a common column:**
```python
df1 = pd.DataFrame({'ID': [1, 2, 3], 'Name': ['Alice', 'Bob', 'Charlie']})
df2 = pd.DataFrame({'ID': [1, 2, 4], 'Age': [25, 30, 35]})
merged_df = pd.merge(df1, df2, on='ID', how='inner')
```

**Join DataFrames on an index:**
```python
df1.set_index('ID', inplace=True)
df2.set_index('ID', inplace=True)
joined_df = df1.join(df2)
```

## Plotting with Pandas
**Plot a simple line chart:**
```python
df['Age'].plot(kind='line')
```

**Plot a histogram:**
```python
df['Age'].plot(kind='hist')
```

**Plot a scatter plot:**
```python
df.plot(kind='scatter', x='Age', y='Salary')
```

## Exporting Data
**Write a DataFrame to a CSV file:**
```python
df.to_csv('output.csv', index=False)
```

**Write a DataFrame to an Excel file:**
```python
df.to_excel('output.xlsx', index=False)
```

## Conclusion
**Key Takeaways:**
- Pandas makes data manipulation and analysis easier with structures like DataFrame and Series.
- You can import/export data, handle missing data, filter and aggregate data, and visualize results.
- Pandas is a great tool for any data analysis project in Python.

**Next Steps:**
- Explore Pandas documentation for advanced operations.
- Learn about multi-indexing and time series data manipulation.
- Try using Pandas alongside NumPy and Matplotlib for full data science workflows.


Last update : 2025-05-04T19:34:16Z
