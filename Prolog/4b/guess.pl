% Number Guessing Game
% Author: Maria Mills 02/19/2024
% References: See 'Resources' in `Prolog/4b/README.md` under section `Part 2b - Program 1`


random_number :-
    random(Random),  % Get a random number between 0 and 1 and store it in Random
    Number is truncate(Random * 20) + 1, % Take Random and multiply it by 20 then truncate the result to get a whole number, and add 1 to get a number between 1 and 20
    guess_number(Number). % Call helper predicate to check guess


guess_number(Number) :-
    write('Guess a number between 1 and 20: '), % Ask user for guess 1-20
    read(Guess), % Read user input

    % Conditional to check if the guess is correct, too low, or too high
    (   Guess =:= Number
    ->  write('Correct! The number was '), write(Number), nl
    ;   Guess < Number
    ->  write('Too low.'), nl,
        guess_number(Number) % If too low, recursive call
    ;   write('Too high.'), nl,
        guess_number(Number) % If too high, recursive call
    ).