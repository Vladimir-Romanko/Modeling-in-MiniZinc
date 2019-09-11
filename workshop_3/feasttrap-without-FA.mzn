%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Workshop 3 "Feast Trap" -- Create the most magnificient feast 
%  By Romanko Vladimir, July 2019  

%  Version without finite automata (state machine)

%%%%%%%%%%   PARAMETERS

par int: len;  
enum DISH;   
enum TASTE = {spicy, sour, salty, sweet, umame, bland};
enum TEMP = {hot, cold, warm};
array[DISH] of par TASTE: taste;
array[DISH] of par TEMP: temp;  
array[DISH] of par bool: heavy;
array[DISH] of par int: value;   
par set of int: COURSE = 1..len;

%%%%%%%%%%   VARIABLES

array[COURSE] of var DISH: dish;
var int: obj;

%%%%%%%%%%   CONSTRAINTS

include "alldifferent.mzn";
constraint alldifferent(dish);
constraint obj = sum(d in dish)  (value[d])   +   len - 1   
                 +  sum(i in 1..len-1)  ( temp[dish[i]] != temp[dish[i+1]] )
                 +  sum(i in 1..len-1)  ( heavy[dish[i]] != heavy[dish[i+1]] );
constraint forall(i in 1..len-1)  ( taste[dish[i]] != taste[dish[i+1]] );
constraint taste[dish[1]] = salty;        constraint taste[dish[len]] = sweet;

constraint forall(i in 1..len-1 where taste[dish[i]]=spicy)   ( taste[dish[i+1]] in {sweet, bland} );
constraint forall(i in 1..len-1 where taste[dish[i]]=sour)   ( taste[dish[i+1]] = bland \/ taste[dish[i+1]] = umame );
constraint forall(i in 1..len-1 where taste[dish[i]]=sweet)   ( taste[dish[i+1]] != spicy /\ taste[dish[i+1]] != umame );
constraint forall(i in 1..len-1 where temp[dish[i]]=hot)   ( temp[dish[i+1]] != cold );

constraint forall(i in 1..len-2 where heavy[dish[i]]=true /\ heavy[dish[i+1]]=true)   ( heavy[dish[i+2]]=false );

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve maximize obj;