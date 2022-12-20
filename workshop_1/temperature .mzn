%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Workshop 1 "Temperature"
%  By Romanko Vladimir, July 2019   

%%%%%%%%%%   PARAMETERS

enum vybor = {heat, strongly_heat, cool, strongly_cool, do_nothing};
array[vybor] of par int: costs=[1,5,3,9,0];
array[vybor] of par int: temp_change=[1,4,-2,-5,0];
array[int] of par int: readings;
par int: start;
par int: l=length(readings);

%%%%%%%%%%   VARIABLES

array[1..l+1] of var 25..30: temp;  
var int: cost;
array[1..l] of var vybor: choice;

%%%%%%%%%%   CONSTRAINTS

constraint temp[1]=start;
constraint forall(i in 2..l+1) (temp[i]=(readings[i-1]+temp[i-1]) div 2 + temp_change[choice[i-1]]);
constraint cost=sum(i in 1..l) (costs[choice[i]]);

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve minimize cost;