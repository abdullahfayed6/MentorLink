# Data Analysis with Pandas

## Pandas Fundamentals

### Data Structures
- **Series**: One-dimensional labeled arrays
- **DataFrame**: Two-dimensional labeled data structure
- **Index**: Row and column labels for data alignment
- **MultiIndex**: Hierarchical indexing for complex data
- **Data Types**: Numeric, categorical, datetime handling

### Data Loading and Saving
- **CSV Files**: read_csv, to_csv with various options
- **Excel Files**: read_excel, to_excel workbook handling
- **JSON Data**: read_json, to_json nested data structures
- **SQL Databases**: read_sql, to_sql database integration
- **Web APIs**: Reading data from REST APIs

### Basic Operations
- **Data Selection**: loc, iloc, boolean indexing
- **Filtering**: Conditional data filtering techniques
- **Sorting**: sort_values, sort_index methods
- **Data Types**: astype, categorical data conversion
- **Basic Statistics**: describe, info, value_counts

## Data Manipulation

### Data Cleaning
- **Missing Data**: isnull, dropna, fillna handling
- **Duplicate Data**: duplicated, drop_duplicates methods
- **Data Validation**: Data quality checks and cleaning
- **Outlier Detection**: Statistical and visual outlier identification
- **Data Standardization**: Consistent formatting and encoding

### Data Transformation
- **Column Operations**: Creating, modifying, deleting columns
- **Row Operations**: Adding, updating, removing rows
- **Data Reshaping**: pivot, melt, stack, unstack operations
- **String Operations**: str accessor for text manipulation
- **Date/Time Operations**: dt accessor for temporal data

### Grouping and Aggregation
- **GroupBy Operations**: Splitting data by categories
- **Aggregation Functions**: sum, mean, count, custom functions
- **Multi-level Grouping**: Grouping by multiple columns
- **Transform Operations**: Group-wise transformations
- **Window Functions**: Rolling, expanding calculations

## Advanced Analytics

### Merging and Joining
- **Merge Operations**: Inner, outer, left, right joins
- **Concatenation**: concat for combining DataFrames
- **Join Methods**: Index-based joining operations
- **Handling Conflicts**: Suffix handling and key validation
- **Performance**: Efficient joining strategies

### Time Series Analysis
- **DateTime Index**: Setting and working with time indexes
- **Resampling**: Frequency conversion and aggregation
- **Time Zone Handling**: tz_localize, tz_convert operations
- **Period Data**: Working with periods and frequencies
- **Time Series Plotting**: Visualization of temporal data

### Performance Optimization
- **Memory Usage**: Optimizing DataFrame memory consumption
- **Vectorization**: Avoiding loops with vectorized operations
- **Chunking**: Processing large datasets in chunks
- **Categorical Data**: Memory-efficient categorical types
- **Parallel Processing**: Using multiple cores for operations
