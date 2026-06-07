#===============================================================================
# In Spirit
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:INSPIRIT,
  proc { |ability, user, target, move, mults, power, type|
    mults[:attack_multiplier] *= 1.5 if type == :GHOST
  }
)

#===============================================================================
# Valor
#===============================================================================
Battle::AbilityEffects::OnEndOfUsingMove.add(:VALOR,
  proc { |ability, user, targets, move, battle|
    next if battle.pbAllFainted?(user.idxOpposingSide)
    numFainted = 0
    targets.each { |b| numFainted += 1 if b.damageState.fainted }
    next if numFainted == 0 || !user.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user)
    user.pbRaiseStatStageByAbility(:SPECIAL_ATTACK, numFainted, user)
  }
)


#===============================================================================
# Reaper's Due
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:REAPERSDUE,
  proc { |ability, user, target, move, mults, baseDmg, type|
    bonus = user.effects[PBEffects::ReapersDue]
    next if bonus <= 0
    mults[:power_multiplier] *= (1 + (0.1 * bonus))
  }
)

Battle::AbilityEffects::OnSwitchIn.add(:REAPERSDUE,
  proc { |ability, battler, battle, switch_in|
    numFainted = [5, battler.num_fainted_allies].min
    next if numFainted <= 0
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1} gained strength from the fallen!", battler.pbThis))
    battler.effects[PBEffects::ReapersDue] = numFainted
    battle.pbHideAbilitySplash(battler)
  }
)
