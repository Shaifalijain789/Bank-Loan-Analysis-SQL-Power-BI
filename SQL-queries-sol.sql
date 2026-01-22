#Create a database
create database bankloandb;

#Using Database
use bankloandb;

#Create a table
create table bank_loan_data(
id int primary key, 
address_state varchar(50),
application_type varchar(50), 
emp_length varchar(50), 
emp_title varchar(100),
grade varchar(50),
home_ownership varchar(50),
issue_date date,
last_credit_pull_date varchar(100),
last_payment_date date,
loan_status varchar(50),
next_payment_date date,
member_id int,
purpose varchar(50),
sub_grade varchar(50),
term varchar(50),
verification_status varchar(50),
annual_income float,
dti float,
installment float,
int_rate float,
loan_amount int, 
total_acc tinyint,
total_payment int
);

#Import data from csv to table by using data table import wizard

#KPI

#Total Loan Applicants
select count(id) as Total_Loan_Application from bank_loan_data;

#Month-To-Date
select  count(id) as  MTD_Total_Loan_Application from bank_loan_data 
where  month(issue_date)=12 and year(issue_date)=2021;

#Month-To-Month
select  count(id) as  PMTD_Total_Loan_Application from bank_loan_data 
where  month(issue_date)=11 and year(issue_date)=2021;

#Total Funded Amount
select sum(loan_amount) as Total_Funded_Amount from bank_loan_data;

#Total Funded Amount Month-To-Date
select  sum(loan_amount) as  MTD_Total_Funded_amount from bank_loan_data 
where  month(issue_date)=12 and year(issue_date)=2021;

#Total Funded Amount Previous-Month-To-Date
select  sum(loan_amount) as  MTD_Total_Funded_amount from bank_loan_data 
where  month(issue_date)=11 and year(issue_date)=2021;

#Total  Amount Received 
select sum(total_payment) as Total_Amount_Received from bank_loan_data;

#Total Amount Recevied Month-to-Date
select  sum(total_payment) as  MTD_Total_amount_Received from bank_loan_data 
where  month(issue_date)=12 and year(issue_date)=2021;

#Total Amount Recieved Previous-Month-To-Date
select  sum(total_payment) as  PMTD_Total_amount_Received from bank_loan_data 
where month(issue_date)=11 and year(issue_date)=2021;

#Average Interest Rate
select Round(Avg(int_rate)*100,3) as Average_Interest_Rate from bank_loan_data;

#Average Interest Rate Month-to-Date
select  Round(Avg(int_rate)*100,3) as MTD_Average_Interest_Rate from bank_loan_data 
where  month(issue_date)=12 and year(issue_date)=2021;

#Average Interest Rate Previous-Month-To-Date
select  Round(Avg(int_rate)*100,3) as PMTD_Average_Interest_Rate from bank_loan_data 
where month(issue_date)=11 and year(issue_date)=2021;

#Average Debt-to-Income Ratio (DTI) 
select Round(Avg(dti)*100,3) as Average_DTI from bank_loan_data;

#Average Debt-to-Income Ratio (DTI) Month-To_Date
select  Round(Avg(dti)*100,3) as MTD_DTI from bank_loan_data 
where  month(issue_date)=12 and year(issue_date)=2021;

#Average Debt-to-Income Ratio (DTI) Previous-Month-To-Date
select  Round(Avg(dti)*100,3) as PMTD_DTI from bank_loan_data 
where month(issue_date)=11 and year(issue_date)=2021;


#GOOD LOAN VS BAD LOAN

#Good Loan Percentage
select 
count(case when loan_status='Fully Paid' or loan_status='Current' then id  end) *100 /count(id) as Good_Loan_Percentage
from bank_loan_data;

#Good Loan Application
select 
count(case when loan_status='Fully Paid' or loan_status='Current' then id  end)  Good_Loan_Application
from bank_loan_data;

#Good Loan Funded Amount
select 
sum(case when loan_status='Fully Paid' or loan_status='Current' then loan_amount end)  Good_Loan_Funded_Amount
from bank_loan_data;

#Good Loan Total Recieved Amount
select 
sum(case when loan_status='Fully Paid' or loan_status='Current' then total_payment end)  Good_Loan_Funded_Amount
from bank_loan_data;

#Bad Loan Percentage
select 
count(case when loan_status='Charged Off' then id  end) *100 /count(id) as Bad_Loan_Percentage
from bank_loan_data;

#Bad Loan Application
select 
count(case when loan_status='Charged Off' then id  end)  Bad_Loan_Application
from bank_loan_data;

#Bad Loan Funded Amount
select 
sum(case when loan_status='Charged Off' then loan_amount end)  Bad_Loan_Funded_Amount
from bank_loan_data;

#Bad Loan Total Amount Received
select
sum(case when loan_status='Charged Off' then total_payment end)  Bad_Loan_Amount_Received
from bank_loan_data;

#LOAN STATUS

#Summary  Of The Loan Status
select 
   loan_status,
   count(id) as Total_Loan_Application,
   sum(total_payment) as Total_Amount_Received,
   sum(loan_amount) as Total_Funded_Amount,
   round(avg(int_rate *100),3) as Interest_Rate,
   round(avg(dti *100),3) as DTI
   from bank_loan_data
   group by loan_status;
   
#Summary of the Loan Status for Month-To-Date
select 
    loan_status,
    sum(total_payment) as MTD_Total_Amount_Received,
    sum(loan_amount) as MTD_Total_Funded_Amount
    from bank_loan_data
    where month(issue_date)=12
    group by loan_status;
    

#DASHBOARD 2

#Monthly Trend by Issue Date

select 
   month(issue_date) as Month_Number,
   monthname(issue_date) as Month_Name,
   count(id) as Total_Loan_Application,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount
   from bank_loan_data
   group by monthname(issue_date),month(issue_date)
   order by Month_Number;
   
#Regional Analysis by State
select 
    address_state,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Received_Amount
    from bank_loan_data
    group by address_state
    order by count(id) desc;
    
#Long Term Analysis
select 
    term,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Received_Amount
    from bank_loan_data
    group by term
    order by term;
    
#Employee length Analysis
select 
    emp_length,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Received_Amount
    from bank_loan_data
    group by emp_length
    order by count(id);
    
#Loan Purpose Breakdown
select
    purpose,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Received_Amount
    from bank_loan_data
    group by purpose
    order by count(id) desc;
    
#Home Ownership Analysis
select
    home_ownership,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Received_Amount
    from bank_loan_data
    group by home_ownership
    order by count(id) desc;



      






