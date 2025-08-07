# Will O Wisp
class Battle::Move::BurnTargetAlwaysHitsInSun < Battle::Move::BurnTarget
  def pbBaseAccuracy(user, target)
    return 0 if [:Sun, :HarshSun].include?(target.effectiveWeather)
    return super
  end
end
