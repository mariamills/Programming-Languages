sort_and_print_name(Name) :-
    string_chars(Name, CharList),  % Convert Name (string) to a list of Chars
    msort(CharList, SortedCharList),  % Sort the list
    write(SortedCharList).  % Print the sorted list