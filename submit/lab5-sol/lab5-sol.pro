#!/usr/bin/env -S swipl
%-*- mode: prolog; -*-

:- module(prj3_sol,  [
      cons_list_car/2, cons_list_cadr/2, cons_list_cddr/2,
      caddr/2, cdar/2,
      area/2, length_second/2,
      sum_list/2, sum_list/3, sum_lengths/2
  ]).

/* *IMPORTANT NOTE*:

   In order to avoid singleton variable warnings in the skeleton
   code, all variable names use a leading underscore as in _List.
   When writing the code, please remove the leading underscore
   and change to simply List.
*/

% For the next few exercises we represent lists in Prolog using a
% non-standard representation which we call a cons-list.  Specifically,
% an empty list is represented as the Prolog atom nil and the list
% with head Hd and tail Tl is represented as the Prolog structure
% cons(Hd, Tl).

% #1
% cons_list_car(Ls, Hd): succeed iff Hd matches the head of cons-list Ls.
cons_list_car(_Ls, _Hd) :- 'TODO'.

% #2
% cons_list_cadr(Ls, Cadr): succeed iff Cadr matches the scheme
% cadr of cons-list Ls.
cons_list_cadr(_Ls, _Cadr) :- 'TODO'.

% #3
% cons_list_cddr(Ls, Cddr): succeed iff Cddr matches the scheme
% cddr of cons-list Ls.
cons_list_cddr(_Ls, _Cddr) :- 'TODO'.

% #4
% caddr(List, Caddr): succeed iff Caddr matches the Scheme caddr of List.
caddr(_List, _Caddr) :- 'TODO'.

% #5
% cdar(List, Cdar): succeed iff Cdar matches the Scheme cdar of List.
cdar(_List, _Cdar) :- 'TODO'.

% #6
% procedure length_second(List, Len): succeed iff Len
% matches the length of the second element in List (which
% should be a list).
% Hint: use pattern matching on List to extract its second
% element Second and then use length(Second, Len) to match
% Len with the length of Second.
length_second(_List, _Len) :- 'TODO'.

% #7
% area(Shape, Area): succeed iff Area matches the area of Shape,
% for Shape in rect(Width, Height) and circle(Radius).
area(_Shape, _Area) :- 'TODO'.

% #8
% sum_list(List, Sum): succeed iff Sum matches the sum of the numbers in
% number-list Sum.  *Must* be implemented as a wrapper which simply
% calls a tail-recursive sum_list(List, Acc, Sum) which succeeds
% if Sum matches the sum of Acc and the numbers in number-list List.
sum_list(_List, _Sum) :- 'TODO'.
sum_list(_List, _Acc, _Sum) :- 'TODO'.


% #9
% sum_lengths(List, LensSum): assuming that each element of List is
% itself a list, succeed iff LensSum matches the sum of the lengths of
% the lists in List.
sum_lengths(_List, _LensSum) :- 'TODO'.
