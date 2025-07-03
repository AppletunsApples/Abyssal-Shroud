#===============================================================================
# Poisonous Pinch
#===============================================================================
Battle::AbilityEffects::OnBeingHit.add(:POISONPOINT,
  proc { |ability, user, target, move, battle|
    next if !move.pbContactMove?(user)
    next if user.poisoned? || battle.pbRandom(100) >= 30
    battle.pbShowAbilitySplash(target)
    if user.pbCanPoison?(target, Battle::Scene::USE_ABILITY_SPLASH) &&
       user.affectedByContactEffect?(Battle::Scene::USE_ABILITY_SPLASH)
      msg = nil
      if !Battle::Scene::USE_ABILITY_SPLASH
        msg = _INTL("{1}'s {2} poisoned {3}!", target.pbThis, target.abilityName, user.pbThis(true))
      end
      user.pbPoison(target, msg)
    end
    battle.pbHideAbilitySplash(target)
  }
)

Battle::AbilityEffects::OnBeingHit.copy(:POISONPOINT, :POISONOUSPINCH)

Battle::AbilityEffects::OnDealingHit.add(:POISONTOUCH,
  proc { |ability, user, target, move, battle|
    next if !move.contactMove?
    next if battle.pbRandom(100) >= 30
    battle.pbShowAbilitySplash(user)
    if target.hasActiveAbility?(:SHIELDDUST) && !battle.moldBreaker
      battle.pbShowAbilitySplash(target)
      if !Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} is unaffected!", target.pbThis))
      end
      battle.pbHideAbilitySplash(target)
    elsif target.pbCanPoison?(user, Battle::Scene::USE_ABILITY_SPLASH)
      msg = nil
      if !Battle::Scene::USE_ABILITY_SPLASH
        msg = _INTL("{1}'s {2} poisoned {3}!", user.pbThis, user.abilityName, target.pbThis(true))
      end
      target.pbPoison(user, msg)
    end
    battle.pbHideAbilitySplash(user)
  }
)

Battle::AbilityEffects::OnBeingHit.copy(:POISONTOUCH, :POISONOUSPINCH)

#===============================================================================
# Hydraulics
#===============================================================================
Battle::AbilityEffects::StatLossImmunity.add(:CLEARBODY,
  proc { |ability, battler, stat, battle, showMessages|
    if showMessages
      battle.pbShowAbilitySplash(battler)
      if Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1}'s stats cannot be lowered!", battler.pbThis))
      else
        battle.pbDisplay(_INTL("{1}'s {2} prevents stat loss!", battler.pbThis, battler.abilityName))
      end
      battle.pbHideAbilitySplash(battler)
    end
    next true
  }
)

Battle::AbilityEffects::StatLossImmunity.copy(:CLEARBODY, :WHITESMOKE, :HYDRAULICS)

#===============================================================================
# Sparkling Snow
#===============================================================================
Battle::AbilityEffects::OnSwitchIn.add(:SPARKLINGSNOW,
proc { |ability, battler, battle, switch_in|
      battle.pbStartWeatherAbility(:Snow, battler)
      next if battler.pbOwnSide.effects[PBEffects::AuroraVeil] > 0
      battler.pbOwnSide.effects[PBEffects::AuroraVeil] = 5
      battler.pbOwnSide.effects[PBEffects::AuroraVeil] = 8 if battler.hasActiveItem?(:LIGHTCLAY)
    battle.pbDisplay(_INTL("{1} made {2} stronger against physical and special moves!",
                            battler.name, battler.pbTeam(true)))
    }
)

#===============================================================================
# Plucky
#===============================================================================
Battle::AbilityEffects::OnBeingHit.add(:WEAKARMOR,
  proc { |ability, user, target, move, battle|
    next if !move.physicalMove?
    next if !target.pbCanLowerStatStage?(:DEFENSE, target) &&
            !target.pbCanRaiseStatStage?(:SPEED, target)
    battle.pbShowAbilitySplash(target)
    target.pbLowerStatStageByAbility(:DEFENSE, 1, target, false)
    target.pbRaiseStatStageByAbility(:SPEED,
       (Settings::MECHANICS_GENERATION >= 7) ? 2 : 1, target, false)
    battle.pbHideAbilitySplash(target)
  }
)

Battle::AbilityEffects::OnBeingHit.copy(:WEAKARMOR, :PLUCKY)

#===============================================================================
# Snow Force
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:SNOWFORCE,
  proc { |ability, user, target, move, mults, power, type|
    if user.effectiveWeather == :Snow && type == :ICE
      mults[:power_multiplier] *= 1.3
    end
  }
)