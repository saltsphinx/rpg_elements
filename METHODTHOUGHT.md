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

### \#search_container(storage_arguments, container_instance)
Digs through container_instance until it finds first element of storage_arguments
- #reverse_each on storage_Arguments
- #each on container_intance storage items and check if their name equals current storage_arguments interaction name
- if so, container_instance = container_instance iteraction
- if not, return nil

---

### room generation

rooms should have the ability to take a list, asign all of their values then generate all of the items that should be included in them
forumla for array/arguments: [name, description, items: []]
items followed by an array should be considered storage items, ie. ['forest', 'trees all around', ['table', ['apple'], 'spud']]
[name, description, items: []] ['forest', 'trees all around', ['table', ['apple'], 'spud']]