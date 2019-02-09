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

uA(Length) --> ["u"],uA(Ll),{Length is Ll+1}.
uA(Length) --> ["u"],{Length is 1}.


/* rA
	Parse string for sequence of "r" and if succeeds indicates length
*/

rA(Length) --> ["r"],rA(Ll),{Length is Ll+1}.
rA(Length) --> ["r"],{Length is 1}.

/* dA
	Parse string for sequence of "d" and if succeeds indicates length
*/

dA(Length) --> ["d"],dA(Ll),{Length is Ll+1}.
dA(Length) --> ["d"],{Length is 1}.

/* lA
	Parse string for sequence of "l" and if succeeds indicates length
*/

lA(Length) --> ["l"],lA(Ll),{Length is Ll+1}.
lA(Length) --> ["l"],{Length is 1}.


/* sq
	Succeeds if In is a string list representing u^n r^m d^l l^p with string Leftover leftover.
*/

sq --> uA(_),rA(_),dA(_),lA(_).

/*
sq --> [].
sq --> {nextClockwise("u",N)},sqRecurse(_,"u",N).
*/

/* sqRecurse/5: recurse through list and make sure it represents a square */

sqRecurse(Len,_,_) --> {Len is 0}.

sqRecurse(Len,Cur,Next) --> 
	(corner(Cur,Next,NewCur,NewNext),
	 sqRecurse(Ll,NewCur,NewNext),
	 tailIsCorrect(Ll,LH,Leftover)
	),[].

/*
sqRecurse(Len,_,_,Leftover,Leftover) :-
	Len is 0.

sqRecurse(Len,Cur,Next,[LH|LT],Leftover) :-
	corner(Cur,Next,LH,NewCur,NewNext),
	sqRecurse(Ll,NewCur,NewNext,LT,Leftover),
	tailIsCorrect(Ll,LH),
	Len is Ll+1.	
*/

/* corner/5: if recursion encounters a corner in the square then rotate to accept the new edge */
corner(C,N,N,N2,N,Leftover) :-
	C \== N,
	nextClockwise(N,N2).

corner(C,N,C,N,C,Leftover).


/* tailIsCorrect/2: make sure tail of square ends in "l" */
tailIsCorrect(0,"l","l").

tailIsCorrect(Len,_,_) :-
	Len > 0.


/* nextClockwise/2: return next side from a 90-degree clockwise rotation */
nextClockwise("u","r").
nextClockwise("r","d").
nextClockwise("d","l").
nextClockwise("l","u").


/* sqA
	Succeeds if In is a string list representing u^n r^n d^n l^n with string Leftover leftover

*/



sqA([],[]).

sqA(Str,Leftover) :-
	sq(Str,Leftover),
	subLen("u",SideLen,0,Str,[]),
	subLen("r",SideLen,0,Str,[]),
	subLen("d",SideLen,0,Str,[]),
	subLen("l",SideLen,0,Str,[]).


/* rctA/2
	Like sqA, but only parallel sides must have equal length
*/

rctA(Str,Leftover) :-
	sq(Str,Leftover),
	subLen("u",UpLen,0,Str,[]),
	subLen("r",RightLen,0,Str,[]),
	subLen("d",UpLen,0,Str,[]),
	subLen("l",RightLen,0,Str,[]).


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


gSide(_,Len,Len) --> [].
gSide(Dir,Len,CurLen), [Dir] --> 
	{GLen is CurLen+1},
	gSide(Dir,Len,GLen).

/* m30A/3
	Like uA but with m30
*/

m30A(Len) --> ["m30"],m30A(Ll),{Len is Ll+1}.
m30A(Len) --> ["m30"],{Len is 1}.


/* p240A/3
	Like uA but with p240
*/

p240A(Len) --> ["p240"],p240A(Ll),{Len is Ll+1}.
p240A(Len) --> ["p240"],{Len is 1}.


/* eqtriA/2
	Recognize equilateral triangle u^n m30^n p240^n
*/

eqtriA(Str,[]) :-
	tri("u",Str,[]),
	subLen("u",SideLen,0,Str,[]),
	subLen("m30",SideLen,0,Str,[]),
	subLen("p240",SideLen,0,Str,[]).


/* tri/3 = check whether string contains only triangle elements that are in the order u^i m30^j p240^k */

tri(Dir) --> [Dir],tri(Dir).
tri("u") --> ["m30"],tri("m30").
tri("m30") --> ["p240"],tri("p240").
tri("p240") --> [].


/* subLen/4 = get the length for the first occurance of a substring of repeated characters */

subLen(_,Len,_,Leftover,Leftover) :-
	Len is 0.

subLen(Dir,Len,_,[Dir|ST],Leftover) :-
	subLen(Dir,Llen,1,ST,Leftover),
	Len is Llen+1.

subLen(Dir,Len,0,[SH|ST],Leftover) :-
	SH \== Dir,
	subLen(Dir,Len,0,ST,Leftover).

subLen(Dir,Len,1,[SH|_],_) :-
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


