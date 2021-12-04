module Storage
  attr_accessor :storage
end

class Base
  attr_reader(:id, :name, :weight)
  def initialize name, desc, weight
    @name = name
    @description = desc
    @weight = weight
    @id = name + generate_id
  end

  def generate_id
    rand(9).to_s + rand(9).to_s + rand(9).to_s + rand(9).to_s
  end

  def description
    puts "#{id}, #{text}"
  end

  def text
    @description
  end

  def display
    id
  end
end

class Item < Base
  def initialize name, desc, weight
    super(name, desc, weight)
  end
end

class Stackable < Item
  attr_accessor :quantity
  attr_reader :stack_limit

  def initialize name, desc, weight, stack_limit
    super(name, desc, weight)
    @stack_limit, @quantity = stack_limit, 1
  end

  def description
    puts "#{quantity}x #{id}, #{text}"
  end

  def display
    "#{quantity}x " + super
  end
end

class Container < Item
  include Storage

  def initialize name, desc, weight, space
    super name, desc, weight
    @storage = []
    @space = space
  end

  def description
    super
    puts "In it: #{storage.map(&:id).join(', ')}."
  end
end

class WorldItem < Base
  def initialize(name, desc, weight)
    super name, desc, weight
  end
end

class WorldContainer < WorldItem
  include Storage

  def initialize name, desc, weight, space
    super name, desc, weight
    @storage = []
    @space = space
  end

  def description
    super
    puts "In it: #{storage.map(&:id).join(', ')}."
  end
end
