-module(lab8_sol).

-export([
  perimeter/1,
  guard_perimeter/1,
  points_letter_grade/1,
  grades_letter_grade/1,
  shapes_server_fn/1, start_shapes_server/1, send_shapes_msg/2,
  grades_server_fn/1, start_grades_server/1, send_grades_msg/2,
  shapes1/0, shapes2/0, shapes3/0
]).


%---------------------------- perimeter/1 -------------------------------
perimeter({_, square, {Side}}) ->
  4 * Side;
perimeter({_, circle, {Radius}}) ->
  2 * 3.14159 * Radius;
perimeter({_, rectangle, {W, H}}) ->
  2 * (W + H).



%------------------------- guard_perimeter/1 ----------------------------

guard_perimeter({_, Type, Dims}) when Type =:= square ->
  { Side } = Dims,
  4 * Side;
guard_perimeter({_, Type, Dims}) when Type =:= circle ->
  { Radius } = Dims,
  2 * 3.14159 * Radius;
guard_perimeter({_, Type, Dims}) when Type =:= rectangle ->
  { W, H } = Dims,
  2 * (W + H).


%----------------------- points_letter_grade/1 --------------------------

% see lab assignment for specs
points_letter_grade(_Points) when _Points >= 90 ->
 'A';
points_letter_grade(_Points) when _Points >= 80, _Points < 90 ->
 'B';
points_letter_grade(_Points) when _Points >= 70, _Points < 80 ->
 'C';
points_letter_grade(_Points) when _Points >= 60, _Points < 70 ->
 'D';
points_letter_grade(_Points) ->
 'F'.

%----------------------- grades_letter_grade/1 --------------------------

% see lab assignment for specs
grades_letter_grade(_Grade) ->  {_, _, _, Points} = _Grade,
    points_letter_grade(Points).

%------------------------ shapes_server_fn ------------------------------

shapes_server_fn(Shapes) ->
  receive
    { ClientPid, { perims } } ->
       Perims = [ { ID, perimeter(Shape) } ||
                  Shape <- Shapes,
		  ID <- [element(1, Shape) ]
		],
       ClientPid ! { self(), perims, Perims },
       shapes_server_fn(Shapes) ;
    { ClientPid, { new_shapes, Shapes1 } } ->
       ClientPid ! { self(), new_shapes },
       shapes_server_fn(Shapes1) ;
    { ClientPid, { stop } } ->
	ClientPid ! { self(), stopped };
    Unknown -> 
       io:format(standard_error, "unknown message ~p~n", [ Unknown ]),
       shapes_server_fn(Shapes) 
  end.

start_shapes_server(Shapes) ->
    spawn(lab8_sol, shapes_server_fn, [Shapes]).

send_shapes_msg(Pid, Msg) ->
  Pid ! { self(), Msg },
  receive
    X -> X
  end.
    

%------------------------ grades_server_fn ------------------------------

% Function to be run by a process.  The process has a state containing
% a list of Grade { StudentId, Category, AssignId, Points }.  It
% should handle the following messages:
%
%   { ClientPid, { letter_grades } }:
%      It should respond to `ClientPid` with a list containing
%      `{StudentId, AssignId, LetterGrade}` triples for all `Grades`
%      currently stored in server and recurse.
%
%    { ClientPid, { new_grades, NewGrades } }:
%      `NewGrades` is a list of `Grade`.
%      Responds to `ClientPid` with a `{ new_grades }` message
%      and recurses with `NewGrades`.
%
%    { ClientPid, { stop } }:
%      Stops after responding with a `stopped` message.
%
%    Any other message:
%      Recurse after logging an error on `standard_error`.
%
% *Hint*: structure your code similar to shapes_server_fn/1.
grades_server_fn(_Grades) ->  receive
        {ClientPid, {letter_grades}} ->
            Result = [ {StudentId, AssignId, points_letter_grade(Points)} ||
                       {StudentId, _Category, AssignId, Points} <- _Grades ],
            ClientPid ! {self(), letter_grades, Result},
            grades_server_fn(_Grades);

        {ClientPid, {new_grades, NewGrades}} ->
            ClientPid ! {self(), new_grades},
            grades_server_fn(NewGrades);

        {ClientPid, {stop}} ->
            ClientPid ! {self(), stopped};

        Unknown ->
            io:format(standard_error, "unknown message ~p~n", [Unknown]),
            grades_server_fn(_Grades)
    end.

% Spawn a new server process running `grades_server_fn(Grades)
% and returns its PID.
start_grades_server(_Grades) -> spawn(lab8_sol, grades_server_fn, [_Grades]).

% Send Msg to server process `Pid`.
send_grades_msg(_Pid, _Msg) -> _Pid ! {self(), _Msg},
    receive
        X -> X
    end.
    


%------------------------------- Shapes Data ----------------------------
shapes1() ->
  [ { s1, square, {1} }, { c1, circle, {1} }, { r1, rectangle, {1, 1} } ].
shapes2() ->
  [ { s2, square, {2} }, { c2, circle, {2} }, { r2, rectangle, {2, 2} } ].
shapes3() ->
  [ { s3, square, {3} }, { c3, circle, {3} }, { r3, rectangle, {3, 3} } ].
