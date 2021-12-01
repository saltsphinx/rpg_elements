require_relative './command'
require_relative './room'

# This is the game handler that contains and handles all of the modules
class RPG
  include Command

  def initialize
    @room = Room.new('patchInForst', "you stand in a small patch of trees whose canopy obscure the sky above.", :apple, :apple, :spud)
    @playing = true
  end

  def game_cycle
    while @playing do
      command
    end
  end
end