

uA(Len) --> ["u"],uA(Ll),{Len is Ll+1}.
uA(Len) --> ["u"],{Len is 1}.


/*
uA(Len,[]) --> {Len is 0}.
uA(Len,[SH|ST]) --> [u],uA(Ll,),{Len is Ll+1}.
[u].
*/
