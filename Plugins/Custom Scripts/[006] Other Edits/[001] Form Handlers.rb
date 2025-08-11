#===============================================================================
# Regional forms
# These species don't have visually different regional forms, but they need to
# evolve into different forms depending on the location where they evolve.
#===============================================================================
# Styxian Forms
MultipleForms.register(:PIKACHU, {
  "getForm" => proc { |pkmn|
    if $game_map
      map_pos = $game_map.metadata&.town_map_position
      next 1 if map_pos && map_pos[0] == 0   # Styx Isles region
    end
    next 0
  }
})

MultipleForms.copy(:GROVYLE, :MARSHTOMP, :CROCALOR)
