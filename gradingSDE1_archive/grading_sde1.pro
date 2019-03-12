/* grading_sde1.pro  
   script to grade CPSC/ECE 3520 Prolog SDE 1 Spring 2019
   some test data is in another file to be loaded AFTER student's SDE
   rev. 2-11-2019
*/ 

/* use of Prolog script for grading SDE 1:

1. Put this file ('grading_sde1.pro'), 'sde1_testing_data.pro' and 
   student's 'which_shape.pro' files in empty testing directory.
2. Start swipl; consult this file (?-['grading_sde1.pro'].).
3. Invoke goal 'gradeIt'. (the top-level goal)
4. Rename automatic log 'sde1_grading.log' to '<student-name>.testing.log
5. Total up points from assessment of log (80 max).
6. Grade remainder of submission using rubric in 'sde1-grading.pdf' and total points.
7. Post saved log and totaled grade.
*/

/* :-style_check(-singleton). */ /* disable singleton variable warnings in goals varaible if not printed */

goal_consult:- write('Evaluating SDE1'),nl,consult('which_shape.pro'), nl, 
               write('Prolog Source File Consulted'), nl,
               write('Noting Warnings and Errors'),nl,
               write('Consulting Datafile'), consult('sde1_testing_data.pro'),nl, 
               /* will have warnings above if overwrite assignment data in cmeans.pro */
               write('Consulting Testcases--'),nl. 

/* Note predicate invocations must ONLY succeed or fail; 
   if a Prolog syntax error is triggered there is 
   something fundamentally wrong with the student's implementation */

/* 13 predicates; 20 test cases */

/* predicates to test from Spring 2019 Assignment:
 
3.1 uA/3 (+) 
3.7 m30A/3 (+) 
3.3 sq/2 (+) 
3.4 sqA/2 (+) 
3.5 rctA/2 (+) 
3.8 eqtriA/2 (+) 
3.6 grect/3
4.1 one shift/2 
4.2 all shifts/4 
4.3 start shifts/2 
4.4 all cases/2 
4.5 try all sqA/1 
4.6 try all rctA/1 

13 total
*/


goal1 :- uA(L,["u","u","u"],[]),write(L).

goal2 :- uA(L,["u","u","d"],[]),write(L).

goal3 :- sq(["u","u","d","l"],[]).

goal4 :- sqA(["u","r","d","l"],[]).

goal5 :- sqA(["u","u","r","d","l"],[]).

goal6 :- sqA(["u","u","r","r","d","d","l","l"],[]).

goal7 :- rctA(["u","u","r","r","r","d","d","l","l"],[]).

goal8 :- rctA(["u","u","u","r","r","d","d","d","l","l"],[]).

goal9 :- eqtriA(["u","m30","p240"],[]).

goal10 :- eqtriA(["m30","p240","u"],[]).

goal11 :-  one_shift(["r","d","l","u"],W),write(W).

goal12 :- start_shifts(["r","d","l","u"],What),write(What).

goal13 :- all_cases(["u","r","d","l"],What),write(What).

goal14 :- all_cases(["u","u","u","r","r","d","d","d","l","l"],What), writeq(What).

goal15 :- grect(5,2,What), writeq(What).

goal16 :- grect(2,10,What), writeq(What).

/* 4 more; use mall_cases so no double jeopardy */

goal17 :- mall_cases(["u","r","r","d","d","l","l","u"],What),try_all_sqA(What).

goal18 :- mall_cases(["u","u","u","r","r","d","d","d","l","l"],What),
          try_all_sqA(What).

goal19 :-all_cases(["p240","p240","u","u","u","m30","m30","m30","p240"],What),
         try_all_eqtriA(What).

goal20 :- mall_cases(["d","d","d","d","l","l","u","u","u","u","r","r"],Cases),
          try_all_rctA(Cases).

/* invoking all goals */

goalList([
goal1,
goal2,
goal3,
goal4,
goal5,
goal6,
goal7,
goal8,
goal9,
goal10,
goal11,
goal12,
goal13,
goal14,
goal15,
goal16,
goal17,
goal18,
goal19,
goal20]).

allGoals([]) :- nl,write('Thats All Folks'),nl.
allGoals([A|B]) :- nl,write('===============>>>> current goal: '), write(A),nl,nl,
                   listing(A),call(A),nl,
                   write('goal: '), write(A), write('  ** succeeded ** '),nl,
                   nl,nl,allGoals(B),!.
allGoals([A|B]) :- nl,not(call(A)),write('goal: '), write(A), 
                   write('  ** failed **'),nl,nl,nl,allGoals(B).

gradeIt :- /* set_prolog_flag(color_term, false), fix unprintable chars */
           protocol('sde1_grading.log'), goal_consult, 
           goalList(A),allGoals(A),noprotocol.


