%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Workshop 3 "Feast Trap" -- Create the most magnificient feast 
%  By Romanko Vladimir, July 2019  

%  Version with finite automata (state machine)

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
array[1..7, TASTE] of par 0..7: d =
[| 0, 0, 4, 0, 0, 0
 | 0, 0, 0, 5, 0, 7
 | 0, 0, 0, 0, 6, 7
 | 2, 3, 0, 5, 6, 7
 | 0, 3, 4, 0, 0, 7
 | 2, 3, 4, 5, 0, 7
 | 2, 3, 4, 5, 6, 0 |];
array[1..2, TEMP] of par 0..2: td =
[| 1, 0, 2
 | 1, 2, 2 |];

%%%%%%%%%%   VARIABLES

array[COURSE] of var DISH: dish; 
var int: obj;

%%%%%%%%%%   CONSTRAINTS

include "alldifferent.mzn"; 
include "regular.mzn";
constraint alldifferent(dish);
constraint obj = sum(d in dish)  (value[d])   +   len - 1   
                 +  sum(i in 1..len-1)  ( (temp[dish[i]] != temp[dish[i+1]]) + (heavy[dish[i]] != heavy[dish[i+1]]));
                 
constraint regular([taste[i] | i in dish], 7, 6, d, 1, {5});                 
constraint regular([temp[i] | i in dish], 2, 3, td, 2, {1,2});   

constraint forall(i in 1..len-2 where heavy[dish[i]]=true /\ heavy[dish[i+1]]=true)   ( heavy[dish[i+2]]=false );

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve maximize obj;