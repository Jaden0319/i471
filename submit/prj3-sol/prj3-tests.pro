#!/usr/bin/env -S prolog

:- module('prj3_tests', []).

:- use_module('prj3-sol.pro').

%%%%%%%%%%%%%%%%%%%%%%%%%%%% get_divisible/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(get_divisible, [blocked('TODO')]).
test(three, [all(X == [[6, 3, 27]])]) :- 
    get_divisible([2, 1, 6, 5, 3, 8, 27, 2], 3, X).
test(five, [all(X == [[5, 5, 25]])]) :-
    get_divisible([5, 1, 6, 5, 3, 8, 25, 2], 5, X).    
test(none, [all(X == [[]])]) :-
    get_divisible([5, 1, 6, 5, 3, 8, 25, 2], 7, X).
:- end_tests(get_divisible).

%%%%%%%%%%%%%%%%%%%%%%%%%%% has_length_n_lists %%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(has_length_n_lists, [blocked('TODO')]).
test(len0_2, [nondet]) :-
    has_length_n_lists([], 2).
test(len1_2, [nondet]) :-
    has_length_n_lists([[a, b]], 2).
test(len2_2, [nondet]) :-
    has_length_n_lists([[a, b], [a, b, c, d]], 2).
test(len3_1, [nondet]) :-
    has_length_n_lists([[a, b], [a, b, c], [a, b, c, d]], 1).
test(len4_m1, [nondet]) :-
    has_length_n_lists([[a, b, c, d], [a, b, c], [a, b], [a]], -1).
test(len4_m1_fail, [fail]) :-
    has_length_n_lists([[a, b, c, d], [a, b, c], [a, b], [b, a]], -1).
:- end_tests(has_length_n_lists).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% poly_eval/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(poly_eval, [blocked('TODO')]).
test(empty2, [nondet, true(V =:= 0)]) :-
    poly_eval([], 2, V).
test(const2, [nondet, true(V =:= 5)]) :-
    poly_eval([5], 2, V).
test(linear2, [nondet, true(V =:= 19)]) :-
    poly_eval([5, 7], 2, V).
test(quadratic2, [nondet, true(V =:= 35)]) :-
    poly_eval([5, 7, 4], 2, V).
test(quartic2, [nondet, true(V =:= 67)]) :-
    poly_eval([5, 7, 4, 2, 1], 2, V).
test(quartic2_neg, [nondet, true(V =:= 7)]) :-
    poly_eval([5, 7, 4, 2, 1], -2, V).
test(quartic5, [nondet, true(V =:= 5 + 7*5 + 4*5^2 + 2*5^3 + 1*5^4)]) :-
    poly_eval([5, 7, 4, 2, 1], 5, V).
test(fail, [fail]) :-
    poly_eval([5, 7, 4], 2, 22).
:- end_tests(poly_eval).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% plus_expr/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(plus_expr, [blocked('TODO')]).
test(single, [nondet, true(V = a)]) :-
    plus_expr([a], V).
test(triple, [nondet, true(V = a + b + c)]) :-
    plus_expr([a, b, c], V).
test(num4, [nondet, true(V = 11 + 22 + 33 + 44)]) :-
    plus_expr([11, 22, 33, 44], V).
:- end_tests(plus_expr).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% poly_expr/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(poly_expr, [blocked('TODO')]).
test(const, [nondet, true(E = 5 * x**0)]) :-
    poly_expr([5], x, E).
test(linear, [nondet, true(E = 5*x**0 + 7*x**1)]) :-
    poly_expr([5, 7], x, E).
test(quadratic, [nondet, true(E = 5*x**0 + 7*x**1 + 4*x**2)]) :-
    poly_expr([5, 7, 4], x, E).
test(quartic, [nondet, true(E = 5*x**0 + 7*x**1 + 4*x**2 + 2*x**3 + 3*x**4)]) :-
    poly_expr([5, 7, 4, 2, 3], x, E).
test(quadratic_struct, [nondet, true(E = 5*f(x)**0 + 7*f(x)**1 + 4*f(x)**2)]) :-
    poly_expr([5, 7, 4], f(x), E).
test(quadratic_test, [nondet]) :-
    E = 5*x**0 + 7*x**1 + 4*x**2,
    poly_expr([5, 7, 4], x, E).
