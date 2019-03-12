/* for SDE 1 (prolog)  */

/* necessary for last 4 goals so students are not in double jeopardy */

/* assume length of A is > 0 */

mstart_shifts(A,R) :- length(A,L), mall_shifts(A,R,L,1).

mall_shifts(_,[],L,L):- !.  /* finished */

mall_shifts(A,[RH|RT],L,S) :- S < L, one_shift(A,RH), S1 is S+1, mall_shifts(RH,RT,L,S1).

mall_cases(A,Cases) :- mstart_shifts(A,R), append([A],R,Cases).

