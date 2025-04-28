-module(prj5_tests).
-include_lib("eunit/include/eunit.hrl").
-compile([nowarn_export_all, export_all]).

-import(prj5_sol, [
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

%---------------------------- Test Control ------------------------------
%% Enabled Tests
%%   comment out -define to deactivate test.
%%   alternatively, enclose deactivated tests within
%%   -if(false). and -endif. lines
%% Enable all tests before submission.
%% The skeleton file is distributed with all tests deactivated
%% by being enclosed within if(false) ... endif directives.

-if(false).  








-endif.

-define(test_rec_poly_eval, enabled).
-define(test_non_rec_poly_eval, enabled).
-define(test_tuple_poly_eval, enabled).
-define(test_assoc_lookup, enabled).
-define(test_id_poly_eval, enabled).
-define(test_server_fn, enabled).


%----------------------- Recursive Polynomial Eval ----------------------

-ifdef(test_rec_poly_eval).
rec_poly_eval_test_() -> [
  { "rec_poly_eval: empty@2", ?_assert(rec_poly_eval([], 2) == 0) },
  { "rec_poly_eval: 1@4", ?_assert(rec_poly_eval([1], 4) == 1) },
  { "rec_poly_eval: 1_2@4", ?_assert(rec_poly_eval([1, 2], 4) == 9) },
  { "rec_poly_eval: 1_2_3@4", ?_assert(rec_poly_eval([1, 2, 3], 4) == 57) },
  { "rec_poly_eval: 1_1_1@2", ?_assert(rec_poly_eval([1, 1, 1], 2) == 7) },
  { "rec_poly_eval: 1_2_3_4@3",
    ?_assert(rec_poly_eval([1, 2, 3, 4], 3) == 142) }
].
-else.
rec_poly_eval_test_() -> [].
-endif. %test_rec_poly_eval


%--------------------- Non-Recursive Polynomial Eval --------------------


-ifdef(test_non_rec_poly_eval).
non_rec_poly_eval_test_() -> [
  { "non_rec_poly_eval: empty@2", ?_assert(non_rec_poly_eval([], 2) == 0) },
  { "non_rec_poly_eval: 1@4", ?_assert(non_rec_poly_eval([1], 4) == 1) },
  { "non_rec_poly_eval: 1_2@4", ?_assert(non_rec_poly_eval([1, 2], 4) == 9) },
  { "non_rec_poly_eval: 1_2_3@4",
    ?_assert(non_rec_poly_eval([1, 2, 3], 4) == 57) },
  { "non_rec_poly_eval: 1_1_1@2",
    ?_assert(non_rec_poly_eval([1, 1, 1], 2) == 7) },
  { "non_rec_poly_eval: 1_2_3_4@3",
    ?_assert(non_rec_poly_eval([1, 2, 3, 4], 3) == 142) }
].
-else.
non_rec_poly_eval_test_() -> [].
-endif. %test_non_rec_poly_eval


%------------------------- Tuple Polynomial Eval ------------------------

-ifdef(test_tuple_poly_eval).
tuple_poly_eval_test_() -> [
  { "tuple_poly_eval: empty@2", ?_assert(tuple_poly_eval([], 2) == 0) },
  { "tuple_poly_eval: 1@4", ?_assert(tuple_poly_eval([{num, 1}], 4) == 1) },
  { "tuple_poly_eval: 1_2@4",
    ?_assert(tuple_poly_eval([{num, 1}, {num, 2}], 4) == 9) },
  { "tuple_poly_eval: 1_2_3@4",
    ?_assert(tuple_poly_eval([{num, 1}, {num, 2}, {num, 3}], 4) == 57) },
  { "tuple_poly_eval: 1_1_1@2",
    ?_assert(tuple_poly_eval([{num, 1}, {num, 1}, {num, 1}], 2) == 7) },
  { "tuple_poly_eval: 1_2_3_4@3",
    ?_assert(tuple_poly_eval([{num, 1}, {num, 2}, {num, 3}, {num, 4}], 3)
	     == 142) }
].
-else.
tuple_poly_eval_test_() -> [].
-endif. %test_tuple_poly_eval


%----------------------- Assoc List Lookup ------------------------------

-ifdef(test_assoc_lookup).
assoc_lookup_test_() -> 
    Assoc = [ {a, 22}, {b, 33}, {a, 44}, {b, 55}, {c, 66} ],
    [ { "assoc_0_first", ?_assert(assoc_lookup_0(a, Assoc) =:= 22) },
      { "assoc_0_mid", ?_assert(assoc_lookup_0(b, Assoc) =:= 33) },
      { "assoc_0_last", ?_assert(assoc_lookup_0(c, Assoc) =:= 66) },
      { "assoc_0_fail", ?_assert(assoc_lookup_0(e, Assoc) =:= 0) },
      { "assoc_throw_first", ?_assert(assoc_lookup_throw(a, Assoc) =:= 22) },
      { "assoc_throw_mid", ?_assert(assoc_lookup_throw(b, Assoc) =:= 33) },
      { "assoc_throw_last", ?_assert(assoc_lookup_throw(c, Assoc) =:= 66) },
      { "assoc_throw_fail", 
	?_assertThrow({not_found, _}, assoc_lookup_throw(e, Assoc)) }
    ].
-else.
assoc_lookup_test_() -> [].
-endif.


%--------------------------- ID Polynomial Eval -------------------------


-ifdef(test_id_poly_eval).
id_poly_eval_test_() ->
  Assoc = [ {a, 1}, {b, 2}, {c, 3}, {d, 4} ],
  [
  { "id_poly_eval: empty@2", ?_assert(id_poly_eval(Assoc, [], 2) == 0) },
  { "id_poly_eval: a@4", ?_assert(id_poly_eval(Assoc, [{id, a}], 4) == 1) },
  { "id_poly_eval: 1_b@4",
    ?_assert(id_poly_eval(Assoc, [{num, 1}, {id, b}], 4) == 9) },
  { "id_poly_eval: 1_b_c_e@4",
    ?_assert(id_poly_eval(Assoc, [{num, 1}, {id, b}, {id, c}, {id, e}], 4)
     == 57) },
  { "id_poly_eval: 1_1_1@2",
    ?_assert(id_poly_eval(Assoc, [{num, 1}, {num, 1}, {num, 1}], 2) == 7) },
  { "id_poly_eval: 1_b_3_d@3",
    ?_assert(id_poly_eval(Assoc, [{num, 1}, {id, b}, {num, 3}, {id, d}], 3)
      == 142) }
  ].
-else.
id_poly_eval_test_() -> [].  
-endif. %test_id_poly_eval


%---------------------------- Server Function ---------------------------

-ifdef(test_server_fn).

server_fn_test_() ->
    Assoc1 = [{a, 42}, {b, 2}, {c, 3}, {d, 4}, {x, -1}, {y, -2}, {z, -3}],
    Coeffs1 = [{id, a}, {id, x}, {id, b}, {num, 3}],
    Assoc2 = [{a, 2}, {b, 3}, {c, 8}, {d, 7}, {x, 5}, {y, -3}, {z, 4}],
    Coeffs2 = [{id, x}, {id, c}, {id, d}, {num, 2}, { id, xx}],
     { setup,
       % before tests, create server with Assoc1 and Coeffs1
       fun () -> spawn(prj5_sol, server_fn, [Assoc1, Coeffs1]) end,

       % after tests, stop server.
       fun (Pid) -> Pid ! { self(), stop }, ok end,

       % return tests for server at Pid.
       fun (Pid) -> 
         [
           { "server_eval: Coeffs1 Assoc1 @0",
	     ?_assert(42.0 == server_eval(Pid, 0)) },
	  { "server_eval: Coeffs1 Assoc1 @1", 
	    ?_assert(46 == server_eval(Pid, 1)) },
	  { "server_eval: Coeffs1 Assoc1 @4", 
	    ?_assert(262 == server_eval(Pid, 4)) },
	  
	  { "server_eval: ch_Assoc2", 
	    ?_assert(set_assoc == server_set_assoc(Pid, Assoc2)) },
	  { "server_eval: Coeffs1 Assoc2 @0",
	    ?_assert(2 == server_eval(Pid, 0)) },
	  { "server_eval: Coeffs1 Assoc2 @1", 
	    ?_assert(13 == server_eval(Pid, 1)) },
	  { "server_eval: Coeffs1 Assoc2 @4", 
	    ?_assert(262 == server_eval(Pid, 4)) },
	  
	  { "server_eval: ch_Coeffs2", 
	    ?_assert(set_coeffs == server_set_coeffs(Pid, Coeffs2)) },
	  { "server_eval: Coeffs2 Assoc2 @0", 
	    ?_assert(5 == server_eval(Pid, 0)) },
	  { "server_eval: Coeffs2 Assoc2 @1", 
	    ?_assert(22 == server_eval(Pid, 1)) },
	  { "server_eval: Coeffs2 Assoc2 @4",
	    ?_assert(277 == server_eval(Pid, 4)) },
	  % restore original env
	  { "server_eval: ch_Assoc1",
	    ?_assert(set_assoc == server_set_assoc(Pid, Assoc1)) },
	  { "server_eval: ch_Coeffs1",
	    ?_assert(set_coeffs == server_set_coeffs(Pid, Coeffs1)) },
	  { "server_eval: restored Coeff1 Assoc1 @0",
	    ?_assert(42 == server_eval(Pid, 0)) },
	  { "server_eval: restored Coeff1 Assoc1 @1",
	    ?_assert(46 == server_eval(Pid, 1)) },
	  { "server_eval: restored Coeff1 Assoc1 @4",
	    ?_assert(262 == server_eval(Pid, 4)) }
	 ]
       end
     }.

-else.
server_fn_test_() -> [].
-endif. % test_server_fn			


%---------------------------------- main/1 ------------------------------

% for automated testing using gradescope
% run this file using escript after compiling using erlc *.erl
main([]) ->
    Tests = lists:flatten([
	rec_poly_eval_test_(),
	non_rec_poly_eval_test_(),
	tuple_poly_eval_test_(),
	assoc_lookup_test_(),
	id_poly_eval_test_(),
	server_fn_test_()
    ]),
    eunit:test(Tests, [ verbose ]).
