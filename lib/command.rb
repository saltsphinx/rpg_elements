require_relative './hashes.rb'

module Command
  include Hashes

  def command
    command_line = parse
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
    ALIASES[cmd.to_sym]
  end

  def inspect arguments
    puts 'Wrong number of arguments or wrong type!' unless arguments.size >= 1 && arguments.map(&:class).all? { |arg| arg == String }

    # If there are more than 1 argument, assume its a depth search
  end

  def take arguments

  end
end
