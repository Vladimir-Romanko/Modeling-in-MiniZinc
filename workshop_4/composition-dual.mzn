%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Workshop 4 "Composition"
%  By Romanko Vladimir, August 2019   

%  Composition Dual

%%%%%%%%%%   PARAMETERS

par int: n = 20;
par set of int: PLACES = 1..n;    
par set of int: NOTES = 1..n;

%%%%%%%%%%   VARIABLES

array[PLACES] of var NOTES: order; 
array[NOTES] of var PLACES: posn;
array[1..n-1] of var 1..n-1: diffs; 
array[1..n-1] of var 1..n-1: dposn;

%%%%%%%%%%   CONSTRAINTS

include "globals.mzn";
constraint forall(i in 1..n-1)  ( diffs[i]=abs(order[i+1]-order[i])  );
constraint inverse(order, posn);    
constraint inverse(diffs, dposn);
constraint abs(posn[1]-posn[n]) = 1;
constraint dposn[n-1] = min(posn[1], posn[n]);

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve satisfy;