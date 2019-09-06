%%%%%%%      TUNNEL MODEL
enum PIVOT = {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12};
par PIVOT: first = p5;
par set of int: POS = 1..card(PIVOT);
array[PIVOT] of par int: coord = [0,3,7,10,16,18,21,25,28,32,35,40];
par int: m =  4 ; 
par set of int: PREC = 1..m;
array[PREC] of PIVOT: left = [p2,p8,p7,p6];   % ZAMKI
array[PREC] of PIVOT: right = [p6,p3,p4,p8];  % KLU4I
%%%%%%%
array[POS] of var PIVOT: travel;    var int: obj;
%%%%%%%
include "globals.mzn";
constraint travel[1] = first;
constraint alldifferent(travel);
constraint obj = sum(i in 2..card(PIVOT)) (abs(coord[travel[i]] - coord[travel[i-1]]));
% constraint forall(i in PREC)  (travel[left[i]] < travel[right[i]]  );
constraint sum(i,j in POS, prec in PREC where i<j /\ travel[j]=left[prec])
( travel[i]=right[prec] ) = m;




solve minimize obj;
