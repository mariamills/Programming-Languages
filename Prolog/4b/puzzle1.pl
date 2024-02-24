% Puzzle Solver
% Author: Maria Mills 02/22/2024
% References: See 'Resources' in `Prolog/4b/README.md` under section `Part 2b - Program 2`

% Define the children, animals and adventures - the provided info
children([joanne, lou, ralph, winnie]).
animals([seal, grizzly_bear, zebra, moose]).
adventures([spaceship, circus, rock_band, train]).

% Check if all elements of a list are unique
unique([]).
unique([Head|Tail]) :-
    \+ member(Head, Tail), % Head is not in the tail
    unique(Tail). % Check the tail recursively

% Main predicate
solve_puzzle(Puzzle) :-
    % List of children, animals and adventures
    Puzzle = [child(joanne, JoannesAnimal, JoannesAdventure),
                child(lou, LousAnimal, LousAdventure),
                child(ralph, RalphsAnimal, RalphsAdventure),
                child(winnie, WinniesAnimal, WinniesAdventure)],
    
    % Store animals and adventures in according variables
    animals(Animals),
    adventures(Adventures),
    
    % Permute (shuffle) the animals and adventures lists to get all possible combinations - store them in variables
    permutation(Animals, [JoannesAnimal, LousAnimal, RalphsAnimal, WinniesAnimal]),
    permutation(Adventures, [JoannesAdventure, LousAdventure, RalphsAdventure, WinniesAdventure]),

    % Make sure they are all unique...
    unique([JoannesAnimal, LousAnimal, RalphsAnimal, WinniesAnimal]),
    unique([JoannesAdventure, LousAdventure, RalphsAdventure, WinniesAdventure]),
    

    % The provided clues as facts:

    % The seal did not go into the spaceship or the train
    \+ member(child(_, seal, spaceship), Puzzle), 
    \+ member(child(_, seal, train), Puzzle),

    % Joannes animal is not a seal
    JoannesAnimal \= seal,

    % Lous animal is not a seal
    LousAnimal \= seal,

    % Joanne animal is not a grizzly bear
    JoannesAnimal \= grizzly_bear,

    % Joanne went to the circus
    JoannesAdventure = circus, 

    % Winnies animal is a zebra
    WinniesAnimal = zebra,

    % Grizzly bear did not go in a spaceship
    \+ member(child(_, grizzly_bear, spaceship), Puzzle).

