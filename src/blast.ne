input -> line_set new_line:* {% id %}

line_set
    -> line
    | line new_line line_set

line -> indent:* value _

value
    -> command {% ([[[name, space, arg]]]) => `{${name}(${arg.join('.')}, (item, index) => {})}` %}
    | element {% data => data[0].map(([name, ...classes]) => `<${name} class="${classes.join(' ')}">`).join('\n') %}

command
    -> map_command

map_command -> "map" space dot_list

element
    -> dot_list {% data => data %}
    | dot_list space element {% ([v, space, el]) => [v, ...el] %}

dot_list
    -> character_set
    | character_set dot dot_list {% ([v, dot, dl]) => [v, ...dl] %}

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
