[1mtrue.[0m

uA(Len,["u","u","u","u"],[]).


Len = 4 [1m.[0m

uA(Len,["u","u","r","u"],[]).


[1;31mfalse.[0m

uA(Len,["u","u","r"],[]).


[1;31mfalse.[0m

rA(Len,["r","r"],[]).


Len = 2 
Unknown action:  (h for help)
Action? [
Unknown action: [ (h for help)
Action? A
Unknown action: A (h for help)
Action? [1m.[0m

rA(Len,[],[]).


[1;31mfalse.[0m

rA(Len,["u","u","u"],[]).


[1;31mfalse.[0m

dA(Len,["d","d","r","d"],[]).


[1;31mfalse.[0m

dA(Len(["d","d","d"],[]).


[31;1mERROR: Syntax error: Operator expected
ERROR: dA(Le
ERROR: ** here **
ERROR: n(["d","d","d"],[]) . 
[0mdA(Len,["d","d","d"],[]).


Len = 3 [1m.[0m

dA(Len,["d","d","d","r"],[]).


[1;31mfalse.[0m

lA(Len,["l","l","l"],[]).


Len = 3 [1m.[0m

lA(Len,["u","l","l"],[]).


[1;31mfalse.[0m

lA(Len,["l","l","u"],[]).


[1;31mfalse.[0m

sq(["u","r","d","l"],[]).


[1mtrue [0m[1m.[0m

sq(["u","r","d","l","l","l","l","l"],[]).


[1mtrue [0m[1m.[0m

sq(["u","d","r","l"],[]).


[1;31mfalse.[0m

sqA(["u","r","d","l"],[]).


[31;1mERROR: Undefined procedure: subLen/4
ERROR:   However, there are definitions for:
ERROR:         subLen/5
ERROR: 
ERROR: In:
ERROR:    [9] subLen(["u","r"|...],"u",_5514,0)
ERROR:    [8] sqA(["u","r"|...],[]) at /home/tbirdso/ECE352/SDE1/which_shape.pro:97
ERROR:    [7] <user>
[0m   [1;35mException: [0m(9) subLen(["u", "r", "d", "l"], "u", _5630, 0) ? nno debug
consult("which_shape.pro").


[1mtrue.[0m

sqA(["u","r","d","l"],[]).


[1mtrue [0m[1m.[0m

sqA(["u","u","u","r","r","r","d","d","d","l"],[]).


[1;31mfalse.[0m

sqA(["u","u","u","r","r","r","d","d","d","l","l","l"],[]).


[1mtrue [0m[1m.[0m

rctA(["u","r","d","l"],[]).


[31;1mERROR: Undefined procedure: subLen/4
ERROR:   However, there are definitions for:
ERROR:         subLen/5
ERROR: 
ERROR: In:
ERROR:    [9] subLen(["u","r"|...],"u",_512,0)
ERROR:    [8] rctA(["u","r"|...],[]) at /home/tbirdso/ECE352/SDE1/which_shape.pro:109
ERROR:    [7] <user>
[0m   [1;35mException: [0m(9) subLen(["u", "r", "d", "l"], "u", _616, 0) ? Unknown option (h for help)
   [1;35mException: [0m(9) subLen(["u", "r", "d", "l"], "u", _616, 0) ? [Unknown option (h for help)
   [1;35mException: [0m(9) subLen(["u", "r", "d", "l"], "u", _616, 0) ? Aalternatives
[1m [14] [0mtailIsCorrect(0, '<garbage_collected>')
[1m [14] [0msqRecurse(0, "l", "u", [], [])
[1m [14] [0mcorner("d", "l", "l", _646, _648)
[1m [13] [0mcorner("r", "d", "d", _646, _648)
[1m [12] [0mcorner("u", "r", "r", _646, _648)
   [1;35mException: [0m(9) subLen(["u", "r", "d", "l"], "u", _616, 0) ? nno debug
consult("which_shape.pro").


[1mtrue.[0m

rctA(["u","r","d","l"],[]).


[1mtrue [0m[1m.[0m

rctA(["u","u","u","r","d","d","d","l"],[]).


[1mtrue [0m[1m.[0m

rctA(["u","u","r","r","d","l"],[]).


[1;31mfalse.[0m

grect(2,2,A).


A = ["u", "u", "r", "r", "d", "d", "l", "l"] [1m.[0m

grect(3,1,A).


A = ["u", "u", "u", "r", "d", "d", "d", "l"] [1m.[0m

grect(0,0,A).


[1;31mfalse.[0m

m30A(Len,["m30","m30","m30"],[]).


Len = 3 
Unknown action:  (h for help)
Action? [
Unknown action: [ (h for help)
Action? A
Unknown action: A (h for help)
Action? [1m.[0m

m30A(Len,["m30","m30","m30","u"],[]).


[1;31mfalse.[0m

m30A(Len,["p240","m30","m30","m30"],[]).


[1;31mfalse.[0m

p240A(Len,["p240","p240","p240"],[]).


Len = 3 [1m.[0m

p240A(Len,["p240","p240","p240","r"],[]).


[1;31mfalse.[0m

p240A(Len,[],[]).


[1;31mfalse.[0m

eqtriA(["u","u","m30","m30","p240","p240"],[]).


[1mtrue [0m[1m.[0m

eqtriA(["u","u","m30","m30","p240"],[]).


[1;31mfalse.[0m

eqtriA(["u","u","m30","m30"],[]).


[1;31mfalse.[0m

one_shift(["u","m30","p240"],Out).


Out = ["m30", "p240", "u"] [1m.[0m

one_shift(["u","d"],Out).


Out = ["d", "u"] [1m.[0m

one_shift(["u"],Out).


Out = ["u"] i
Unknown action: i (h for help)
Action? 
Unknown action:  (h for help)
Action? [
Unknown action: [ (h for help)
Action? C
Unknown action: C (h for help)
Action? [1m.[0m

one_shift(["u","l"],Out).


Out = ["l", "u"] [1m.[0m

one_shift(["u",