

class Player
  def initialize(name)
    @name = name
    @inventory = []
  end

  def storage
    @inventory
  end

  def stats(strength = 7, dexterity = 7, endurance = 7, focus = 7)
    @strength, @dexterity, @endurance, @focus = strength, dexterity, endurance, focus
  end

  def display_inventory
    puts "inventory\n+++++++++"
    @inventory.each_with_index do |item, index|
      puts "#{index + 1}. #{item.display}, #{item.text[0..25]}, " + (item.weight == 1 ? "#{item.weight} third" : "#{item.weight} thirds")
    end
  end
end