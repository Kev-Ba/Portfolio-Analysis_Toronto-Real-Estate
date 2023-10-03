##### Kevin Badali's Portfolio

---


## Toronto Real Estate: <br> Bank Rate & Market Analysis <br>


### Analysis Summary

We analyzed the affect that inflation, and/or the bank rate might have on the Toronto Real Estate market. We had 9 years worth of sample data, from 2013 - 2022.

The data was collected from two different sources, and then designed into a mySQL database. 

The data showed a close correlation between the bank rate and inflation rate. We analyzed the real estate market, using bank rate as our primary metric. The analysis showed both correlations and inverse correlations with different parts of the market (average sold price, number of days on market, and the number of sales).

###### Note:

This analysis was done as the final project for my (in person) Data Analytics certificate at Brainstation. It was put together by myself and two other students. 

I was responsible for collecting data, cleaning it, and creating the database. The mySQL code is also code that I wrote for the analysis. 

---

### Data Collection, Cleaning, & Database Creation

##### Step 1: Collecting Data

- Downloaded CSVs from the Bank of Canada (bank rates, variable mortgage rates, inflation rates)
- Real Estate data resided in tables on toronto.listings.ca
> - Tables imported into excel using PowerQuery
> - Had to import each table separately (10 tables for 10 years).  Repeated this for each different housing type (condos, freehold homes, etc.)

##### Step 2: Reviewing Data & Designing Database Schema

- There were 4 tables of real estate data (each for different housing type) – with an additional one that was simply an all table which didn’t specify housing type (for a total of 5 tables).
- There were 4 tables of Bank of Canada data. Monthly bank rates, weekly bank rates, weekly variable mortgage rate, and quarterly inflation rates.
- Created the below schema:
*insert eer diagram*

##### Step 3: Cleaning Bank of Canada Data

-  Bank Rate Monthly | Bank Rate Weekly | Variable Mortgage Rate
> - Created a primary key for each of the 4 tables using a concat(), text(), and row() formula in excel
> -  Split the date into years, quarters, months, and week numbers
> -  Used helper columns to assign foreign keys across the tables, using a vlookup()

- Inflation
> - Date was formatted as yyyyQ# - so I cleaned it up by using left() and right() functions to create a year, and quarter column.
> - I used a lookup table to list each month with each quarter (3 new columns called: month_1, month_2, month_3)

##### Step 4: Cleaning Real Estate Data

- Each housing type was contained in its own excel file, as each of them had 10 tables, 1 for each year.
- Used PowerQuery to join all the tables into one amalgamated table (for each excel file)
- Created primary keys and assigned foreign keys using helper columns & vlookup()s

##### Step 5: CSVs & SQL

- Exported all tables into their own CSVs
- Created a new database in mySQL
- Created all new tables in mySQL
- All the CSVs were placed in th appropriate mySQL folder, and an import data infile function was used to populate the tables with data
- Finally, this database was not being hosted on a server that others could access, so I exported the database into a SQL file, and then shared it with my project team
> - Database was exported via the Server menu in mySQL, and then Data 
    Export











