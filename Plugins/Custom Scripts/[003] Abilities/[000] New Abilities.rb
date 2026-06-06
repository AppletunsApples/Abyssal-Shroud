# In Spirit
Battle::AbilityEffects::DamageCalcFromUser.add(:INSPIRIT,
  proc { |ability, user, target, move, mults, power, type|
    mults[:attack_multiplier] *= 1.5 if type == :GHOST
  }
)

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
