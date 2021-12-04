# frozen-string-literal: true

require_relative './hashes'
require_relative './config'
require_relative './player'
require_relative './archetype'

module Command
  include Hashes
  include Config
  include Archetype

  # parse, aliases
  def command
    puts "\n"
    command_line = parse
    return @playing = false if command_line.nil?

    command = aliases(command_line.shift)
    return puts('Not a command!') if command.nil?

    arguments = check_data command_line

    send(command, arguments)
  end

  def parse
    input = gets
    return if input.nil?

    command_line = input.chomp.strip.split(/\s+/)
    command_line.reject! { |token| token.match(/[^0-9a-z]|[0-9][a-z]|^$/i) }
    command_line
  end

  def check_data(arguments)
    arguments.map do |argument|
      if argument.match(/^\d$/)
        argument.to_i
      else
        argument
      end
    end
  end

  def aliases(cmd)
    ALIASES[cmd.to_sym] unless cmd.nil?
  end

  def look(arguments)
    return @room.description if arguments.empty?

    puts 'Wrong argument types!' unless arguments.map(&:class).all? { |arg| arg == String }

    if Keybinds[:inventory].include?(arguments.last)
      return @player.display_inventory if arguments.one?
      arguments.pop
      container = player.storage
    else
      container = room.storage
    end

    item = find_item(arguments, container)
    return if item.nil?

    item.first.description
  end

  def take(arguments)
    return puts 'Specify an item' if arguments.empty?

    quantity = (arguments.first.is_a?(Integer) ? arguments.shift : 1)

    if Keybinds[:inventory].include?(arguments.last)
      arguments.pop
      return puts 'Specify an item within a container in your inventory' if arguments.empty? || arguments.size < 2
      container = player.storage
    else
      container = room.storage
    end # Create aux method for this

    item, container = find_item(arguments, container)
    return if item.nil? || container.nil?

    return puts "You can't pick this item up." unless item.is_a? Item
    # Create predicate method for the above two

    if item.is_a?(Stackable) && item.quantity > quantity
      item.quantity -= quantity
      stackable_item = create_item_type(ARCHETYPES[item.name.to_sym])
      stackable_item.quantity = quantity
      return @player.storage << stackable_item
    end
    
    container.delete(item)
    player.storage << item
    puts "You pick up #{item.display}"
  end

  def drop(arguments)
    return puts('Specify an item') if arguments.empty?

  end

  def find_item(arguments, container)
    item_query = arguments.shift

      if arguments.any?
        container = search_nested_container(arguments, container)
        return if container.nil?
      end

      item = get_item(item_query, container)
      return item, container if item
  end

  # Should take array with storage item names and a container instance that defaults to room's floor
  # Should return storage instance thats first object in storage_arguments or nil if one of arguments werent found
  def search_nested_container(storage_arguments, container)
    storage_arguments.reverse_each do |storage_query|
      storage_instance = get_item(storage_query, container)

      if storage_instance.is_a?(Storage)
        container = storage_instance.storage
      else
        return puts("#{storage_query} isn't a storage item.")
      end
    end

    return container
  end

  #Finds item whos name matches the query in container
  def get_item(item_query, container)
    return puts "#{container.class} not an Array" unless container.is_a?(Array)

    item = container.find { |item| item.id.start_with?(item_query) && (item_query.tr('0-9', '').size.to_f / item.name.size)*100 >= 50 }
    item.is_a?(Base) ? item : puts("#{item_query} isn't an item.")
  end
end
