/*
	Name: 	Tom Birdsong
	Course: ECE 3520
	Term:	Spring 2019
	Due:	Feb 28th
*/


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

rA(L,[],A) :- L is 0.

rA(L,[LH|LT],A) :-
	rA(Ll,LT,A),
	LH == "r",
	L is Ll+1.


/* dA
	Parse string for sequence of "d" and if succeeds indicates length
*/

dA(L,[],A) :- L is 0.

dA(L,[LH,LT],A) :-
	dA(Ll,LT,A),
	LH == "d",
	L is Ll+1.


/* lA
	Parse string for sequence of "l" and if succeeds indicates length
*/

lA(L,[],A) :- L is 0.

lA(L,[LH|LT],A) :-
	lA(Ll,LT,A),
	LH == "l",
	L is Ll+1.


/* sq
	Succeeds if In is a string list representing u^n r^m d^l l^p with string Leftover leftover.
*/

sq(Leftover,Leftover).

sq([LH,LT],Leftover) :-
	LH == "u",
	

sqRecurse(prev,next,[LH,LT],Leftover) :-
	cur(prev,next,LH),
	sqRecurse(LT,Leftover).	

cur(p,n,H) :-
	p == H.

cur(p,n,H) :-
	n == H,
	n is p,
	NextClockwise(n,val),
	n is val.

NextClockwise("u",val) :-
	val is "r".
NextClockwise("r",val) :-
	val is "d".
NextClockwise("d",val) :-
	val is "l".
NextClockwise("l",val) :-
	val is "u".

















