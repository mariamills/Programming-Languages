% Puzzle Solver
% Author: Maria Mills 02/23/2024
% References: See 'Resources' in `Prolog/4b/README.md` under section `Part 2b - Program 3`

% Define the sisters, months and days - the provided info, like before
sisters([abigail, brenda, mary, paula, tara]).
months([february, march, june, july, december]).
days([sunday, monday, wednesday, friday, saturday]).

% Need to define the order of the months
month_order([february, march, june, july, december]).

% Compute index of an element in a list
indexOf(Element, [Element|_], 0).
indexOf(Element, [_|Tail], Index) :-
    indexOf(Element, Tail, Index1),
    Index is Index1 + 1.

% Check if all elements of a list are unique
unique([]).
unique([H|T]) :-
    \+ member(H, T),
    unique(T).

% Main predicate
solve_puzzle(Puzzle) :-
    length(Puzzle, 5), % 5 sisters

    % Define the structure of the puzzle, birthday/3 representing a sisters birthday and placeholder for month and day
    Puzzle = [birthday(abigail, _, _),
              birthday(brenda, _, _),
              birthday(mary, _, _),
              birthday(paula, _, _),
              birthday(tara, _, _)],

    % Initialize the lists into variables
    sisters(Sisters),
    months(Months),
    days(Days),

    % Permute all possible combinations of months and days and store them in variables (AssignedMonths, AssignedDays)
    maplist(permutation, [Months, Days], [AssignedMonths, AssignedDays]),

    % Apply assign_birthday to list
    maplist(assign_birthday, Sisters, AssignedMonths, AssignedDays, Puzzle),

    % Apply the constraints to the assigned birthdays
    apply_clues(Puzzle).


% Assign a birthday to each sister
assign_birthday(Sister, Month, Day, birthday(Sister, Month, Day)).

% Use the provided clues to solve the puzzle
apply_clues(Puzzle) :-
    % Put the months in order
    month_order(MonthOrder),

    % Paula was born in March, but not on a Saturday
    member(birthday(paula, march, Day), Puzzle), Day \= saturday,

    % Abigail was not born on a Friday or Wednesday
    member(birthday(abigail, _, AbigailDay), Puzzle), AbigailDay \= friday, AbigailDay \= wednesday,

    % Tara was born on a day other than Sunday or Saturday, and not in February
    member(birthday(tara, TaraMonth, TaraDay), Puzzle), TaraMonth \= february, (TaraDay = sunday; TaraDay = saturday),

    % Mary was born on a day other than Sunday or Saturday, and not in December or July
    member(birthday(mary, MaryMonth, MaryDay), Puzzle), MaryMonth \= december, MaryMonth \= july, (MaryDay = sunday; MaryDay = saturday),

    % Brenda was born in June
    member(birthday(_, june, _), Puzzle),

    % Brenda was not born on a Friday
    member(birthday(brenda, BrendaMonth, BrendaDay), Puzzle), BrendaDay \= friday,

    % The girl whose birthday is on Monday was born earlier in the year than Brenda and Mary
    member(birthday(MondayGirl, MondayMonth, monday), Puzzle),

    % Get the index of the months and compare them
    indexOf(MondayMonth, MonthOrder, MondayPos),

    % Get the index of Brenda and Marys months
    indexOf(BrendaMonth, MonthOrder, BrendaPos), MondayPos < BrendaPos,
    indexOf(MaryMonth, MonthOrder, MaryPos), MondayPos < MaryPos,


    % Tara was born before Brenda
    indexOf(TaraMonth, MonthOrder, TaraPos), TaraPos < BrendaPos.
