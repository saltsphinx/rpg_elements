# Rpg-Elements
### *Version 0.0.1*

A second attempt at making RPG elements, here is my [previous]() attempt.

elements:
Command/Response system
- Should work for world interactions, menus and combat
- Should only parse input, have command list and call methods of other classes
- Should allow for command aliases

Item and world item system
- All items/world items should have base features
  - Name, description, weight, material, id
  - There should be subcatogries with their own features
    - Container/Vessal: Can hold items/liquids
      - Inventory/Sip space
      - Additonal description about contents

Room system
- Should have floor
  - The floor acts as the rooms inventory, it's just a simple array
  - It should have a name
    - This should be useful for auto travel if I decide to impliment such a feature
  - It should have a description
    - It should show the rooms name
    - The description should have flavor text about the room
    - It should list the items on the floor and world items
    - It should list npcs
    - It should list avaliable directions
  - Should have a surroundings list
    - This should contain NPC's
  - Should have entrances/exits
    - n, e, w, s, nw, ne, sw, se, up, down, in, out
    - If rooms are connected, their entrance/exit should be opposites
    - If there is something like a door, gate or rubbish in the way, the player must interact with the obstacle
  - There should be triggered events
    - It should be able to post additional flavor text
    - It should be able to spawn items and world items
    - It should be able to spawn npcs
    - All of these should have the option of being one time or not

Player system
- Should have inventory and carry weight system
  - Inventory space determined by equipment's inventory bonus
  - Carry weight affects action cost
    - Weight measurements units called thirds, they're a third of a pound
    - 100% carry weight increases action cost 50%
    - 120% carry weight increases action cost 150%
- Should be a status effect system
  - Applied affects, inflicted affects and casted affects
    - Applied affects are things like being posioned or dieased
      - Dice of 50, if the roll lands below 41 then the affect is applied
    - Inflicted affects are things like bleeding, wounds or stuns
      - These affects are applied depending on what has attacked you and the damage they have caused
      - Equipment have defense bonuses that add to the difficulty
      - Dice of 100, if roll lands below 91 then the affect is applied
    - Casted affects are things like temporary blindness or cursed
      - These affects are always applied unless the player has protections against them
- Should have a level system with classic RPG stats
  - strength: carry amount, strength actions
    - Strength in the roleplaying sense determines the build of the character. A strength of 1 could represent an frail elderly person or a small child while a strength of 7 could be an average adult person
    - 1 point of strength gives 14 carry amount

  - endurance: status resistance, hitpoint bonus
    - Endurance represents general health. An endurance of 1 would be sick and dieased, while a 7 would be healthy
    - Depending on the status effect(Things like 'deep wound' for example not included vs things like 'venomed'), there is a roll that decides rather the affect is applied
      - For every point of current hp, add 10 points of difficulty

  - dexterity: finess actions, to hit bonus
    - Dexterity represents accuracy. A 1 would be a clumsy drunk while a 12 would be a tightrope walker.

  - focus: intellegence bonus, to cast bonus