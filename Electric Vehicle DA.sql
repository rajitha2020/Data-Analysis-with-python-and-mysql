select * from electric_vehicle limit 10;

#find top 10 state with electric vehicle usage percentage
with top_States as
(
	select state,count(state)  as state_count
	from electric_vehicle
	group by state
),
total_State_count as
(
    select 
    count(state) as total_state
    from electric_vehicle    
)
select state,
state_count/total_state*100 as percent_statewise
from top_States
join total_State_count
order by percent_statewise DESC
limit 10 ;

#find top 10 make which are having heighest sale in electric vehicle
select make,count(make) as sale_count
from electric_vehicle
group by make
order by total_count DESC
limit 10;

# for the year 2022 and 2023 find the top 1 selling make with sale count
with model_count as(
	select make,model_year,
	count(make) over(partition by model_year,make) as rn
	from electric_vehicle
	where model_year in (2022,2023)
) 
select model_year,make,rn as sale_count
 from model_count
 group by rn 
 order by rn DESC
 limit 2;
 
#get percentage of each type of electric vehicle
with type_count as(
	select electric_vehicle_type,count(electric_vehicle_type) as user_count
	from electric_vehicle 
	group by electric_vehicle_type
), 
total_type_count as(
select 
    count(electric_vehicle_type) as total_count
    from electric_vehicle   
)
select electric_vehicle_type,
user_count/total_count*100 as type_percentage 
from type_count
join total_type_count;
 
# get deatils of top 5 base_msrp vehicle
select * 
from electric_vehicle
group by base_msrp
order by base_msrp DESC
limit 5;
