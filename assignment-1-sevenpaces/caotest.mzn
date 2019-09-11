%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Assignment 1 "Sevenpaces" - solve the cryptarithm
%  By Romanko Vladimir, July 2019  

%%%%%%%%%%   PARAMETERS

%%%%%%%%%%   VARIABLES

var 1..9: C;
var 0..9: A;
var 0..9: O;
var 1..9: Z;
var 0..9: H;
var 0..9: I;
var 1..9: P;
var 1..9: T;
var 0..9: E;
var 0..9: S;

%%%%%%%%%%   CONSTRAINTS

include "alldifferent.mzn";
constraint alldifferent([C,A,O,Z,H,I,P,T,E,S]);
constraint (C*100+A*10+O)*2+100*Z+10*H+I+P*10+I = T*1000+E*100+S*10+T;
constraint O=0;
constraint P=3*Z;

%%%%%%%%%%   OPTIMIZATION CONDITION 

solve satisfy;