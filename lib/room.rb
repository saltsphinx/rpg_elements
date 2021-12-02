require_relative './archetype'
require_relative './item'
require_relative './hashes'

class Room
  include Archetype
  include Storage
  include Hashes

  def initialize name, desc, *params
    @name, @description = name, desc
    @floor = []
    generate_items(params) unless params.empty?
  end

  def generate_items params, container = self
    item = create_item_type ARCHETYPES[params.shift]
    if params.first.is_a? Array
      item_child = params.shift
      generate_items item_child, item 
    end

    container.storage << item
    generate_items params, container unless params.empty?
  end

  def create_item_type archetype
    item_class = archetype.last

    case
    when item_class == :WC
      add_world_container *archetype[0..-2]
    when item_class == :W
      add_world_item *archetype[0..-2]
    when item_class == :C
      add_container *archetype[0..-2]
    else
      add_item *archetype[0..-2]
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