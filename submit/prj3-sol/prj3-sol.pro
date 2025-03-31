#!/usr/bin/env -S swipl
%-*- mode: prolog; -*-

:- module(prj3_sol,  [
     get_divisible/3, has_length_n_lists/2, poly_eval/3, plus_expr/2,
     poly_expr/3, element_at/3, dag_path/4, graph_path1/4, graph_path2/4
   ]).


/*********************** IMPORTANT RESTRICTIONS ************************/

/*

You may make use of the binary operators `=` (unify), `\=` (not
unify), `=:=` (number equality), `=\=` (number inequality), `\+`
(negation-by-failure), is/2, arithmetic operators, append/3, member/2,
length/2 but are *not* allowed to use any other features or built-in
Prolog procedures.  Violating this restriction will result in a zero
on that exercise.

You are not allowed to use any of Prolog's higher-order features or
extra-logical control features like or, cut, if-then. Violating this
restriction will result in a *zero grade* for the *entire project*.

Unless stated otherwise, you may introduce auxiliary helper
procedures.

*/


% #1: "10-points"
% get_divisible(IntList, N, DivList): DivList is a sub-list of
% those elements of integer list IntList which are divisible by
% integer N.
% The elements in DivList must be in the same order in which they occur
% in IntList.
% Hints: A mod B results in the modulus of A wrt B when used
% in an arithmetic context.
get_divisible(_IntList, _N, _DivList) :- 'TODO'.

% #2: "10-points"
% has_length_n_lists(Lists, N): Lists is a list of lists
% such that the length of the next list is N + the length
% of the previous list.
has_length_n_lists(_Lists, _N) :- 'TODO'.

% #3: "10-points"
% poly_eval(Coeffs, X, Eval): Given a numeric list Coeffs of
% polynomial coefficients [ C_0, C_1, C_2, ... ], Eval
% matches the value of the polynomial at X, namely
% C_0*X^0 + C_1*X^1 + C_2*X^2 + C_3*X^3.
% *Restriction*: must be tail-recursive and cannot use exponentiation.
% Hint: use an auxiliary procedure.
poly_eval(_Coeffs, _X, _Eval) :- 'TODO'.


% #4: "10-points"
% plus_expr(Terms, AddExpr): Given a non-empty list Terms of Prolog
% terms T1, T2, ..., Tn, AddExpr matches T1 + T2 + ... + Tn.
% *Hint*: + is left-associative.
plus_expr(_Terms, _AddExpr) :- 'TODO'.

% #5: "10-points"
% poly_expr(Coeffs, X, Poly): Given a non-empty list of coefficients
% C1, C2], ..., CN and some
% Prolog term X, Poly is the expression:
% C1*X**0 + C2*X**1 + ... + CN*X**(N - 1)
% Hint: structure your code as for plus_expr/2.
poly_expr(_Coeffs, _X, _Poly) :- 'TODO'.

% #6: "15-points"
% element_at(List, Index, Element): List is a list whose Index
% (0-origin) element matches Element.
% *Must* be implemented using a *single* rule (where a fact counts as a
% rule). Hence it cannot be recursive.
% *Hint*: use a single rule containing calls to Prolog built-in procedures.
element_at(_List, _Index, _Element) :- 'TODO'.

%% A graph is represented as a list of edges where an edge is
%% represented as a structure edge(From, To) representing an edge from
%% node From to node To.  

% #7: "10-points"
% dag_path(Dag, From, To, Path): Path is a list of edges specifying a
% path from node From to node To in DAG Dag.  It should be assumed
% that Dag, From, To are ground (no variables).
% The implementation *must* take advantage of the fact that Dag is a
% DAG.
dag_path(_Dag, _From, _To, _Path) :- 'TODO'.

% #8: "15-points"
% graph_path1(Graph, From, To, Path): Path is a list of edges
% specifying an acyclic path from node From to node To in unrestricted
% graph Graph.  It should be assumed that Graph, From, To are ground
% (no variables).
% *Must* be implemented by tracking previously visited nodes to prevent
% getting caught up within cycles in Graph.
graph_path1(_Graph, _From, _To, _Path) :- 'TODO'.

% #9: "10-points"
% graph_path2(Graph, From, To, Path): Path is a list of edges from node
% From to node To in unrestricted graph Graph.  It should be assumed
% that Graph, From, To are ground (no variables).
% *Must* be implemented without tracking previously visited nodes.
% *Hint*: a small variation of dag_path/4.
graph_path2(_Graph, _From, _To, _Path) :- 'TODO'.

