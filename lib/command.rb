require_relative './hashes.rb'
require_relative './config'
require_relative './player'

module Command
  include Hashes
  include Config

  def command
    command_line = parse; return @playing = false if command_line.nil?

    command = aliases command_line.shift
    return puts 'Not a command!' if command.nil?

    arguments = check_data command_line

    send(command, arguments)
  end

  def parse
    input = gets; return if input.nil?

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

  def look(arguments, player = nil)
    inventory_binds = Keybinds[:inventory]
    return @room.description if arguments.empty?

    puts 'Wrong argument types!' unless arguments.map(&:class).all? { |arg| arg == String }

    if inventory_binds.include?(arguments.last)
      first_argument = arguments.first 
      return @player.display_inventory if inventory_binds.include?(first_argument)
      arguments.pop
      player = @player
    end

    item = find_item(arguments, player); return if item.nil? # item variable is an Array

    item.first.description
    # If there are more than 1 argument, assume its a depth search
  end

  def take(arguments)
    return puts 'Specify an item' if arguments.empty?

    item, container = find_item(arguments); return if item.nil? || container.nil?

    return puts "You can't pick this item up." unless item.is_a? Item

    container.storage.delete item
    @player.storage << item
    puts "You pick up #{item.id}"
  end

  def drop(arguments)
    return puts 'Specify an item' if arguments.empty?

  end

  def find_item(arguments, player = nil)
    if arguments.size >= 2
      container = search_container(arguments[1..-1], player || @room); return puts "One of these aren't a container, #{arguments[1..-1]}" if container.nil?

      item = get_instance(arguments.first, container); return puts("#{arguments.first} not founded in container.") if item.nil?
      return item, container # item instance AND container instance returned
    else
      item = get_instance(arguments.first, player || @room); return puts("#{arguments.first} not founded in container.") if item.nil?
      return item, @room
    end
  end

  # Should take array with storage item names and a container instance that defaults to room's floor
  # Should return storage instance thats first object in storage_arguments or nil if one of arguments werent found
  def search_container(storage_arguments, container_instance)
    storage_arguments.reverse_each do |storage_name|
      storage_instance = get_instance(storage_name, container_instance)
      storage_instance.nil? ? return : container_instance = storage_instance
    end

    container_instance
  end

  # Gets item_name's instance and returns if its a Storage instance
  # Expects string and object with @storage variable and subclass of Storage
  # Should return item instance
  def get_instance(item_name, container_instance)
    return puts "#{container_instance.class} is not a container" unless container_instance.is_a?(Storage) || container_instance.is_a?(Player)

    container_instance.storage.each do |item|
      return item if [item.id[0..-1], item.id[0..-2], item.id[0..-3], item.id[0..-4]].include?(item_name) || item_name == item.name
    end

    return # Returns container_instance's storage otherwise
    # There always be the @floor container since ALL items in the room are accessed through it
  end
end
