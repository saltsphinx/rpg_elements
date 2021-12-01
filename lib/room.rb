require_relative './archetype'
require_relative './item'

class Room < Storage
  include Archetype

  def initialize(name, desc, *params)
    @name, @description = name, desc
    @floor = []
    generate_room(params) unless params.empty?
  end

  def generate_room(params)
    params.each do |item_name|
      add_item *ARCHETYPES[item_name]
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