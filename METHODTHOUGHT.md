# method-thought
### command-module

### \#parse
takes string parses for command call
- calls #gets.#chomp.#strip
- splits on spaces, creating array
- discards strings that begins an alphabetical character thats followed by one, '34door', '!golbin'
- discards any empty strings if any were somehow created
- returns parsed string

input: 'look redapple table', '12', '  strike 12orge', '(*apple'

output: %w[look redapple table], %w[12], %w[strike], %w[]

### \#aliases(cmd)
takes command/alias and returns command in symbol form
- either returns command or nil

### \#command
\#gets user input and checks command line list and command line for matches, then calls them
- command_line = #parse
- %w[command-name/option quantity/item/option container/option?+]
- calls #aliases by shifting command line and unshifts if command is returned, dont return if nil is returned so menu code can be implimented later
- if alias found, call command and pass arguments
- else, lecture the user