require_relative './hashes.rb'

module Command
  include Hashes

  def command
    command_line = parse; return @playing = false if command_line.nil?
    command = aliases command_line.shift
    return puts 'Not a command!' if command.nil?
    arguments = check_data command_line

    self.send(command, arguments)
  end

  def parse
    input = gets; return if input.nil?
    command_line = input.chomp.strip.split /\s+/
    command_line.reject! { |token| token.match /[^0-9a-z]|[0-9][a-z]|^$/i }
    command_line
  end

  def check_data arguments
    arguments.map do |argument|
      if argument.match /^\d$/
        argument.to_i
      else
        argument
      end
    end
  end

  def aliases cmd
    ALIASES[cmd.to_sym] unless cmd.nil?
  end

  def look arguments
    return @room.description if arguments.empty?
    puts 'Wrong argument types!' unless arguments.map(&:class).all? { |arg| arg == String }
    
    if arguments.size >= 2
      container = search_container arguments[1.. -1]; return puts "One of these aren't a container, #{arguments[1.. -1]}" if container.nil?
      item = get_instance arguments.first, container; return puts "#{arguments.first} not founded in container." if item.nil?
    else
      item = get_instance arguments.first, @room; return puts "#{arguments.first} not founded in container." if item.nil?
    end

    item.description
    # If there are more than 1 argument, assume its a depth search
  end

  def take arguments

  end

  def search_container storage_arguments, container_instance = @room.storage
    storage_arguments.reverse_each do |storage_name|
      storage_instance = get_instance(storage_name, container_instance)
      storage_instance.nil? ? return : container_instance = storage_instance
    end

    container_instance
  end

  #Gets item_name's instance and returns if its a Storage instance
  #Expects string and object with @storage variable and subclass of Storage
  def get_instance item_name, container_instance
    return puts "#{container_instance.class} is not a container" unless container_instance.is_a? Storage

    container_instance.storage.each do |item|
      if item.id == item_name || item_name.include?(item.name[0.. (item.name.size * 0.6)])
        return item
      end
    end

    return
    #There always be the @floor container
  end
end
