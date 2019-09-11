%  Discrete Optimization Specialization: MOOC "Basic Modeling for Discrete Optimization"
%  https://www.coursera.org/learn/basic-modeling
%  Assignment-3 "Dance trap"
%  By Romanko Vladimir, July 2019  

%  Version without finite automata (state machine)

%%%%%%%%%%   PARAMETERS

enum LEGS = {spin, leap, waltz, curtsey, prep, stand};
enum ARMS = {beckon, out, up, wrapped, neutral};
enum FACE = {smile, wink, batt, think, glow, blank};

par int: maxlen;
par set of int: STEP = 1..maxlen;
array[LEGS] of par int: maxlegs;
array[ARMS] of par int: maxarms;
array[FACE] of par int: maxface;
constraint assert(maxlegs[stand] >= maxlen, "maxlegs[stand] smaller than maxlen");
constraint assert(maxarms[neutral] >= maxlen, "maxarms[neutral] smaller than maxlen");
constraint assert(maxface[blank] >= maxlen, "maxface[blank] smaller than maxlen");
array[LEGS,ARMS] of par int: dance_value;
array[ARMS,FACE] of par int: entice_value;
constraint assert(dance_value[stand,neutral] = 0, "incorrect dance_value array");
constraint assert(entice_value[neutral,blank] = 0, "incorrect entice_value array");
par int: boredom; % how bored each step make the viewer

%%%%%%%%%%   VARIABLES

var 1..maxlen-1: len;   
var int: obj; 
array[STEP] of var LEGS: legs; 
array[STEP] of var ARMS: arms; 
array[STEP] of var FACE: face;

%%%%%%%%%%   CONSTRAINTS


include "global_cardinality_low_up_closed.mzn";
constraint obj = sum(i in 1..len) ( dance_value[legs[i],arms[i]] + entice_value[arms[i],face[i]] ) - boredom*len;
constraint global_cardinality_low_up_closed(legs, LEGS, [0,0,0,0,0,1], maxlegs);
constraint global_cardinality_low_up_closed(arms, ARMS, [0,0,0,0,1], maxarms);
constraint global_cardinality_low_up_closed(face, FACE, [0,0,0,0,0,1], maxface);

%          LEGS
constraint forall(i in 2..len where legs[i]=leap) ( legs[i-1] = prep );
constraint legs[1] != leap;
constraint forall(i in 1..len) (   (legs[i]=spin -> legs[i+1] in {curtsey,prep,stand})
/\  (legs[i]=leap -> legs[i+1] in {spin,waltz,stand})
/\  (legs[i]=curtsey -> legs[i+1]!=prep)    );
constraint forall(i in 1..len-2 where legs[i]=waltz /\ legs[i+1]=waltz /\ legs[i+2]=waltz) ( legs[i+3] != waltz );
constraint forall(i,j in 1..len where legs[i]=waltz /\ legs[j]=curtsey /\ i<j)
                 ( exists(k in i+1..j-1 )    (legs[k]=stand )  );  
                 
%          ARMS
constraint arms[1] != beckon;  
constraint forall(i in 2..len)  (          (arms[i]=beckon -> arms[i-1] in {out,up})
/\  (arms[i]=wrapped -> arms[i-1] in {beckon,neutral})         );
constraint forall(i in 1..len where arms[i]!=neutral) ( arms[i]!=arms[i+1] );

%          FACE
constraint forall(i in 1..len where face[i]!=blank) ( face[i]!=face[i+1] );
constraint forall(i in 2..len where face[i]=think)  ( face[i-1]!=smile /\ face[i-1]!=batt );

%          ILLEGAL COMBINATIONS
constraint forall(i in 1..len) ( dance_value[legs[i],arms[i]] >= 0 /\ entice_value[arms[i],face[i]] >=0 );

%          STAND-NEUTRAL-BLANK IN REST OF DANCE
constraint forall(i in len+1..maxlen)  ( legs[i]=stand /\ arms[i]=neutral /\ face[i]=blank );

%%%%%%%%%%   OPTIMIZATION CONDITION     

solve maximize obj;