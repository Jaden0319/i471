-module(lab8_tests).
-include_lib("eunit/include/eunit.hrl").
-compile([nowarn_export_all, export_all]).

-export([ grades1/0, grades2/0 ]).

-import(lab8_sol, [
  points_letter_grade/1,
  grades_letter_grade/1,
  grades_server_fn/1, start_grades_server/1, send_grades_msg/2
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


-define(test_points_letter_grade, enabled).
-define(test_grades_letter_grade, enabled).
-define(test_grades_server, enabled).

%----------------------- points_letter_grade/1 --------------------------

-ifdef(test_points_letter_grade).
points_letter_grade_test_() -> [
  { "points_letter_grade: 100", ?_assert(points_letter_grade(100) == 'A') },
  { "points_letter_grade: 90", ?_assert(points_letter_grade(90) == 'A') },
  { "points_letter_grade: 89", ?_assert(points_letter_grade(89) == 'B') },
  { "points_letter_grade: 80", ?_assert(points_letter_grade(80) == 'B') },
  { "points_letter_grade: 78", ?_assert(points_letter_grade(78) == 'C') },
  { "points_letter_grade: 72", ?_assert(points_letter_grade(72) == 'C') },
  { "points_letter_grade: 70", ?_assert(points_letter_grade(70) == 'C') },
  { "points_letter_grade: 69", ?_assert(points_letter_grade(69) == 'D') },
  { "points_letter_grade: 60", ?_assert(points_letter_grade(60) == 'D') },
  { "points_letter_grade: 59", ?_assert(points_letter_grade(59) == 'F') },
  { "points_letter_grade: 42", ?_assert(points_letter_grade(42) == 'F') }
].
-else.
points_letter_grade_test_() -> [].
-endif. %test_points_letter_grade

%----------------------- grades_letter_grade/1 --------------------------

-ifdef(test_grades_letter_grade).
grades_letter_grade_test_() -> [
  { "grades_letter_grade: 100",
	?_assert(grades_letter_grade({tom, prj, prj1, 100}) == 'A') },
  { "grades_letter_grade: 90",
        ?_assert(grades_letter_grade({tom, prj, prj1, 90}) == 'A') },
  { "grades_letter_grade: 89",
	?_assert(grades_letter_grade({tom, prj, prj1, 89}) == 'B') },
  { "grades_letter_grade: 80",
	?_assert(grades_letter_grade({tom, prj, prj1, 80}) == 'B') },
  { "grades_letter_grade: 78",
	?_assert(grades_letter_grade({tom, prj, prj1, 78}) == 'C') },
  { "grades_letter_grade: 72",
	?_assert(grades_letter_grade({tom, prj, prj1, 72}) == 'C') },
  { "grades_letter_grade: 70",
	?_assert(grades_letter_grade({tom, prj, prj1, 70}) == 'C') },
  { "grades_letter_grade: 69",
	?_assert(grades_letter_grade({tom, prj, prj1, 69}) == 'D') },
  { "grades_letter_grade: 60",
	?_assert(grades_letter_grade({tom, prj, prj1, 60}) == 'D') },
  { "grades_letter_grade: 59",
	?_assert(grades_letter_grade({tom, prj, prj1, 59}) == 'F') },
  { "grades_letter_grade: 42",
	?_assert(grades_letter_grade({tom, prj, prj1, 42}) == 'F') }
].
-else.
grades_letter_grade_test_() -> [].
-endif. %test_grades_letter_grade

%---------------------------- Grades Server -----------------------------
-ifdef(test_grades_server).
grades_server_test_() ->
  Grades1 = grades1(), Grades2 = grades2(),
  Pid = start_grades_server(Grades1),
  [ { "grades_server(grades1): letter_grades",
      ?_assert(element(3, send_grades_msg(Pid, { letter_grades })) ==
               [ {abe, hw1, 'D' }, { abe, hw2, 'C' },
     	         {abe, prj1, 'B' }, { abe, prj2, 'B' },
		 {ann, hw1, 'A' }, {ann, hw2, 'A'},
		 {ann, prj1, 'A'}, {ann, prj2, 'A'}
	       ]) },
    { "grades_server(grades1->grades2): new_grades",		 
      ?_assert(element(2, send_grades_msg(Pid, { new_grades, Grades2 }))
      == new_grades) },
    { "grades_server(grades2): letter_grades",
      ?_assert(element(3, send_grades_msg(Pid, { letter_grades })) ==
               [ {joe, hw1, 'B' }, { joe, hw2, 'C' },
     	         {joe, prj1, 'A' }, { joe, prj2, 'A' },
		 {sue, hw1, 'B' }, {sue, hw2, 'B'},
		 {sue, prj1, 'A'}, {sue, prj2, 'A'},
		 {tom, hw1, 'C' }, {tom, hw2, 'B'},
		 {tom, prj1, 'A'}, {tom, prj2, 'A'}
	       ]) },      
    { "grades_server(grades2): stop",
      ?_assert(element(2, send_grades_msg(Pid, { stop })) == stopped) }
    		 
  ].
-else.
grades_server_test_() -> [].
-endif.

%----------------------------- Grades Data ------------------------------
% [{StudentId, Category, AssignId, Grade}]
grades1() -> [
  { abe, hw, hw1, 67 },
  { abe, hw, hw2, 72 },
  { abe, prj, prj1, 88 },
  { abe, prj, prj2, 87 },

  { ann, hw, hw1, 94 },
  { ann, hw, hw2, 99 },
  { ann, prj, prj1, 99 },
  { ann, prj, prj2, 97 }
].
grades2() -> [
  { joe, hw, hw1, 82 },
  { joe, hw, hw2, 78 },
  { joe, prj, prj1, 92 },
  { joe, prj, prj2, 97 },

  { sue, hw, hw1, 87 },
  { sue, hw, hw2, 87 },
  { sue, prj, prj1, 93 },
  { sue, prj, prj2, 94 },

  { tom, hw, hw1, 78 },
  { tom, hw, hw2, 84 },
  { tom, prj, prj1, 93 },
  { tom, prj, prj2, 94 }

].

%---------------------------------- main/1 ------------------------------

% for automated testing using gradescope
% run this file using escript after compiling using erlc *.erl
main([]) ->
    Tests = lists:flatten([
	points_letter_grade_test_(),
	grades_letter_grade_test_(),
	grades_server_test_()
    ]),
    eunit:test(Tests, [ verbose ]).
