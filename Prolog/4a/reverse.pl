string_reverse(S, Reversed) :-
    string_chars(S, Chars), % Convert S (string) to a list of Chars
    reverse(Chars, ReversedChars), % Reverse the list
    string_chars(Reversed, ReversedChars). % Convert the reversed list to a string

% Predicate to get the reversed string and print it
string_reverse_print(S) :-
    string_reverse(S, Reversed), % Calls the string_reverse predicate to get the reversed string
    write(Reversed). % Print
