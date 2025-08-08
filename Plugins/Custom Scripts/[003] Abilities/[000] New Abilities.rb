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

# In Spirit
Battle::AbilityEffects::DamageCalcFromUser.add(:INSPIRIT,
  proc { |ability, user, target, move, mults, power, type|
    mults[:attack_multiplier] *= 1.5 if type == :GHOST
  }
)

# Judgement Day
Battle::AbilityEffects::OnSwitchIn.add(:JUDGEMENTDAY, 
proc { |ability, battler, battle|
  next if battler.fainted?
  battle.eachOtherSideBattler(battler.index) do |foe|
    next if foe.fainted?
    next if foe.effects[PBEffects::PerishSong] > 0
    foe.effects[PBEffects::PerishSong] = 3
    foe.effects[PBEffects::PerishSongUser] = battler.index
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1} was caught in the Death Song!", foe.pbThis))
    battle.pbHideAbilitySplash(battler)
  end
})

Battle::AbilityEffects::EndOfRoundEffect.add(:JUDGEMENTDAY,
proc { |ability, battler, battle|
  next if battler.fainted?
  battle.eachOtherSideBattler(battler.index) do |foe|
    next if foe.fainted?
    next if foe.effects[PBEffects::PerishSong] > 0
    foe.effects[PBEffects::PerishSong] = 3
    foe.effects[PBEffects::PerishSongUser] = battler.index
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1} was caught in the Death Song!", foe.pbThis))
    battle.pbHideAbilitySplash(battler)
  end
})

# Valor
Battle::AbilityEffects::OnEndOfUsingMove.add(:VALOR,
  proc { |ability, user, targets, move, battle|
    next if battle.pbAllFainted?(user.idxOpposingSide)
    numFainted = 0
    targets.each { |b| numFainted += 1 if b.damageState.fainted }
    next if numFainted == 0 || !user.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user)
    user.pbRaiseStatStageByAbility(:SPECIAL_ATTACK, numFainted, user)
  }
)