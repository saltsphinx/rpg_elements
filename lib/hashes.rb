module Hashes
  ALIASES = {
    look: :look,
    inspect: :look,
    l: :look,
    take: :take,
    grab: :take,
    t: :take,
    buy: :buy,
    b: :buy,
    drop: :drop,
    put: :drop,
    d: :drop
    steal: :steal,
    interact: :interact,
    i: :interact
  }.freeze

  ARCHETYPES = {
    apple: ['apple', 'a large red apple the size of a tossing ball', 1, :I],
    spud: ['spud', 'a rough and earthy spud', 1, :I],
    table: ['table', 'a wooden table', 65, 20, :WC],
    bowl: ['bowl', 'a wooden bowl with a wide brim', 1, 3, :C],
    strawberry: ['strawberry', 'a small red berry', 1, 8, :S],
  }.freeze
end
