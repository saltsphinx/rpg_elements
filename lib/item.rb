class Base; end
class Storage; end

class Item < Base
  attr_reader :id, :name
  def initialize(name, desc, weight)
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