#Find doctors that works in the same hospital but different specializations
create table t_doctors (id int,name varchar(30), speciality varchar(30), hospital varchar(30));
insert into t_doctors values(1,"doc_1","Skin","HOS_1");
insert into t_doctors values(2,"doc_2","ENT","HOS_2");
insert into t_doctors values(3,"doc_3","Gynecologist","HOS_3");
insert into t_doctors values(4,"doc_4","Dentist","HOS_3");
insert into t_doctors values(5,"doc_5","psychologist","HOS_4");
insert into t_doctors values(6,"doc_6","psychologist","HOS_4");

###input###
#  +------+-------+--------------+----------+
#  | id   | name  | speciality   | hospital |
#  +------+-------+--------------+----------+
#  |    1 | doc_1 | Skin         | HOS_1    |
#  |    2 | doc_2 | ENT          | HOS_2    |
#  |    3 | doc_3 | Gynecologist | HOS_3    |
#  |    4 | doc_4 | Dentist      | HOS_3    |
#  |    5 | doc_5 | psychologist | HOS_4    |
#  |    6 | doc_6 | psychologist | HOS_4    |
#  +------+-------+--------------+----------+

#  desired output

#  +------+-------+--------------+----------+
#  | id   | name  | speciality   | hospital |
#  +------+-------+--------------+----------+
#  |    4 | doc_4 | Dentist      | HOS_3    |
#  |    3 | doc_3 | Gynecologist | HOS_3    |
#  +------+-------+--------------+----------+

select
	doc1.id,doc1.name,doc1.speciality,doc1.hospital
from
	t_doctors doc1
inner join
	t_doctors doc2
on
	doc1.hospital = doc2.hospital
	and doc1.speciality <> doc2.speciality;

