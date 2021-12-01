
require_relative './item'
require_relative './hashes'

module Archetype
  include Hashes

  def add_item(name, description, weight, container = storage, *params)
    item = Item.new(name, description, weight)
    container << item
  end
end