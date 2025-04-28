-module(prj5_sol).

-export([
  rec_poly_eval/2,
  non_rec_poly_eval/2,
  tuple_poly_eval/2,
  assoc_lookup/3,
  assoc_lookup_0/2,
  assoc_lookup_throw/2,
  id_poly_eval/3,
  server_fn/2, server_set_assoc/2, server_set_coeffs/2, server_eval/2,
  format/2
]).

-ifdef(comment).

  YOU WILL RECEIVE A SUBSTANTIAL PENALTY (INCLUDING POSSIBLY A ZERO
  FOR THE ENTIRE PROJECT) IF YOU DO NOT MEET THE FOLLOWING
  RESTRICTIONS:

    + You may not use any Erlang builtins or features not covered in
      class or mentioned explicitly in this project.  Note that a
      builtin function fn is regarded as covered in class if it has
      been used in class with the same name fn or defined in class
      with name myFn or my_fn.

    + If an exercise specifies a restriction on the implementation,
      then your implementation must meet that restriction.

    + Your submission must not contain garbage files.  Specifically,
      it should unpack into a prj5-sol directory and contain only this
      file and your README.      

  Note that a function is allowed to call a function defined earlier.

-endif.

%----------------------- Recursive Polynomial Eval ----------------------

% #1: 15-points

% Given a list Coeffs of numbers [ C_0, C_1, C_2, ... ] and a
% number X, rec_poly_eval(Coeffs, X) should return the value of
% the polynomial
%
%   C_0 + C_1*X + C_2*X^2 + C_3*X^3 + ...
%
% where X^i denotes X to the power-of-i.
%
% *Restriction*: Your implementation is required to be tail-recursive.
% *Hint*: Use an auxiliary function.
rec_poly_eval(_Coeffs, _X) -> rec_poly_eval_aux(_Coeffs, _X, 1, 0).

rec_poly_eval_aux([], _X, _XPow, Acc) ->
    Acc;

rec_poly_eval_aux([C|Cs], X, XPow, Acc) ->
    rec_poly_eval_aux(Cs, X, XPow * X, Acc + C * XPow).


%--------------------- Non-Recursive Polynomial Eval --------------------

% #2: 20-points

% Given a list Coeffs of numbers [ C_0, C_1, C_2, ... ] and a
% number X, non_rec_poly_eval(Coeffs, X) should return the value of
% the polynomial
%
%   C_0 + C_1*X + C_2*X^2 + C_3*X^3 + ...
%
% where X^i denotes X to the power-of-i.
%
% *Restriction*: Your implementation is not allowed to use recursion.
% *Hint*: Use a list comprehension to compute the terms of the
% polynomial (using list:zip, list:seq() and math:pow())
% followed by a lists:foldl() to sum the terms.
non_rec_poly_eval(_Coeffs, _X) -> Powers = lists:seq(0, length(_Coeffs) - 1),
    Terms = [ C * math:pow(_X, P) || {C, P} <- lists:zip(_Coeffs, Powers) ],
    lists:foldl(fun (Elem, Acc) -> Elem + Acc end, 0, Terms).

%------------------------- Tuple Polynomial Eval ------------------------

% #3: 10-points

% Given a list TupleCoeffs of pairs { num, Coeff } of the form
% [ { num, C_0 }, { num, C_1 }, { num, C_2 }, ... ] and a
% number X, tuple_poly_eval(TupleCoeffs, X) should return the value of
% the polynomial
%
%   C_0 + C_1*X + C_2*X^2 + C_3*X^3 + ...
%
% where X^i denotes X to the power-of-i.
%
% *Hint*: Your solution can strip the coefficients out of the tuple-pairs
% and then call any one of the solutions to the two previous exercises.
tuple_poly_eval(_TupleCoeffs, _X) -> Coeffs = [ C || {num, C} <- _TupleCoeffs ],
    rec_poly_eval(Coeffs, _X).

%----------------------- Assoc List Lookup ------------------------------

% #4: 15-points

% Lookup the Value of Key in assoc list Assoc list containing
% { Key, Value } pairs.  If not found, return the result of
% calling DefaultFn().
%
% Hint: implement by wrapping lists:keyfind() and using a case
% to pattern-match on the result.
assoc_lookup(_Key, _Assoc, _DefaultFn) ->  case lists:keyfind(_Key, 1, _Assoc) of
        {Key, Value} -> Value;
        false -> _DefaultFn()
    end.

% Lookup the Value of Key in assoc list Assoc list containing
% { Key, Value } pairs.  If not found, return 0.
%
% Restriction: must be implemented by wrapping assoc_lookup/3.
assoc_lookup_0(_Key, _Assoc) ->  assoc_lookup(_Key, _Assoc, fun() -> 0 end).
				     
