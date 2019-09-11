%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Workshop 4 "Composition"
%  By Romanko Vladimir, August 2019   

%  Composition First

%%%%%%%%%%   PARAMETERS

par int: n = 20;
par set of int: PLACES = 1..n;  
par set of int: NOTES = 1..n;

%%%%%%%%%%   VARIABLES

array[PLACES] of var NOTES: order;  
array[1..n-1] of var 1..n-1: diffs;

%%%%%%%%%%   CONSTRAINTS

include "alldifferent.mzn";
constraint alldifferent(order);
constraint forall(i in 1..n-1)  ( diffs[i]=abs(order[i+1]-order[i])  );
constraint alldifferent(diffs);

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve satisfy;