test(quadratic_fail, [fail]) :-
    E = 5*x**0 + (7*x**1 + 4*x**2),
    poly_expr([5, 7, 4], x, E).
:- end_tests(poly_expr).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% element_at/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(element_at, [blocked('TODO')]).
test(zero, [nondet, true(E = a)]) :-
    element_at([a, b, c], 0, E).
test(one, [nondet, true(E = b)]) :-
    element_at([a, b, c], 1, E).
test(two, [nondet, true(E = c)]) :-
    element_at([a, b, c], 2, E).
test(seven, [nondet, true(E = 7)]) :-
    element_at([1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ], 6, E).
test(instantiated, [nondet]) :-
    element_at([1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ], 6, 7).
test(fail, [fail]) :-
    element_at([1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ], 6, 6).
:- end_tests(element_at).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dag_path/4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dag1([edge(1, 2), edge(1, 3), edge(2, 4), edge(3, 4)]).
dag2(Dag2) :-
    dag1(Dag1), append([edge(0, 1), edge(4, 5)], Dag1, Dag2).

:- begin_tests(dag_path, [blocked('TODO')]).
test(dag1_path0, [set(Path = [[]])]) :-
    dag1(Dag1), 
    dag_path(Dag1, 2, 2, Path).
test(dag1_path1, [set(Path = [[edge(2, 4)]])]) :-
    dag1(Dag1), 
    dag_path(Dag1, 2, 4, Path).
test(dag1_path2, [set(Path = [[edge(1, 2), edge(2, 4)],
			 [edge(1, 3), edge(3, 4)]
			])]) :-
    dag1(Dag1), 
    dag_path(Dag1, 1, 4, Path).
test(dag2_path2, [set(Path = [[edge(1, 2), edge(2, 4)],
			 [edge(1, 3), edge(3, 4)]
			])]) :-
    dag2(Dag2), 
    dag_path(Dag2, 1, 4, Path).
test(dag2_path3, [set(Path = [[ edge(0, 1), edge(1, 2), edge(2, 4)],
			 [ edge(0, 1), edge(1, 3), edge(3, 4)]
			])]) :-
    dag2(Dag2), 
    dag_path(Dag2, 0, 4, Path).
test(dag2_path4,
     [set(Path = [[ edge(0, 1), edge(1, 2), edge(2, 4), edge(4, 5)],
		  [ edge(0, 1), edge(1, 3), edge(3, 4), edge(4, 5)]
		 ])]) :-
    dag2(Dag2), 
    dag_path(Dag2, 0, 5, Path).
test(dag1_fail0, [fail]) :-
    dag1(Dag1), 
    dag_path(Dag1, 2, 3, _Path).
test(dag2_fail1, [fail]) :-
    dag2(Dag2), 
    dag_path(Dag2, 3, 2, _Path).
