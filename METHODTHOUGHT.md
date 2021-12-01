# method-thought
### command-module

### \#parse(input)
takes string parses for command call
- calls #strip
- splits on spaces, creating array
- discards strings that begin with anything other than an alphabetical character thats followed by one, '34door', '!golbin'
- discards any empty strings if any were somehow created

input: 'look redapple table', '12', '  strike 12orge', '(*apple'
output: %w[look redapple table], %w[12], %w[strike], %w[]

### #command
\#gets user input and checks command line list and command line for matches, then calls them
- #gets user input and calls chomps it, while passing it to #parse