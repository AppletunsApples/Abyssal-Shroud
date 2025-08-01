Battle::AbilityEffects::AccuracyCalcFromTarget.add(:SANDVEIL,
  proc { |ability, mods, user, target, move, type|
    mods[:defense_multiplier] *= 1.25 if target.effectiveWeather == :Sandstorm
  }
)

Battle::AbilityEffects::AccuracyCalcFromTarget.add(:SNOWCLOAK,
  proc { |ability, mods, user, target, move, type|
    mods[:special_defense_multiplier] *= 1.25 if target.effectiveWeather == :Hail
  }
)
