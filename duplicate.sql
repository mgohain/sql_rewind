#1.Find duplicates
#Note :: A record is duplicate if name salary and organization is same
create table _employees (e_id int, f_name varchar(20), m_name varchar(20), l_name varchar(20), salary decimal(10,2), org varchar(20));
insert into _employees values (1,"Mridul", null ,"Gohain", 180000, "Walmart");
insert into _employees values (2,"Mridul", null ,"Gohain", 180000, "Walmart");
insert into _employees values (3,"Mridul", null ,"Gohain", 180000, "Luxoft");
insert into _employees values (4,"Richard", "Kashyap" ,"Deka", 180000, "Publicis Sapient");
insert into _employees values (5,"Priyanku", null ,"Medhi", 180000, "GE");
insert into _employees values (6,"Priyanku", null ,"Medhi", 180000, "GE");
insert into _employees values (7,"Priyanku", null ,"Medhi", 180000, "GE");
insert into _employees values (8,"Pankaj", null ,"Saikai", 180000, "Walmart");


# +------+----------+---------+--------+-----------+------------------+
# | e_id | f_name   | m_name  | l_name | salary    | org              |
# +------+----------+---------+--------+-----------+------------------+
# |    1 | Mridul   | NULL    | Gohain | 180000.00 | Walmart          |
# |    2 | Mridul   | NULL    | Gohain | 180000.00 | Walmart          |
# |    3 | Mridul   | NULL    | Gohain | 180000.00 | Luxoft           |
# |    4 | Richard  | Kashyap | Deka   | 180000.00 | Publicis Sapient |
# |    5 | Priyanku | NULL    | Medhi  | 180000.00 | GE               |
# |    6 | Priyanku | NULL    | Medhi  | 180000.00 | GE               |
# |    7 | Priyanku | NULL    | Medhi  | 180000.00 | GE               |
# +------+----------+---------+--------+-----------+------------------+

#out put should be

# +----------+--------+--------+-----------+---------+-----------+
# | f_name   | m_name | l_name | salary    | org     | dup_count |
# +----------+--------+--------+-----------+---------+-----------+
# | Priyanku | NULL   | Medhi  | 180000.00 | GE      |         2 |
# | Mridul   | NULL   | Gohain | 180000.00 | Walmart |         1 |
# +----------+--------+--------+-----------+---------+-----------+

#Approach 1 :: Using row_number()
select
    temp.f_name,temp.m_name,temp.l_name,temp.salary,temp.org,
    count(1) as dup_count
from (
    select
        *,
        row_number() over(partition by concat(`f_name`,`m_name`,`l_name`),salary,org) as rn
    from
        _employees
) temp
where
	temp.rn>1
group by
	temp.f_name,temp.m_name,temp.l_name,temp.salary,temp.org;

#Approach 2 :: Using Simple group by
select * from (
    select
        temp.f_name,temp.m_name,temp.l_name,temp.salary,temp.org,
        count(1)-1 as dup_count
    from
        _employees temp
    group by
        temp.f_name,temp.m_name,temp.l_name,temp.salary,temp.org
) a
where
    a.dup_count >=1;
