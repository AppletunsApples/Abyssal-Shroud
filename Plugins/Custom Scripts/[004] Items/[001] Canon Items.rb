# Hopo Berry
ItemHandlers::UseOnPokemon.add(:ELIXIR, proc { |item, qty, pkmn, scene|
  pprestored = 0
  pkmn.moves.length.times do |i|
    pprestored += pbRestorePP(pkmn, i, 10)
  end
  if pprestored == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pbSEPlay("Use item in party")
  scene.pbDisplay(_INTL("PP was restored."))
  next true
})

ItemHandlers::CanUseInBattle.add(:ELIXIR, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if !pokemon.able?
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  canRestore = false
  pokemon.moves.each do |m|
    next if m.id == 0
    next if m.total_pp <= 0 || m.pp == m.total_pp
    canRestore = true
    break
  end
  if !canRestore
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  next true
})

ItemHandlers::CanUseInBattle.copy(:ELIXIR, :MAXELIXIR, :HOPOBERRY)

# Poke Balls
Battle::PokeBallEffects::ModifyCatchRate.add(:GEODEBALL, proc { |ball, catchRate, battle, battler|
items=[:FIRESTONE,:WATERSTONE,:THUNDERSTONE,:LEAFSTONE,:MOONSTONE,:SUNSTONE,:DUSKSTONE,:DAWNSTONE,:SHINYSTONE,:ICESTONE]
items.each do |i|
  stone = GameData::Item.try_get(i)
  next unless stone
  if battler.pokemon.species_data.family_item_evolutions_use_item?(stone.id)
    catchRate *= 3
    break
  end
 end
next [catchRate, 255].min
})

Battle::PokeBallEffects::ModifyCatchRate.add(:SAFARIBALL, proc { |ball, catchRate, battle, battler|
  catchRate *= 2 if $game_map.metadata&.has_flag?("SafariZone")
  next catchRate
})

Battle::PokeBallEffects::ModifyCatchRate.add(:CHERISHBALL, proc { |ball, catchRate, battle, battler|
  catchRate *= 3 if battler.pokemon.species_data.has_flag?("Legendary") || battler.pokemon.species_data.has_flag?("Mythical")
  next catchRate
})

Battle::PokeBallEffects::ModifyCatchRate.add(:SPORTBALL, proc { |ball, catchRate, battle, battler|
  catchRate *= 2.5 if battler.pbHasType?(:BUG) || battler.pbHasType?(:FIGHTING)
  next catchRate
})

Battle::PokeBallEffects::ModifyCatchRate.add(:STRANGEBALL, proc { |ball, catchRate, battle, battler|
  mult = 1  
  player_mons = battle.allSameSideBattlers.select { |b| b.pbOwnedByPlayer? }
  player_mons.each do |pkmn|
    m = 1
    check = (battler.types - pkmn.types)
    if check.empty?
      m = (battler.types.length > 1 ? 4 : 2)
    elsif check.length < battler.types.length
      m = 2
    end
    mult = m if m > mult
  end
  catchRate *= mult
  next catchRate
})