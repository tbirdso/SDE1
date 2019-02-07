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
	corner(Cur,Next,LH,NewCur,NewNext),
	sqRecurse(Ll,NewCur,NewNext,LT,Leftover),
	tailIsCorrect(Ll,LH),
	Len is Ll+1.	


corner(C,N,H,C2,N2) :-
	C \== H,
	C2 = N,
	nextClockwise(N,N2),
	C2 == H.

corner(C,N,H,C2,N2) :-
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
	subLen(Str,"u",SideLen,0,[]),
	subLen(Str,"r",SideLen,0,[]),
	subLen(Str,"d",SideLen,0,[]),
	subLen(Str,"l",SideLen,0,[]).


/* rctA/2
	Like sqA, but only parallel sides must have equal length
*/

rctA(Str,[]) :-
	sq(Str,[]),
	subLen(Str,"u",UpLen,0,[]),
	subLen(Str,"r",RightLen,0,[]),
	subLen(Str,"d",UpLen,0,[]),
	subLen(Str,"l",RightLen,0,[]).


/* grect/3
	Generate an AxB rectangle
*/

grect(A,B,C) :-
	A > 0,
	B > 0,
	gSide("l",B,0,[],S1),
	gSide("d",A,0,S1,S2),
	gSide("r",B,0,S2,S3),
	gSide("u",A,0,S3,C).


gSide(_,Target,Target,Start,Out) :-
	Out = Start.

gSide(Dir,Target,N,Start,Out) :-
	GLen is N+1,
	gSide(Dir,Target,GLen,Start,Out1),
	Out = [Dir|Out1].


/* m30A/3
	Like uA but with m30
*/

m30A(Len,[],[]) :-
	Len is 0.	

m30A(Len,[SH|ST],[]) :-
	m30A(Llen,ST,[]),
	SH == "m30",
	Len is Llen+1.


/* p240A/3
	Like uA but with p240
*/

p240A(Len,[],[]) :-
	Len is 0.

p240A(Len,[SH|ST],[]) :-
	p240A(Llen,ST,[]),
	SH == "p240",
	Len is Llen+1.


/* eqtriA/2
	Recognize equilateral triangle u^n m30^n p240^n
*/

eqtriA(Str,[]) :-
	tri(Str,"u",[]),
	subLen(Str,"u",SideLen,0,[]),
	subLen(Str,"m30",SideLen,0,[]),
	subLen(Str,"p240",SideLen,0,[]).

/* tri/3 = check whether string contains only triangle elements that are in the order u^i m30^j p240^k */

tri([],"p240",[]).

tri(["m30"|ST],"u",[]) :-
	tri(ST,"m30",[]).

tri(["p240"|ST],"m30",[]) :-
	tri(ST,"p240",[]).
	
tri([Dir|ST],Dir,[]) :-
	tri(ST,Dir,[]).


/* subLen/4 = get the length for the first occurance of a substring of repeated characters */

subLen([],_,Len,_,[]) :-
	Len is 0.

subLen([Dir|ST],Dir,Len,_,[]) :-
	subLen(ST,Dir,Llen,1,[]),
	Len is Llen+1.

subLen([SH|ST],Dir,Len,0,[]) :-
	SH \== Dir,
	subLen(ST,Dir,Len,0,[]).

subLen([SH|_],Dir,Len,1,[]) :-
	SH \== Dir,
	Len is 0.


/* one_shift/2
	Cycle list to the left by one position
*/

one_shift([A],[A]).

one_shift([FA,FB|FT],Out) :-
	one_shift([FA|FT],L),
	Out = [FB|L].


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
	sqA(Case,[]);
	try_all_sqA(Tail).


/* try_all_rctA/1
	Succeeds if some cyclic case of the list represents a rectangle
*/

try_all_rctA([Case|Tail]) :-
	rctA(Case,[]);
	try_all_rctA(Tail).

/* try_all_eqtriA/1
	Succeeds if some cyclic case of the list represents a triangle
*/

try_all_eqtriA([Case|Tail]) :-
	eqtriA(Case,[]);
	try_all_eqtriA(Tail).


