%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Assignment 4 "Royal hunt"
%  By Romanko Vladimir, August 2019  

%%%%%%%%%%   PARAMETERS

int: n; % number of court members
set of int: COURT = 1..n;
int: emperor = 1;
array[COURT] of int: rank;
array[COURT] of int: ability;
int: m; % number of horses
set of int: HORSE = 1..m;
array[HORSE] of int: beauty;
array[HORSE] of int: speed;
array[COURT,HORSE] of int: enjoy;

%%%%%%%%%%   VARIABLES

array[COURT] of var 0..m: horse; 
array[HORSE] of var 0..n: court;
var int: obj;
var int: penalty;

%%%%%%%%%%   CONSTRAINTS

include "globals.mzn";
constraint if n>=m then global_cardinality(horse, [i | i in HORSE],  [1 | i in HORSE])
else global_cardinality_low_up_closed(horse, [i | i in HORSE], [0 | i in HORSE], [1 | i in HORSE])   endif;
constraint obj = sum(c in COURT where horse[c]!=0)  ( enjoy[c, horse[c]] ) - penalty*100;
constraint forall(c in COURT where horse[c]!=0)  ( enjoy[c, horse[c]] >= 0 );
constraint max(c in COURT where horse[c]!=0 /\ c!=emperor)  ( enjoy[c, horse[c]]) < enjoy[emperor, horse[emperor]];

constraint forall(c1,c2 in COURT where c1!=c2) ( rank[c1]>rank[c2] -> (beauty[horse[c1]]>=beauty[horse[c2]] \/ horse[c2]=0  ) );
constraint penalty = sum(h1,h2 in HORSE where h1!=h2) ( not(speed[h1]>speed[h2] -> (ability[court[h1]]>=ability[court[h2]] \/ court[h1]=0)) );

constraint forall(c in COURT where horse[c]!=0) ( court[horse[c]] = c );
constraint forall(h in HORSE where court[h]!=0) ( horse[court[h]] = h );

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve maximize obj;

%%%%%%%%%%   OUTPUT FORMAT

output ["horse = \(horse);\nobj = \(obj);"];