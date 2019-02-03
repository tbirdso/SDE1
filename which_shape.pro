/*
	Name: 	Tom Birdsong
	Course: ECE 3520
	Term:	Spring 2019
	Due:	Feb 28th
*/

/* Basic Facts */

up("u").
down("d").
left("l").
right("r").




/* Predicates */

uA(Length,[],Leftover) :-
	Length is 0.


uA(Length,[SH|ST],Leftover) :-
	uA(Llength,ST,Leftover),
	SH == "u",
	Length is Llength+1.


