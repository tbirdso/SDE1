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

uA(Length) --> ["u"],uA(Ll),!,{Length is Ll+1}.
uA(Length) --> ["u"],{Length is 1}.


/* rA
	Parse string for sequence of "r" and if succeeds indicates length
*/

rA(Length) --> ["r"],rA(Ll),!,{Length is Ll+1}.
rA(Length) --> ["r"],{Length is 1}.

/* dA
	Parse string for sequence of "d" and if succeeds indicates length
*/

dA(Length) --> ["d"],dA(Ll),!,{Length is Ll+1}.
dA(Length) --> ["d"],{Length is 1}.

/* lA
	Parse string for sequence of "l" and if succeeds indicates length
*/

lA(Length) --> ["l"],lA(Ll),!,{Length is Ll+1}.
lA(Length) --> ["l"],{Length is 1}.


/* sq
	Succeeds if In is a string list representing u^n r^m d^l l^p with string Leftover leftover.
*/

sq --> uA(_),rA(_),dA(_),lA(_).


/* sqA
	Succeeds if In is a string list representing u^n r^n d^n l^n with string Leftover leftover

*/

sqA --> uA(L),rA(L),dA(L),lA(L).


/* rctA/2
	Like sqA, but only parallel sides must have equal length
*/

rctA --> uA(M),rA(N),dA(M),lA(N).


/* grect/3
	Generate an AxB rectangle
*/

grect(A,B,C) :-
	A > 0,
	B > 0,
	gSide("l",B,0,[],S1),
	gSide("d",A,0,S1,S2),
	gSide("r",B,0,S2,S3),
	gSide("u",A,0,S3,C),
	!.


gSide(_,Len,Len) --> [].

gSide(Dir,Len,CurLen), [Dir] --> 
	{GLen is CurLen+1},
	gSide(Dir,Len,GLen).

/* m30A/3
	Like uA but with m30
*/

m30A(Len) --> ["m30"],m30A(Ll),!,{Len is Ll+1}.
m30A(Len) --> ["m30"],{Len is 1}.


/* p240A/3
	Like uA but with p240
*/

p240A(Len) --> ["p240"],p240A(Ll),!,{Len is Ll+1}.
p240A(Len) --> ["p240"],{Len is 1}.


/* eqtriA/2
	Recognize equilateral triangle u^n m30^n p240^n
*/

eqtriA --> uA(N),m30A(N),p240A(N).


/* one_shift/2
	Cycle list to the left by one position
*/

one_shift([A],[A]).

one_shift([FA,FB|FT],Out) :-
	one_shift([FA|FT],L),
	Out = [FB|L],
	!.


/* all_shifts/4
	Returns list of all list cycles except A
*/

all_shifts(A,R,1,1) :-
	R = A.

all_shifts(_,R,L,L) :-
	R = [].

all_shifts(A,R,L,S) :-
	one_shift(A,B),
	Ss is S+1,
	all_shifts(B,Rr,L,Ss),
	R = [B|Rr],
	!.


/* start_shifts/2
	Returns list of all list cycles except L
*/

start_shifts(L,AS) :-
	length(L,Len),
	all_shifts(L,AS,Len,1).


/* all_cases/2
	Returns list of all list cycles including A
*/

all_cases(A,R) :-
	start_shifts(A,Rr),
	R = [A|Rr].


/* try_all_sqA/1
	Succeeds if some cyclic case of the list represents a square
*/

try_all_sqA([Case|Tail]) :-
	sqA(Case,[]),write("cyclic shift: "),writeq(Case),write(" is a square."),!;
	try_all_sqA(Tail).


/* try_all_rctA/1
	Succeeds if some cyclic case of the list represents a rectangle
*/

try_all_rctA([Case|Tail]) :-
	rctA(Case,[]),write("cyclic shift: "),writeq(Case),write(" is a rectangle."),!;
	try_all_rctA(Tail).


/* try_all_eqtriA/1
	Succeeds if some cyclic case of the list represents a triangle
*/

try_all_eqtriA([Case|Tail]) :-
	eqtriA(Case,[]),write("cyclic shift: "),writeq(Case),write(" is a triangle."),!;
	try_all_eqtriA(Tail).


