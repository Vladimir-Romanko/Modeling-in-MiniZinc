%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Assignment-1 "Sevenpaces" - solve the cryptarithm
%  By Romanko Vladimir, July 2019  

%%%%%%%%%%   PARAMETERS

%%%%%%%%%%   VARIABLES

var 1..9: B;
var 1..9: C;
var 0..9: E;
var 0..9: A;
var 0..9: N;
var 0..9: S;
var 0..9: R;
var 0..9: Y;
var 0..9: I;
var 0..9: G;

%%%%%%%%%%   CONSTRAINTS

include "alldifferent.mzn";
constraint alldifferent([B,C,E,A,N,S,R,Y,I,G]);
constraint (B*10000+E*1000+A*100+N*10+S)*2=C*100000+R*10000+Y*1000+I*100+N*10+G;

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve satisfy;