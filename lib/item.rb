module Storage
  attr_accessor :storage
end

class Base
  attr_reader(:id, :name)
  def initialize name, desc, weight
    @name, @description, @weight = name, desc, weight
    @id = name + generate_id
  end

  def generate_id
    rand(9).to_s + rand(9).to_s + rand(9).to_s + rand(9).to_s
  end

  def description
    puts "#{name}, #{text}"
  end

  def text
    @description
  end
end

class Item < Base
  def initialize name, desc, weight
    super name, desc, weight 
  end
end

class Container < Item
  include Storage

  def initialize name, desc, weight, space
    super name, desc, weight 
    @storage, @space = [], space
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
    @storage, @space = [], space
  end

  def description
    super
    puts "In it: #{storage.map(&:id).join(', ')}."
  end
end