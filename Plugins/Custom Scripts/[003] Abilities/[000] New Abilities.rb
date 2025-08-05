# Diamond Dust
Battle::AbilityEffects::OnSwitchIn.add(:DIAMONDDUST,
proc { |ability, battler, battle, switch_in|
      battle.pbStartWeatherAbility(:Snow, battler)
      next if battler.pbOwnSide.effects[PBEffects::AuroraVeil] > 0
      battler.pbOwnSide.effects[PBEffects::AuroraVeil] = 5
      battler.pbOwnSide.effects[PBEffects::AuroraVeil] = 8 if battler.hasActiveItem?(:LIGHTCLAY)
    battle.pbDisplay(_INTL("{1} made {2} stronger against physical and special moves!",
                            battler.name, battler.pbTeam(true)))
    }
)