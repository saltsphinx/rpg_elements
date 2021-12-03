require_relative './archetype'
require_relative './item'
require_relative './hashes'

class Room
  include Archetype
  include Storage
  include Hashes

  def initialize name, desc, *params
    @name = name
    @description = desc
    @floor = []
    generate_items(params) unless params.empty?
  end

  def generate_items params, container = self
    item = create_item_type ARCHETYPES[params.shift]
    if params.first.is_a? Array
      item_child = params.shift
      generate_items item_child, item
    elsif params.first.is_a? Integer
      if params.first > item.stack_limit
        params[0] -= item.stack_limit
        params.unshift(item.name.to_sym)
        item.quantity = item.stack_limit
      else
        item.quantity = params.shift
      end
    end

    container.storage << item
    generate_items params, container unless params.empty?
  end

  def create_item_type archetype
    item_class = archetype.last

    case item_class
    when :C then add_container(*archetype[0..-2])
    when :S then add_stackable(*archetype[0..-2])
    when :W then add_world_item(*archetype[0..-2])
    when :WC then add_world_container(*archetype[0..-2])
    else add_item(*archetype[0..-2])
    end
  end

  def description
    puts text.capitalize
    puts "Items on floor: #{storage.map(&:id).join ', '}."
  end

  def text
    @description
  end

  def storage
    @floor
  end
end
