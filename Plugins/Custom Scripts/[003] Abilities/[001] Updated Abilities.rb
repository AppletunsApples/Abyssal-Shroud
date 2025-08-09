Battle::AbilityEffects::DamageCalcFromTarget.add(:SANDVEIL,
  proc { |ability, mods, weather, user, target, type|
    next unless weather == :Sandstorm
    mults[:defense_multiplier] *= 1.25
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:SNOWCLOAK,
  proc { |ability, mods, weather, user, target, type|
  next unless weather == :Hail
    mods[:special_defense_multiplier] *= 1.25
  }
)
