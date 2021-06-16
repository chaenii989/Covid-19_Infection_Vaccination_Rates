# ETL_Project_Covid-19
  This ETL project provides insight to Michigan Covid-19 data for each county from January 2020 to Current. Data was pulled from 2 sources by extraction from a CSV and API. The data is then transformed using a python with pandas. Multiple techniques and functions were used to transform the data into a more structured and organized format. The data was then exported to SQL to create 7 tables. All tables were linked using primary keys to easily move through and connect tables to compare data.

* LINK TO PRESENTATION FILE : [Team_3_ETL_Project_Presentation](https://docs.google.com/presentation/d/1ciUw1wN9cZtoEJp1r2oRnI-ffVgY5-UjeBNwYPe_B88/edit?usp=sharing)

# Extract

## 1. Johns Hopkins Center for Systems Science & Engineering
GitHub page csv (time_series_covid19_confirmed_US)
* Confirmed cases in the US only
* Updated once a day around 23:59 (UTC)
## 2. COVID ACT NOW : Realtime US Covid-19 Map & Vaccine Tracker
API → JSON (State & County Info.)    (https://api.covidactnow.org/v2/counties.json?apiKey=)
* Confirmed cases in the US only
* Data is updated daily around noon (EST) 

# Transform
Pandas Functions to Transform this Dataset:
## 1. pandas.melt function to unpivot data in a DataFrame
   1. Unpivot: transpose columns into rows, changing from wide to long format
   2. When to use: when there are two data types in one column (column header data type differs from the column value data) or to better organize a DataFrame to save space
   3. Link to .melt documentation
   4. .melt() parameters:
      1. id_vars = Unpivoted by county name
      2. var_name = column header name for the columns to be unpivoted
      3. value_name = column header name for the values
## 2. Used the following functions to get the largest daily changes (in case counts and % change) in Wayne county, Michigan
   1. .nlargest() find county with largest case counts overall
   2. .loc() on that county
   3. .diff() find largest daily change in case numbers 
   4. .pct_change() % change in those case numbers
## 3. .iterrows() function
   1. Did a str.split() to split the date column into Month, Day, & Year columns
   2. Used iterrows to convert “4” to “April”
   3. Then merged to get “Month YYYY”
## 4. .apply() function
   1. Apply a function along an axis of the DataFrame
   2. (axis = 0 : apply function to columns, axis = 1 : apply function to each rows)
## 5. pd.agg() function
   1. The aggregate function is used for one or more operations, it was used here in order to get the min and max vaccination percent completed in the state.
## 6. Pandas.profileReport: (from pandas_profiling import ProfileReport)
   1. Pandas profile report generates multiple statistical results based on a given dataset. (vaccination_df)
   2. Each variable shows high correlation (Pearson’s r)

# Load
## 1. Connection
   1. Connected Jupyter notebook with Postgresql by creating an engine to begin loading data into SQL.
   2. Create 4 tables in SQL to hold data that will be loading into Postgresql
      1. Table Names
         1. Death_infections
         2. Test_case_ratios
         3. April_2020_2021
         4. Vaccination
         5. Cases by County
## 2. Load
   1. Loaded each table into Postgresql using my connection developed in Jupyter notebook.
      1. Function - vaccination_df.to_sql(name='vaccination', con=engine, if_exists='replace', index=False)
   2. Verified data was loaded by running SQL query in Jupyter notebook
      1. Function - pd.read_sql_query('select * from vaccination', con=engine).head()
   3. Ran a join on County in vaccination table and april_2020_2021 to compare april 2021 covid cases to total current cases

        SELECT va."County", va."Total_Current_Cases", ap."Cases"
        FROM vaccination as va
        JOIN april_2020_2021 as ap
        ON (ap."County" = va."County");

# Sources
## 1. Johns Hopkins (JHU CSSE)
   1. This data set is licensed under the Creative Commons Attribution 4.0 International (CC BY 4.0) by the Johns Hopkins University on behalf of its Center for Systems Science in Engineering. Copyright Johns Hopkins University 2020.
   2. "COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University" or "JHU CSSE COVID-19 Data" for short.
   3. URL: https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv
## 2. COVID ACT NOW
   1. The Covid Act NOW API provides access to comprehensive COVID data (both current and historical.
   2. The data is available for all US states, counties and metros and is aggregated from a number of official sources, quality assured and updated daily. 
   3. URL: https://covidactnow.org/data-api

