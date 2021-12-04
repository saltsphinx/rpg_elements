require_relative './item'
require_relative './hashes'

module Archetype
  include Hashes

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

  def add_item(name, description, weight)
    Item.new(name, description, weight)
  end

  def add_container(name, description, weight, space)
    Container.new(name, description, weight, space)
  end

  def add_stackable(name, description, weight, stack_limit)
    Stackable.new(name, description,weight, stack_limit)
  end

  def add_world_item(name, description, weight)
    WorldItem.new(name, description, weight)
  end

  def add_world_container(name, description, weight, space)
    WorldContainer.new(name, description, weight, space)
  end
end
