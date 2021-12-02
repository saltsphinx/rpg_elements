require_relative './item'
require_relative './hashes'

module Archetype
  include Hashes

  def add_item(name, description, weight)
    Item.new name, description, weight
  end

  def add_container(name, description, weight, space)
    Container.new name, description, weight, space
  end

  def add_world_item(name, description, weight)
    WorldItem.new name, description, weight
  end

  def add_world_container(name, description, weight, space)
    WorldContainer.new name, description, weight, space
  end
end
