def pbSurf
  return false if !$game_player.can_ride_vehicle_with_follower?
  return false if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_SURF, true)
  if pbConfirmMessage(_INTL("The water is a deep blue color... Would you like to use Surf on it?"))
    pbMessage(_INTL("\\PN started surfing!"))
    pbCancelVehicles
    pbHiddenMoveAnimation(nil)   # nil = no Pokémon animation
    surfbgm = GameData::Metadata.get.surf_BGM
    pbCueBGM(surfbgm, 0.5) if surfbgm
    pbStartSurfing
    return true
  end
  return false
end

def pbCanFly?(pkmn = nil, show_messages = false)
  return false if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_FLY, true)
  return false if !$DEBUG && !pkmn && !$player.get_pokemon_with_move(:FLY)
  if !$game_player.can_map_transfer_with_follower?
    pbMessage(_INTL("It can't be used when you have someone with you.")) if show_messages
    return false
  end
  if !$game_map.metadata&.outdoor_map
    pbMessage(_INTL("You can't use that here.")) if show_messages
    return false
  end
  return true
end