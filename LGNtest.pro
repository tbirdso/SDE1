

uA(Len) --> ["u"],uA(Ll),{Len is Ll+1}.
uA(Len) --> ["u"],{Len is 1}.


/*
uA(Len,[]) --> {Len is 0}.
uA(Len,[SH|ST]) --> [u],uA(Ll,),{Len is Ll+1}.
[u].
*/


nt1, [b] --> a.
nt2 --> b.


/*
nt1(A,B) :-
	a(A,C),
	B=[b|C].
*/
