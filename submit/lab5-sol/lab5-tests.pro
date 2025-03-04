#!/usr/bin/env -S prolog

:- module('prj3_tests', []).

:- use_module('lab5-sol.pro').

%%%%%%%%%%%%%%%%%%%%%%%%%%%% cons_list_car/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(cons_list_car, [blocked('TODO')]).
test(nil, [fail]) :-
    List = nil,
    cons_list_car(List, _).
test(simple, [all(Hd=[a])]) :-
    List = cons(a, _),
    cons_list_car(List, Hd).
test(multi, [all(X=[f(2)])]) :-
    List = cons(X, cons(_, _)),
    cons_list_car(List, f(2)).
test(backMatch, [all(X=[2])]) :-
    List = cons(f(2), _),
    cons_list_car(List, f(X)).
test(internal, [fail]) :-
    List = cons1(f(2), _),
    cons_list_car(List, f(_)).
:-end_tests(cons_list_car).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cons_list_cadr/2 %%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(cons_list_cadr, [blocked('TODO')]).
test(nil, [fail]) :-
    List = nil,
    cons_list_cadr(List, _).
test(oneElement, [fail]) :-
    List = cons(a, nil),
    cons_list_cadr(List, _Hd).
test(access, [all(X=[22])]) :-
    List = cons(_, cons(22, _)),
    cons_list_cadr(List, X).
test(backMatch, [all(X=[22])]) :-
    List = cons(_, cons(X, _)),
    cons_list_cadr(List, 22).
test(struct, [all(X=[33])]) :-
    List = cons(_, cons(f(X), _)),
    cons_list_cadr(List, f(33)).
:-end_tests(cons_list_cadr).

%%%%%%%%%%%%%%%%%%%%%%%%%%% cons_list_cddr/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(cons_list_cddr, [blocked('TODO')]).
test(nil, [fail]) :-
    List = nil,
    cons_list_cddr(List, _).
test(oneElement, [fail]) :-
    List = cons(a, nil),
    cons_list_cddr(List, _Hd).
test(access, [all(X=[22])]) :-
    List = cons(_, cons(_, 22)),
    cons_list_cddr(List, X).
test(backMatch, [all(X=[22])]) :-
    List = cons(_, cons(_, X)),
    cons_list_cddr(List, 22).
test(struct, [all(X=[33])]) :-
    List = cons(_, cons(_, f(X))),
    cons_list_cddr(List, f(33)).
:-end_tests(cons_list_cddr).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% caddr/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(caddr, [blocked('TODO')]).
test(empty, [fail]) :-
    List = [],
    caddr(List, _).
test(one, [fail]) :-
    List = [_],
    caddr(List, _).
test(two, [fail]) :-
    List = [_, _],
    caddr(List, _).
test(three, [all(X=[2])]) :-
    List = [_, _, 2],
    caddr(List, X).
test(four, [all(X=[2])]) :-
    List = [_, _, 2, _],
    caddr(List, X).
test(backStruct, [all(X=[2])]) :-
    List = [_, _, f(2)|_],
    caddr(List, f(X)).
:-end_tests(caddr).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cdar/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(cdar, [blocked('TODO')]).
test(empty, [fail]) :-
    List = [],
    cdar(List, _).
test(atom, [fail]) :-
    List = [a],
    cdar(List, _).
test(cdar_empty, [all(X=[ [] ])]) :-
    List = [[a]],
    cdar(List, X).
test(cdar_single, [all(X=[ [b] ])]) :-
    List = [[a, b]],
    cdar(List, X).
test(back_struct, [all(X=[ b ])]) :-
    List = [[a, f(b)]],
    cdar(List, [f(X)]).
:-end_tests(cdar).


%%%%%%%%%%%%%%%%%%%%%%%%%%% length_second/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(length_second, [blocked('TODO')]).
test(zero, [all(Len=[ 0 ])]) :-
    length_second([a, []], Len).
test(one, [all(Len=[ 1 ])]) :-
    length_second([a, [a]], Len).
test(multi, [all(Len=[ 3 ])]) :-
    length_second([a, [a, b, c], d, e, f], Len).
test(rest, [all(Len=[ 2 ])]) :-
    length_second([a, [a, b]|_], Len).
test(no_second, [fail]) :-
    length_second([a], _).
:-end_tests(length_second).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% area/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(area, [blocked('TODO')]).
test(rect_2_3, [all(A = [6])]) :-
    area(rect(2, 3), A).
test(circle, [all(A = [Pi])]) :-
    area(circle(1), A),
    Pi is pi.
test(circle2, [fail]) :-
    area(circle(2, 3), _).
:-end_tests(area).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sum_list/2/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(sum_list, [blocked('TODO')]).
test(sum2_empty, [all(Sum = [0])]) :-
    sum_list([], Sum).
test(sum2_123, [all(Sum = [6])]) :-
    sum_list([1, 2, 3], Sum).
test(sum3_123, [all(Sum = [11])]) :-
    sum_list([1, 2, 3], 5, Sum).
test(sum3_empty, [all(Sum = [5])]) :-
    sum_list([], 5, Sum).
:-end_tests(sum_list).
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sum_lengths/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(sum_lengths, [blocked('TODO')]).
test(empty, [all(Sum = [0])]) :-
    sum_lengths([], Sum).
test(empty_empty, [all(Sum = [0])]) :-
    sum_lengths([[]], Sum).
test(lens_123, [all(Sum = [6])]) :-
    sum_lengths([[1], [1, 2], [1, 2, 3]], Sum).
test(complex, [all(Sum = [8])]) :-
    sum_lengths([[1, 2], [3, [4, 5], 6], [7, 8], [9]], Sum).
:-end_tests(sum_lengths).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% main/0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main :-
    current_prolog_flag(argv, Argv),
    %set_test_options([format(log)]),
    (length(Argv, 0) -> run_tests ; run_tests(Argv)).

:-initialization(main, main).
  
