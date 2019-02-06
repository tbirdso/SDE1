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

uA(Length,Leftover,Leftover) :-
	Length is 0.


uA(Length,[SH|ST],Leftover) :-
	uA(Llength,ST,Leftover),
	SH == "u",
	Length is Llength+1.


/* rA
	Parse string for sequence of "r" and if succeeds indicates length
*/

rA(L,Leftover,Leftover) :- L is 0.

rA(L,[LH|LT],A) :-
	rA(Ll,LT,A),
	LH == "r",
	L is Ll+1.


/* dA
	Parse string for sequence of "d" and if succeeds indicates length
*/

dA(L,Leftover,Leftover) :- L is 0.

dA(L,[LH,LT],A) :-
	dA(Ll,LT,A),
	LH == "d",
	L is Ll+1.


/* lA
	Parse string for sequence of "l" and if succeeds indicates length
*/

lA(L,Leftover,Leftover) :- L is 0.

lA(L,[LH|LT],A) :-
	lA(Ll,LT,A),
	LH == "l",
	L is Ll+1.


/* sq
	Succeeds if In is a string list representing u^n r^m d^l l^p with string Leftover leftover.
*/

sq(Leftover,Leftover).

sq(Str,Leftover) :-
	up(Prev),
	nextClockwise(Prev,Next),
	sqRecurse(Length,Prev,Next,Str,Leftover).
	

sqRecurse(Len,Cur,Next,Leftover,Leftover) :-
	Len is 0.

sqRecurse(Len,Cur,Next,[LH|LT],Leftover) :-
	validateEdge(Cur,Next,LH,NewCur,NewNext),
	sqRecurse(Ll,NewCur,NewNext,LT,Leftover),
	tailIsCorrect(Ll,LH),
	Len is Ll+1.	


validateEdge(C,N,H,C2,N2) :-
	C \== H,
	C2 = N,
	nextClockwise(N,N2),
	C2 == H.

validateEdge(C,N,H,C2,N2) :-
	C == H,
	C2 = C,
	N2 = N.


tailIsCorrect(Len,Tail) :-
	Len == 0,
	Tail == "l".

tailIsCorrect(Len,Tail) :-
	Len > 0.


nextClockwise(In,Val) :-
	In == "u",
	right(Val).
nextClockwise(In,Val) :-
	In == "r",
	down(Val).
nextClockwise(In,Val) :-
	In == "d",
	left(Val).
nextClockwise(In,Val) :-
	In == "l",
	up(Val).


/* sqA
	Succeeds if In is a string list representing u^n r^n d^n l^n with string Leftover leftover

*/

sqA(Leftover,Leftover).

sqA(Str,Leftover) :-
	up(Prev),
	nextClockwise(Prev,Next).


sqARecurse(Len,Cur,Next,Leftover,Leftover,CU,CR,CD,CL) :-
	Len is 0.

sqARecurse(Len,Cur,Next,[LH|LT],Leftover,CU,CR,CD,CL) :-
	validateEdge(Cur,Next,LH,NewCur,NewNext),
	isCorner(LH,Cur,NewCur,Corner),
	sqARecurse(L1,NewCur,NewNext,LT,leftover),
	tailIsCorrect(Ll,LH),
	Len is Ll+1.
	edgeLength(H,CU,CR,CD,CL,Cu,Cr,Cd,Cl).

/*
edgeLength(H,CU,CR,CD,CL,Cu,Cr,Cd,Cl) :-
	Up(H),
	Right(H),
	Down(H),
	Left(H),
*/
	



isCorner(H,C,C2,Corner) :-
	C == H,
	Corner = 0.

isCorner(H,C,C2,Corner) :-
	C2 == H,
	Corner = 1.













