require_relative './command'
require_relative './room'

# This is the game handler that contains and handles all of the modules
class RPG
  include Command

  def initialize
    @room = Room.new('patchInForst', 'you stand in a small patch of trees whose canopy obscure the sky above.', :apple, :table, [:apple, :bowl, [:spud]], :apple)
    @playing = true
  end

  def game_cycle
    command while @playing
  end
end
