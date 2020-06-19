input -> line

line
    -> normalized_value null
    | normalized_value new_line line

normalized_value
    -> value _
    | indent_set value _

value
    -> command
    | element

command
    -> map_command

map_command -> "map" space dot_list

element
    -> dot_list_set
    | indent_set dot_list_set

dot_list_set
    -> dot_list
    | dot_list space dot_list_set

dot_list
    -> character_set
    | character_set "." character_set
    | character_set "." dot_list

indent_set
    -> indent
    | indent indent_set

indent
    -> "\t"
    | space space

character_set
    -> character
    | character character_set

character -> [^ \t.\n]

space -> " "

new_line -> "\n"

_ -> [ \t]:*
