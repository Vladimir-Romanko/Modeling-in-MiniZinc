%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Workshop 2 "Surrender" - select a set of trade negotiation party
%  By Romanko Vladimir, July 2019   

%%%%%%%%%%   PARAMETERS

par int: l;  
par int: u;  
par int: m;  
enum NEGOTIATOR;
par NEGOTIATOR: dummy;  
par int: LEN=length(NEGOTIATOR);
array[NEGOTIATOR] of par int: honor;
array[NEGOTIATOR, NEGOTIATOR] of par int: joint;

%%%%%%%%%%   VARIABLES

array[1..u] of var NEGOTIATOR: party;
var int: strength;
var int: obj;

%%%%%%%%%%   CONSTRAINTS

constraint forall(i in 1..u-1 where party[i]!=dummy) (party[i]<party[i+1]); 
constraint sum(i in party where i!=dummy) (1)>=l;
constraint strength=sum(i,j in party where i<j) (joint[i,j]);
constraint strength >= m;
constraint obj=min(i in party where i!=dummy) (honor[i]);

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve maximize obj;