:- end_tests(dag_path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% graph_path1/4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph1([edge(1, 2), edge(2, 1), edge(1, 3), edge(3, 1),
	edge(2, 4), edge(4, 2), edge(3, 4), edge(4, 3)]).
graph2(Graph2) :-
    graph1(Graph1), append([edge(0, 1), edge(4, 5)], Graph1, Graph2).

:- begin_tests(graph_path1, [blocked('TODO')]).
test(graph1_path0, [set(Path = [[]])]) :-
    graph1(Graph1), 
    graph_path1(Graph1, 2, 2, Path).
test(graph1_path1, [set(Path = [[edge(2, 4)],
			        [edge(2, 1), edge(1, 3), edge(3, 4)]])]) :-
    graph1(Graph1), 
    graph_path1(Graph1, 2, 4, Path).
test(graph1_path2, [set(Path = [[edge(1, 2), edge(2, 4)],
			 [edge(1, 3), edge(3, 4)]
			])]) :-
    graph1(Graph1), 
    graph_path1(Graph1, 1, 4, Path).
test(graph2_path2, [set(Path = [[edge(1, 2), edge(2, 4)],
			 [edge(1, 3), edge(3, 4)]
			])]) :-
    graph2(Graph2), 
    graph_path1(Graph2, 1, 4, Path).
test(graph2_path3, [set(Path = [[ edge(0, 1), edge(1, 2), edge(2, 4)],
			 [ edge(0, 1), edge(1, 3), edge(3, 4)]
			])]) :-
    graph2(Graph2), 
    graph_path1(Graph2, 0, 4, Path).
test(graph2_path4,
     [set(Path = [[ edge(0, 1), edge(1, 2), edge(2, 4), edge(4, 5)],
		  [ edge(0, 1), edge(1, 3), edge(3, 4), edge(4, 5)]
		 ])]) :-
    graph2(Graph2), 
    graph_path1(Graph2, 0, 5, Path).
test(graph1_fail0, [fail]) :-
    graph1(Graph1), 
    graph_path1(Graph1, 1, 4, [edge(1, 4)]).
test(graph2_fail1, [fail]) :-
    graph2(Graph2), 
    graph_path1(Graph2, 3, 2, [edge(3, 2)]).
:- end_tests(graph_path1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% graph_path2/4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(graph_path2, [blocked('TODO')]).
test(graph1_2_2_path0, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 2, 2, Path),
    Path = [],
    !.   %read ! as true
test(graph1_2_2_all_path2, [set(Path = [[edge(2, 1), edge(1, 2)],
			 	        [edge(2, 4), edge(4, 2)]])]) :-
    graph1(Graph1),
    Path = [_, _],
    graph_path2(Graph1, 2, 2, Path).
test(graph1_2_4_path1, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 2, 4, Path),
    Path = [edge(2, 4)],
    !.    
test(graph1_2_4_path2, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 2, 4, Path),
    Path = [edge(2, 1), edge(1, 3), edge(3, 4)],
    !.
test(graph1_2_4_path3, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 2, 4, Path),
    Path = [edge(2, 4), edge(4, 2), edge(2, 4)],
    !.
test(graph1_1_4_path1, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 1, 4, Path),
    Path = [edge(1, 2), edge(2, 4)],
    !.
test(graph1_1_4_path2, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 1, 4, Path),
    Path = [edge(1, 3), edge(3, 4)],
    !.
test(graph2_1_4_path1, [true]) :-
    graph2(Graph2),
    graph_path2(Graph2, 1, 4, Path),
    Path = [edge(1, 2), edge(2, 4)],
    !.
test(graph2_1_4_path2, [true]) :-
    graph2(Graph2),
    graph_path2(Graph2, 1, 4, Path),
    Path = [edge(1, 3), edge(3, 4)],
    !.
test(graph2_0_4_path1, [true]) :-
    graph2(Graph2),
    graph_path2(Graph2, 0, 4, Path),
    Path = [edge(0, 1), edge(1, 2), edge(2, 4)],
    !.    
test(graph2_0_4_path2, [true]) :-
    graph2(Graph2),
    graph_path2(Graph2, 0, 4, Path),
    Path = [edge(0, 1), edge(1, 3), edge(3, 4)],
    !.
test(graph2_0_5_path1, [true]) :-
    graph2(Graph2),
    graph_path2(Graph2, 0, 5, Path),
    Path = [edge(0, 1), edge(1, 2), edge(2, 4), edge(4, 5)],
    !.
test(graph2_0_5_path2, [true]) :-
    graph2(Graph2),
    graph_path2(Graph2, 0, 5, Path),
    Path = [edge(0, 1), edge(1, 3), edge(3, 4), edge(4, 5)],
    !.
test(graph1_fail0, [fail]) :-
    graph1(Graph1),
    Path =  [edge(1, 4)],
    graph_path2(Graph1, 1, 4, Path).
test(graph2_fail1, [fail]) :-
    graph2(Graph2),
    Path = [edge(3, 2)],
    graph_path2(Graph2, 3, 2, Path).
test(graph1_2_2_multi, [true]) :-
    graph1(Graph1),
    graph_path2(Graph1, 2, 2, Path),
    Path = [ edge(2, 4), edge(4, 2), edge(2, 1), edge(1, 2) ],
    !.
:- end_tests(graph_path2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% main/0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main :-
    current_prolog_flag(argv, Argv),
    %set_test_options([format(log)]),
    (length(Argv, 0) -> run_tests ; run_tests(Argv)).

:-initialization(main, main).
  
