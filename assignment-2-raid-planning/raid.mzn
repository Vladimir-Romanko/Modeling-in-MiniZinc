%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Assignment 2 "Raid planning"
%  By Romanko Vladimir, July 2019  

%%%%%%%%%%   PARAMETERS

par int: l; 
par int: u;    
par int:  m;
enum CLAN; 
enum WARRIOR;
par WARRIOR: dummy;
array[CLAN, CLAN] of par int: hates;  
array[WARRIOR] of par int: strength;
array[WARRIOR] of par CLAN: clan;

%%%%%%%%%%   VARIABLES

array[1..u] of var WARRIOR: raid; 
var int: obj;

%%%%%%%%%%   CONSTRAINTS

constraint sum(i in raid where i!=dummy) (1) >= l;
constraint sum(i,j in raid where i<j /\ i!=dummy /\ j!=dummy) (hates[clan[i],clan[j]]) <= m;
constraint obj = sum(i in raid where i!=dummy) (strength[i]);
constraint forall(i in 1..u-1) ((raid[i]!=dummy) + raid[i] <=  raid[i+1]);

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve maximize obj;

%%%%%%%%%%   OUTPUT FORMAT

output ["raid = {"] ++ [if fix(raid[i]) != dummy then show(raid[i])
++ if i < u /\ fix(raid[i+1]) != dummy then ", " else "" endif
else "" endif | i in 1..u ] ++ ["};\nobj = \(obj)"];