#2nd highest paid employees from each department. Create a new column with that value.
#in case 2nd highest is not there then populate with the top salary

create table t_employees (e_id int, name varchar(40), salary decimal(10,2), dept varchar(20));
insert into t_employees values (1,"Mridul Gohain", 180000,"Data Engineering");
insert into t_employees values (2,"Richard Deka", 170000,"Data Engineering");
insert into t_employees values (3,"Priyanku Medhi", 140000,"Data Engineering");
insert into t_employees values (4,"Chandrasmita Hazarika", 150000,"Finance");
insert into t_employees values (5,"John D", 280000,"Analytics");
insert into t_employees values (6,"Swetha Dullipalli", 280000,"Data Engineering");
insert into t_employees values (7,"Vikram Dutt", 140000,"Finance");
insert into t_employees values (8,"Harshitha", 100000,"HR");
insert into t_employees values (9,"Korabi Handique", 90000,"HR");
insert into t_employees values (10,"Triveni MS", 90000,"HR");
insert into t_employees values (11,"Chetan K Yadav", 120000,"HR");
###   input data
###   +------+-----------------------+-----------+------------------+
###   | e_id | name                  | salary    | dept             |
###   +------+-----------------------+-----------+------------------+
###   |    2 | Richard Deka          | 170000.00 | Data Engineering |
###   |    3 | Priyanku Medhi        | 140000.00 | Data Engineering |
###   |    4 | Chandrasmita Hazarika | 150000.00 | Finance          |
###   |    5 | John D                | 280000.00 | Analytics        |
###   |    6 | Swetha Dullipalli     | 280000.00 | Data Engineering |
###   |    7 | Vikram Dutt           | 140000.00 | Finance          |
###   |    8 | Harshitha             | 100000.00 | HR               |
###   |    9 | Korabi Handique       |  90000.00 | HR               |
###   |   10 | Triveni MS            |  90000.00 | HR               |
###   |   11 | Chetan K Yadav        | 120000.00 | HR               |
###   |    1 | Mridul Gohain         | 180000.00 | Data Engineering |
###   +------+-----------------------+-----------+------------------+

## Desired output

#   +------+-----------------------+-----------+------------------+-----------------+
#   | e_id | name                  | salary    | dept             | 2nd_high_salary |
#   +------+-----------------------+-----------+------------------+-----------------+
#   |    5 | John D                | 280000.00 | Analytics        |       280000.00 |
#   |    6 | Swetha Dullipalli     | 280000.00 | Data Engineering |       180000.00 |
#   |    1 | Mridul Gohain         | 180000.00 | Data Engineering |       180000.00 |
#   |    2 | Richard Deka          | 170000.00 | Data Engineering |       180000.00 |
#   |    3 | Priyanku Medhi        | 140000.00 | Data Engineering |       180000.00 |
#   |    4 | Chandrasmita Hazarika | 150000.00 | Finance          |       140000.00 |
#   |    7 | Vikram Dutt           | 140000.00 | Finance          |       140000.00 |
#   |   11 | Chetan K Yadav        | 120000.00 | HR               |       100000.00 |
#   |    8 | Harshitha             | 100000.00 | HR               |       100000.00 |
#   |    9 | Korabi Handique       |  90000.00 | HR               |       100000.00 |
#   |   10 | Triveni MS            |  90000.00 | HR               |       100000.00 |
#   +------+-----------------------+-----------+------------------+-----------------+

# Approach 1 :: using nth value analytical function
select
    e_id,name,salary,dept,
    coalesce(nth_value(salary,2) over(partition by dept order by salary desc
    rows between unbounded preceding and unbounded following), salary) as 2nd_high_salary
from t_employees