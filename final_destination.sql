###find the final destination for each traveller

##input

##       +------+--------+-------------+
##       | t_id | origin | destination |
##       +------+--------+-------------+
##       |    1 | DIB    | GHY         |
##       |    1 | GHY    | KOL         |
##       |    2 | GHY    | DEL         |
##       |    1 | KOL    | BLR         |
##       |    3 | BLR    | GHY         |
##       |    3 | GHY    | DIB         |
##       |    3 | DIB    | SHLG        |
##       +------+--------+-------------+

##output
##       +------+--------+-------------+
##       | t_id | origin | destination |
##       +------+--------+-------------+
##       |    1 | DIB    | BLR         |
##       |    2 | GHY    | DEL         |
##       |    3 | BLR    | SHLG        |
##       +------+--------+-------------+


with origins as (
select
    o.t_id,o.origin
from
    t_travellers o
left join
    t_travellers d
on
    o.t_id = d.t_id
    and o.origin = d.destination
where
    d.origin is null
),
destinations as (
select
    o.t_id,o.destination
from
    t_travellers o
left join
    t_travellers d
on
    o.t_id = d.t_id
    and o.destination = d.origin
where
    d.destination is null
)

select
    origins.t_id,origins.origin,destinations.destination
from
    origins
inner join
    destinations
on
    origins.t_id = destinations.t_id
order by 1;