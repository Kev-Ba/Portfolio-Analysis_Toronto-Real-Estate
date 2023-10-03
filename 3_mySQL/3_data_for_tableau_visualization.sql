-- Ensure no duplicate view is created

drop view if exists v_br_mor_rate_weekly;

-- Weekly bank rate and variable mortgage rate into one view
-- TABLES used: Weekly Bank Rate + Weekly Variable Mortgage Rate

create view v_br_mor_rate_weekly as
select a.*, b.var_rate
from bank_rate_weekly a
join var_mortgage_rate b on a.vmr_lookup = b.id;

-- Check that view was created properly

select *
from v_br_mor_rate_weekly;

-- Ensure no duplicate view is created

drop view if exists v_br_inf_mor_rate_monthly;

-- Create a monthly view that combines bank rate, mortgage rate (averaged for the month), & inflation rate
-- TABLES used: bank_rate_monthly + inflation
-- VIEW used: v_br_mor_rate_weekly

create view v_br_inf_mor_rate_monthly as
select 
	a.*, 
    round(avg(b.var_rate),1) as var_mortgage, 
    c.total_cpi
from bank_rate_monthly a
join v_br_mor_rate_weekly b on a.id = b.brm_lookup
join inflation c on a.inf_lookup = c.id
group by a.id;

-- Check that view was created properly

select *
from v_br_inf_mor_rate_monthly;

/* Combine the different real estate type (condos, detached homes, etc.) tables, create a label for type of real estate, 
   and match the monthly bank rate, mortgage rate, and inflation rate with each line of data */
-- TABLES used: Condos + Condo Townhomes + Freehold Townhomes + Detached Homes
-- VIEW used: Monthly Bank Rate, Mortgage Rate, & Inflation

select 
	a.date,
    a.number_of_sales,
    a.avg_sold_price,
    a.days_on_market,
    a.above_below_asking_percent,
    c.bank_rate, 
    c.var_mortgage,
    c.total_cpi,
    round(((a.number_of_sales - lag(a.number_of_sales) over (order by a.id))/lag(a.number_of_sales) over (order by a.id)), 3) as sales_percent_change,
    round(((a.avg_sold_price - lag(a.avg_sold_price) over (order by a.id))/lag(a.avg_sold_price) over (order by a.id)), 3) as sold_percent_change,
    round(((a.days_on_market - lag(a.days_on_market) over (order by a.id))/lag(a.days_on_market) over (order by a.id)), 3) as days_percent_change,
    round(((bank_rate - lag(bank_rate) over (order by a.id))/lag(bank_rate) over (order by a.id)), 3) as br_percent_change,
    round(((var_mortgage - lag(var_mortgage) over (order by a.id))/lag(var_mortgage) over (order by a.id)), 3) as mortgage_percent_change,
    round(((total_cpi - lag(total_cpi) over (order by a.id))/lag(total_cpi) over (order by a.id)), 3) as cpi_percent_change,
    "Condos" as Type
from re_condos a
join re_all b on a.id = b.lookup_c
join v_br_inf_mor_rate_monthly c on b.lookup_brm = c.id
union 
select 
	a.date,
    a.number_of_sales,
    a.avg_sold_price,
    a.days_on_market,
    a.above_below_asking_percent,
    c.bank_rate, 
    c.var_mortgage,
    c.total_cpi,
    round(((a.number_of_sales - lag(a.number_of_sales) over (order by a.id))/lag(a.number_of_sales) over (order by a.id)), 3) as sales_percent_change,
    round(((a.avg_sold_price - lag(a.avg_sold_price) over (order by a.id))/lag(a.avg_sold_price) over (order by a.id)), 3) as sold_percent_change,
    round(((a.days_on_market - lag(a.days_on_market) over (order by a.id))/lag(a.days_on_market) over (order by a.id)), 3) as days_percent_change,
    round(((bank_rate - lag(bank_rate) over (order by a.id))/lag(bank_rate) over (order by a.id)), 3) as br_percent_change,
    round(((var_mortgage - lag(var_mortgage) over (order by a.id))/lag(var_mortgage) over (order by a.id)), 3) as mortgage_percent_change,
    round(((total_cpi - lag(total_cpi) over (order by a.id))/lag(total_cpi) over (order by a.id)), 3) as cpi_percent_change,
    "Condo Townhomes" as Type
from re_condo_townhomes a
join re_all b on a.id = b.lookup_ct
join v_br_inf_mor_rate_monthly c on b.lookup_brm = c.id
union
select 
	a.date,
    a.number_of_sales,
    a.avg_sold_price,
    a.days_on_market,
    a.above_below_asking_percent,
    c.bank_rate, 
    c.var_mortgage,
    c.total_cpi,
    round(((a.number_of_sales - lag(a.number_of_sales) over (order by a.id))/lag(a.number_of_sales) over (order by a.id)), 3) as sales_percent_change,
    round(((a.avg_sold_price - lag(a.avg_sold_price) over (order by a.id))/lag(a.avg_sold_price) over (order by a.id)), 3) as sold_percent_change,
    round(((a.days_on_market - lag(a.days_on_market) over (order by a.id))/lag(a.days_on_market) over (order by a.id)), 3) as days_percent_change,
    round(((bank_rate - lag(bank_rate) over (order by a.id))/lag(bank_rate) over (order by a.id)), 3) as br_percent_change,
    round(((var_mortgage - lag(var_mortgage) over (order by a.id))/lag(var_mortgage) over (order by a.id)), 3) as mortgage_percent_change,
    round(((total_cpi - lag(total_cpi) over (order by a.id))/lag(total_cpi) over (order by a.id)), 3) as cpi_percent_change,
    "Freehold Townhomes" as Type
from re_freehold_townhomes a
join re_all b on a.id = b.lookup_ft
join v_br_inf_mor_rate_monthly c on b.lookup_brm = c.id
union
select 
	a.date,
    a.number_of_sales,
    a.avg_sold_price,
    a.days_on_market,
    a.above_below_asking_percent,
    c.bank_rate, 
    c.var_mortgage,
    c.total_cpi,
    round(((a.number_of_sales - lag(a.number_of_sales) over (order by a.id))/lag(a.number_of_sales) over (order by a.id)), 3) as sales_percent_change,
    round(((a.avg_sold_price - lag(a.avg_sold_price) over (order by a.id))/lag(a.avg_sold_price) over (order by a.id)), 3) as sold_percent_change,
    round(((a.days_on_market - lag(a.days_on_market) over (order by a.id))/lag(a.days_on_market) over (order by a.id)), 3) as days_percent_change,
    round(((bank_rate - lag(bank_rate) over (order by a.id))/lag(bank_rate) over (order by a.id)), 3) as br_percent_change,
    round(((var_mortgage - lag(var_mortgage) over (order by a.id))/lag(var_mortgage) over (order by a.id)), 3) as mortgage_percent_change,
    round(((total_cpi - lag(total_cpi) over (order by a.id))/lag(total_cpi) over (order by a.id)), 3) as cpi_percent_change,
    "Detached Homes" as Type
from re_detached_homes a
join re_all b on a.id = b.lookup_dh
join v_br_inf_mor_rate_monthly c on b.lookup_brm = c.id;








