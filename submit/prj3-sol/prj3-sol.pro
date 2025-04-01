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

Unless stated otherwise, you may introduce auxiliary aux
procedures.

*/

% #1: "10-points"
% get_divisible(IntList, N, DivList): DivList is a sub-list of
% those elements of integer list IntList which are divisible by
% integer N.
% The elements in DivList must be in the same order in which they occur
% in IntList.
% Hints: A mod B results in the modulus of A wrt B when used
% in an arithmetic context. Done
get_divisible(IntList, N, DivList) :-
  get_divisible_aux(IntList, N, DivList).

get_divisible_aux([], _, []).

get_divisible_aux([H|T], N, [H|Rest]) :-
  0 is H mod N,
  get_divisible_aux(T, N, Rest).

get_divisible_aux([H|T], N, Rest) :-
  H mod N =\= 0,
  get_divisible_aux(T, N, Rest). 

% #2: "10-points"
% has_length_n_lists(Lists, N): Lists is a list of lists
% such that the length of the next list is N + the length
% of the previous list.
has_length_n_lists(Lists, N) :-
  has_length_n_lists_aux(Lists, N).

has_length_n_lists_aux([],_).
has_length_n_lists_aux([_],_).

has_length_n_lists_aux([A,B|Rest], N) :-
  length(A, LenA),
  length(B, LenB),
  LenB is LenA + N,
  has_length_n_lists_aux([B|Rest], N).

% #3: "10-points"
% poly_eval(Coeffs, X, Eval): Given a numeric list Coeffs of
% polynomial coefficients [ C_0, C_1, C_2, ... ], Eval
% matches the value of the polynomial at X, namely
% C_0*X^0 + C_1*X^1 + C_2*X^2 + C_3*X^3.
% *Restriction*: must be tail-recursive and cannot use exponentiation.
% Hint: use an auxiliary procedure.
poly_eval(Coeffs, X, Eval) :-
  poly_eval_aux(Coeffs, X, 1, 0, Eval).

poly_eval_aux([], _, _, Acc, Acc).

poly_eval_aux([C|T], X, CurrX, Acc, Eval) :-
  Term is C * CurrX,
  NewAcc is Acc + Term,
  NewX is CurrX * X,
  poly_eval_aux(T, X, NewX, NewAcc, Eval).

% #4: "10-points"
% plus_expr(aux, AddExpr): Given a non-empty list aux of Prolog
% aux T1, T2, ..., Tn, AddExpr matches T1 + T2 + ... + Tn.
% *Hint*: + is left-associative.
plus_expr(Terms, AddExpr) :-
  plus_expr_aux(Terms, AddExpr).

plus_expr_aux([T], T).
plus_expr_aux([H1, H2 | T], Expression) :-
  plus_expr_aux([H1 + H2 | T], Expression).

% #5: "10-points"
% poly_expr(Coeffs, X, Poly): Given a non-empty list of coefficients
% C1, C2], ..., CN and some
% Prolog term X, Poly is the expression:
% C1*X**0 + C2*X**1 + ... + CN*X**(N - 1)
% Hint: structure your code as for plus_expr/2.
poly_expr(Coeffs, X, Poly) :-
  Coeffs = [C | Rest],
  Term0 = C * (X ** 0),
  poly_expr_aux(Rest, X, 1, Term0, Poly).

poly_expr_aux([], _, _, Acc, Acc).

poly_expr_aux([C | Cs], X, P, Acc, Result) :-
  Term = C * (X ** P),
  NewAcc = Acc + Term,
  NextP is P + 1,
  poly_expr_aux(Cs, X, NextP, NewAcc, Result).

% #6: "15-points"
% element_at(List, Index, Element): List is a list whose Index
% (0-origin) element matches Element.
% *Must* be implemented using a *single* rule (where a fact counts as a
% rule). Hence it cannot be recursive.
% *Hint*: use a single rule containing calls to Prolog built-in procedures.
element_at(List, Index, Element) :- length(Prefix, Index), append(Prefix, [Element|_], List).

%% A graph is represented as a list of edges where an edge is
%% represented as a structure edge(From, To) representing an edge from
%% node From to node To.  

% #7: "10-points"
% dag_path(Dag, From, To, Path): Path is a list of edges specifying a
% path from node From to node To in DAG Dag.  It should be assumed
% that Dag, From, To are ground (no variables).
% The implementation *must* take advantage of the fact that Dag is a
% DAG.
dag_path(Dag, From, To, Path) :-
  dag_path_aux(Dag, From, To, [], Path).

  dag_path(Dag, Node, Node, []) :-
    member(edge(Node, _), Dag).

  dag_path(Dag, Node, Node, []) :-
    member(edge(_, Node), Dag).

dag_path_aux(Dag, From, To, Acc, Path) :-
  member(edge(From, To), Dag),
  append(Acc, [edge(From, To)], Path).

dag_path_aux(Dag, From, To, Acc, Path) :-
  member(edge(From, Mid), Dag),
  Mid \= To,
  append(Acc, [edge(From, Mid)], NewAcc),
  dag_path_aux(Dag, Mid, To, NewAcc, Path).

% #8: "15-points"
% graph_path1(Graph, From, To, Path): Path is a list of edges
% specifying an acyclic path from node From to node To in unrestricted
% graph Graph.  It should be assumed that Graph, From, To are ground
% (no variables).
% *Must* be implemented by tracking previously visited nodes to prevent
% getting caught up within cycles in Graph.
graph_path1(Graph, From, To, Path) :-
  graph_path1_aux(Graph, From, To, [From], [], Path).

graph_path1_aux(Graph, From, To, Visited, Acc, Path) :-
  member(edge(From, To), Graph),
  \+ member(To, Visited),
  append(Acc, [edge(From, To)], Path).

graph_path1_aux(Graph, From, To, Visited, Acc, Path) :-
  member(edge(From, Mid), Graph),
  \+ member(Mid, Visited),
  append(Acc, [edge(From, Mid)], NewAcc),
  graph_path1_aux(Graph, Mid, To, [Mid | Visited], NewAcc, Path).

% #9: "10-points"
% graph_path2(Graph, From, To, Path): Path is a list of edges from node
% From to node To in unrestricted graph Graph.  It should be assumed
% that Graph, From, To are ground (no variables).
% *Must* be implemented without tracking previously visited nodes.
% *Hint*: a small variation of dag_path/4.
graph_path2(Graph, From, To, Path) :-
    graph_path2_aux(Graph, From, To, [], Path).

graph_path2_aux(Graph, From, To, Acc, Path) :-
    member(edge(From, To), Graph),
    \+ node_in_path(To, Acc),
    append(Acc, [edge(From, To)], Path).

graph_path2_aux(Graph, From, To, Acc, Path) :-
    member(edge(From, Mid), Graph),
    \+ node_in_path(Mid, Acc),
    append(Acc, [edge(From, Mid)], NewAcc),
    graph_path2_aux(Graph, Mid, To, NewAcc, Path).

node_in_path(Node, [edge(Node, _) | _]).
node_in_path(Node, [edge(_, Node) | _]).
node_in_path(Node, [_ | T]) :-
    node_in_path(Node, T).
    
