/*
	Name: 	Tom Birdsong
	Course: ECE 3520
	Term:	Spring 2019
	Due:	Feb 28th
*/

/* Basic Fact */

up("u").
left("l").
right("r").
down("d").


/* Predicates */

/* uA
	Parse string for sequence of "u" and if succeeds indicates length

	L - Length
	[SH|ST] - String
	Leftovers
*/

uA(Length,[],[]) :-
	Length is 0.


uA(Length,[SH|ST],[]) :-
	uA(Llength,ST,[]),
	SH == "u",
	Length is Llength+1.


/* rA
	Parse string for sequence of "r" and if succeeds indicates length
*/

rA(L,[],[]) :- L is 0.

rA(L,["r"|LT],[]) :-
	rA(Ll,LT,[]),
	L is Ll+1.


/* dA
	Parse string for sequence of "d" and if succeeds indicates length
*/

dA(L,[],[]) :- L is 0.

dA(L,["d",LT],[]) :-
	dA(Ll,LT,[]),
	L is Ll+1.


/* lA
	Parse string for sequence of "l" and if succeeds indicates length
*/

lA(L,[],[]) :- L is 0.

lA(L,["l"|LT],[]) :-
	lA(Ll,LT,[]),
	L is Ll+1.


/* sq
	Succeeds if In is a string list representing u^n r^m d^l l^p with string Leftover leftover.
*/

sq([],[]).

sq(Str,[]) :-
	up(Prev),
	nextClockwise(Prev,Next),
	sqRecurse(_,Prev,Next,Str,[]).
	

/* sqRecurse/5: recurse through list and make sure it represents a square */
sqRecurse(Len,_,_,[],[]) :-
	Len is 0.

sqRecurse(Len,Cur,Next,[LH|LT],Leftover) :-
	cur(Cur,Next,LH,NewCur,NewNext),
	sqRecurse(Ll,NewCur,NewNext,LT,Leftover),
	tailIsCorrect(Ll,LH),
	Len is Ll+1.	


cur(C,N,H,C2,N2) :-
	C \== H,
	C2 = N,
	nextClockwise(N,N2),
	C2 == H.

cur(C,N,H,C2,N2) :-
	C == H,
	C2 = C,
	N2 = N.

/* tailIsCorrect/2: make sure tail of square ends in "l" */

tailIsCorrect(Len,Tail) :-
	Len == 0,
	Tail == "l".

tailIsCorrect(Len,_) :-
	Len > 0.


nextClockwise("u","r").
nextClockwise("r","d").
nextClockwise("d","l").
nextClockwise("l","u").


/* sqA
	Succeeds if In is a string list representing u^n r^n d^n l^n with string Leftover leftover

*/

sqA([],[]).

sqA(Str,[]) :-
	sq(Str,[]),
	uEdge(Str,SideLen),	
	rdlEdge(Str,SideLen).


/* uEdge/2: Bind length of initial "u" vector */
uEdge([],_) :- false.

uEdge([SH],Len) :-
	SH \== "u",
	Len is 0.

uEdge([SH|_],Len) :-
	SH \== "u",
	Len is 0.

uEdge([SH|ST],Len) :-
	SH == "u",
	uEdge(ST,Llen),
	Len is Llen+1.


/* verifyEdgeLen(Str,Dir,IsSubstr,Target,CurLen,Leftover) */

verifyEdgeLen([],_,0,_,_,[]).

verifyEdgeLen([],_,1,Target,Target,[]).

verifyEdgeLen([SH|ST],Dir,0,Target,CurLen,[]) :-
	SH \== Dir,
	verifyEdgeLen(ST,Dir,0,Target,CurLen,[]).


verifyEdgeLen([Dir|ST],Dir,0,Target,_,[]) :-
	verifyEdgeLen(ST,Dir,1,Target,1,[]).
	

verifyEdgeLen([SH|_],Dir,1,Target,CurLen,[]) :-
	SH \== Dir,
	CurLen == Target.

verifyEdgeLen([Dir|ST],Dir,1,Target,CurLen,[]) :-
	NewLen is CurLen+1,
	verifyEdgeLen(ST,Dir,1,Target,NewLen,[]).


rdlEdge([SH|ST],Len) :-
	verifyEdgeLen([SH|ST],"r",0,Len,0,[]),
	verifyEdgeLen([SH|ST],"d",0,Len,0,[]),
	verifyEdgeLen([SH|ST],"l",0,Len,0,[]).




















