Battle::PokeBallEffects::ModifyCatchRate.add(:FLUTTERBALL, proc { |ball, catchRate, battle, battler|
  if battler.pokemon.species_data.has_flag?("Styxian")
    catchRate *= 3
  else
    catchRate *= 1
  end
  next catchRate
})