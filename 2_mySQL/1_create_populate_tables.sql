-- Make sure no duplicate databases are created

drop database if exists KB_Portfolio_RE_Analysis;

-- Create the database

create database KB_Portfolio_RE_Analysis;

-- Make sure no duplicate tables are created

drop table if exists re_all;
drop table if exists re_condos;
drop table if exists re_condo_townhomes;
drop table if exists re_detached_homes;
drop table if exists re_freehold_townhomes;
drop table if exists real_estate;
drop table if exists bank_rate_monthly;
drop table if exists bank_rate_weekly;
drop table if exists var_mortgage_rate;
drop table if exists inflation;

-- Create relevant data tables

create table re_all
(
    id varchar(10) not null,
    date date,
    quarter int not null,
    year int not null, 
    month int not null,
    number_of_sales int,
    avg_list_price int,
    avg_sold_price int, 
    above_below_asking_percent double,
    monthly_change_$ int,
    monthly_change_percent double, 
    days_on_market int,
    lookup_c varchar(10),
    lookup_ct varchar(10),
    lookup_ft varchar(10),
    lookup_dh varchar(10),
    lookup_brm varchar(10),
    primary key (id)
);

create table re_detached_homes
(
    id varchar(10) not null,
    date date,
    quarter int not null,
    year int not null, 
    month int not null,
    number_of_sales int,
    avg_list_price int,
    avg_sold_price int, 
    above_below_asking_percent double,
    monthly_change_$ int,
    monthly_change_percent double, 
    days_on_market int,
    primary key (id)
);

create table re_freehold_townhomes
(
    id varchar(10) not null,
    date date,
    quarter int not null,
    year int not null, 
    month int not null,
    number_of_sales int,
    avg_list_price int,
    avg_sold_price int, 
    above_below_asking_percent double,
    monthly_change_$ int,
    monthly_change_percent double, 
    days_on_market int,
    primary key (id)
);

create table re_condo_townhomes
(
    id varchar(10) not null,
    date date,
    quarter int not null,
    year int not null, 
    month int not null,
    number_of_sales int,
    avg_list_price int,
    avg_sold_price int, 
    above_below_asking_percent double,
    monthly_change_$ int,
    monthly_change_percent double, 
    days_on_market int,
    primary key (id)
);

create table re_condos
(
    id varchar(10) not null,
    date date,
    quarter int not null,
    year int not null, 
    month int not null,
    number_of_sales int,
    avg_list_price int,
    avg_sold_price int, 
    above_below_asking_percent double,
    monthly_change_$ int,
    monthly_change_percent double, 
    days_on_market int,
    primary key (id)
);

create table bank_rate_monthly
(
	id varchar(10) not null, 
    date date not null, 
    bank_rate double, 
    quarter int, 
    year int, 
    month int, 
    inf_lookup varchar(10),
    primary key (id)
);

create table bank_rate_weekly
(
	id varchar(10) not null, 
    date date not null, 
    bank_rate double, 
    quarter int, 
    year int, 
    month int, 
    week_num int,
    vmr_lookup varchar(10),
    brm_lookup varchar(10),
    primary key (id)
);

create table var_mortgage_rate
(
	id varchar(10) not null, 
    date date not null, 
    var_rate double, 
    quarter int, 
    year int, 
    month int, 
    week_num int,
    primary key (id)
);

create table inflation
(
	id varchar(10) not null, 
    year int, 
    quarter int, 
    total_cpi double,
    cpi_trim double,
    cpi_medium double,
    cpi_common double, 
    month_1 int, 
    month_2 int, 
    month_3 int,
    primary key (id)
);

-- Populate tables with data from CSVs

load data infile 'Toronto_RealEstate_All.csv' into table re_all
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'Toronto_Detached_Homes.csv' into table re_detached_homes
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'Toronto_Freehold_Townhomes.csv' into table re_freehold_townhomes
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'Toronto_Condo_Townhomes.csv' into table re_condo_townhomes
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'Toronto_Condos.csv' into table re_condos
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'bank_rate_monthly.csv' into table bank_rate_monthly
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'bank_rate_weekly.csv' into table bank_rate_weekly
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'est_variable_mortgage_rate.csv' into table var_mortgage_rate
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'inflation.csv' into table inflation
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Ensure that tables have been properly populated

select * 
from re_all;

select * 
from re_detached_homes;

select * 
from re_freehold_townhomes;

select * 
from re_condo_townhomes;

select *
from re_condos;

select *
from bank_rate_monthly;

select *
from bank_rate_weekly;

select *
from var_mortgage_rate;

select *
from inflation;