% Lookup the Value of Key in assoc list Assoc list containing
% { Key, Value } pairs.  If not found, throw an exception
% of the form { not_found Msg } where Msg is a string 
% describing the error (can be built using something like
% format("key ~p not found", [Key]) ).
%
% Restriction: must be implemented by wrapping assoc_lookup/3.
assoc_lookup_throw(_Key, _Assoc) -> assoc_lookup(_Key, _Assoc, fun() -> throw({not_found, format("key ~p not found", [_Key])}) end).

%--------------------------- ID Polynomial Eval -------------------------

% #5: 10-points

% Given a list IdCoeffs of pairs { num, C } or { id, Atom}, and a
% number X, id_poly_eval(Assoc, IdCoeffs, X) should return the value
% of the polynomial
%
%   C_0 + C_1*X + C_2*X^2 + C_3*X^3 + ...
%
% where X^i denotes X to the power-of-i, and C_i is:
%
%   If IdCoeffs[i] is { num, C }, then C_i is C.
%
%   If IdCoeffs[i] is { id, Atom }, then C_i is
%   assoc_lookup_0(Atom, Assoc).
%
% *Hint*: Your solution should first convert IdCoeffs to a list
% of numbers and then call any one of the solutions to the earlier
% exercises.  Use a local auxiliary function to convert an element
% of IdCoeffs to a number.
id_poly_eval(_Assoc, _IdCoeffs, _X) -> Coeffs = [ id_coeff_to_num(_Assoc, Pair) || Pair <- _IdCoeffs ],
    rec_poly_eval(Coeffs, _X).

id_coeff_to_num(_Assoc, {num, C}) ->
    C;
id_coeff_to_num(_Assoc, {id, Atom}) ->
    assoc_lookup_0(Atom, _Assoc).

%---------------------------- Server Function ---------------------------

% #6: 30-points

% server_fn(Assoc, Coeffs) should receive messages Msg from clients and
% respond based on the form of Msg:
%
%    { ClientPid, stop }: the server should send a { self(), stopped }
%    reply to ClientPid and return.
%
%    { ClientPid, set_assoc, Assoc1 }: the server should send a
%    { self(), set_assoc } reply to ClientPid and recurse with Assoc
%    set to Assoc1 and Coeffs unchanged.
%
%    { ClientPid, set_coeffs, Coeffs1 }: the server should send a 
%    { self(), set_coeffs } reply to ClientPid and recurse with Assoc
%    unchanged and Coeffs set to Coeffs1.
%
%    { ClientPid, eval, X }: the server should evaluate Result
%    = id_poly_eval(Assoc, Coeffs, X) and send a
%    { self(), eval, Result } reply to ClientPid and recurse with
%    Assoc and Coeffs unchanged.
%
%    Any other message Msg : 
%      Use io:format(standard_error, "unknown message ~p~n", [ Msg ]) 
%      to log an error on standard error, and  recurse with both
%      Assoc and Coeffs unchanged.

server_fn(_Assoc, _Coeffs) ->  receive  %maybneed change
        {ClientPid, stop} ->
            ClientPid ! {self(), stopped};
        
        {ClientPid, set_assoc, Assoc1} ->
            ClientPid ! {self(), set_assoc},
            server_fn(Assoc1, _Coeffs);
        
        {ClientPid, set_coeffs, Coeffs1} ->
            ClientPid ! {self(), set_coeffs},
            server_fn(_Assoc, Coeffs1);
        
        {ClientPid, eval, X} ->
            Result = id_poly_eval(_Assoc, _Coeffs, X),
            ClientPid ! {self(), eval, Result},
            server_fn(_Assoc, _Coeffs);
        
        Msg ->
            io:format(standard_error, "unknown message ~p~n", [Msg]),
            server_fn(_Assoc, _Coeffs)
    end.

% send set_assoc Assoc message to Pid and return response.
server_set_assoc(Pid, Assoc) ->
    Pid ! { self(), set_assoc, Assoc },
    receive
	{ Pid, X } ->
	    X 
    end.

% send set_coeffs Coeffs message to Pid and return response.
server_set_coeffs(Pid, Coeffs) ->
    Pid ! { self(), set_coeffs, Coeffs },
    receive
	{ Pid, X } ->
	    X
    end.

% eval current poly on server Pid at point X.
server_eval(Pid, X) ->
    Pid ! { self(), eval, X },
    receive
	{ Pid, eval, Z } ->
	    Z
    end.    



%------------------------------ Utilities -------------------------------

% Given a format string containing printf-like specifiers like ~p,
% return string resulting from substituting terms from ArgsList for ~p
% specifiers.
%
% For example, format("values are ~p and ~p", [22, {a, 33}])
% will result in the string "values are 22 and {a,33}".
format(Fmt, ArgsList) ->
    lists:flatten(io_lib:format(Fmt, ArgsList)).

% DEBUGGING.
% Use the ?debugFmt(Fmt, ArgsList) macro to produce debugging output
% when running tests.  For example, 
%    ?debugFmt("values are ~p and ~p", [22, {a, 33}]) 
% will output the line
%    values are 22 and {a,33}


