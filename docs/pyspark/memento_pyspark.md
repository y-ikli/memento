## PySpark Tutorial
**Introduction**
- PySpark is the Python API for Apache Spark, enabling scalable data processing using Python.

**Setup**
- Install PySpark:
```
pip install pyspark
```
- Import PySpark modules:
```
from pyspark.sql import SparkSession
```

**Creating a Spark Session**
```
spark = SparkSession.builder.appName("PySparkTutorial").getOrCreate()
```

**Creating DataFrames**
- From list of tuples:
```
data = [("Alice", 34), ("Bob", 45), ("Cathy", 29)]
df = spark.createDataFrame(data, ["Name", "Age"])
df.show()
```
- From CSV file:
```
df_csv = spark.read.csv("path/to/file.csv", header=True, inferSchema=True)
df_csv.show()
```

**Basic DataFrame Operations**
- Show schema:
```
df.printSchema()
```
- Select columns:
```
df.select("Name").show()
```
- Filter rows:
```
df.filter(df.Age > 30).show()
```
- Add column:
```
from pyspark.sql.functions import col
df.withColumn("AgePlus10", col("Age") + 10).show()
```
- Group and aggregate:
```
df.groupBy("Age").count().show()
```

**Working with SQL**
- Register DataFrame as SQL view:
```
df.createOrReplaceTempView("people")
sql_df = spark.sql("SELECT Name FROM people WHERE Age > 30")
sql_df.show()
```

**Data Types and Schema**
- Custom schema definition:
```
from pyspark.sql.types import StructType, StructField, StringType, IntegerType
schema = StructType([
    StructField("Name", StringType(), True),
    StructField("Age", IntegerType(), True)
])
df_custom = spark.createDataFrame(data, schema)
df_custom.printSchema()
```

**Joins**
```
df1 = spark.createDataFrame([("Alice", "Math"), ("Bob", "Science")], ["Name", "Subject"])
df2 = spark.createDataFrame([("Alice", 85), ("Bob", 90)], ["Name", "Score"])
joined_df = df1.join(df2, on="Name", how="inner")
joined_df.show()
```

**Saving DataFrames**
- Write to CSV:
```
df.write.csv("output/path", header=True, mode="overwrite")
```
- Write to Parquet:
```
df.write.parquet("output/path", mode="overwrite")
```

**Working with RDDs**
- Create RDD:
```
rdd = spark.sparkContext.parallelize([1, 2, 3, 4, 5])
```
- Transform and collect:
```
squared = rdd.map(lambda x: x * x)
print(squared.collect())
```

**Stopping Spark Session**
```
spark.stop()
```

**Conclusion**
- PySpark supports powerful big data processing in Python using DataFrames and RDDs. Use DataFrames for structured data and RDDs for lower-level operations.

---

Last update : 2025-05-04T19:11:36Z
