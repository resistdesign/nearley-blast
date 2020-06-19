input -> line_set new_line:* {% id %}

line_set
    -> line
    | line new_line line_set

line -> indent:* value _

value
    -> command {% ([name, arg]) => `{${name}(${arg}, (item, index) => {})}` %}
    | element {% id %}

command
    -> map_command {% id %}

map_command -> "map" space dot_list {% id %}

element
    -> dot_list {% data => data %}
    | dot_list space element

dot_list
    -> character_set
    | character_set dot dot_list

indent
    -> tab {% () => false %}
    | space space {% () => false %}

new_line -> "\n" {% () => false %}

_ -> (space | tab):* {% () => false %}

dot -> "." {% () => false %}

tab -> "\t" {% () => false %}

space -> " " {% () => false %}

character_set
    -> character {% id %}
    | character character_set {% data => data.join('') %}

character -> [^ .\t\n] {% data => data.join('') %}
