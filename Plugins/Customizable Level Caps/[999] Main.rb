  def crosses_level_cap?
    return self.level >= LEVEL_CAPS[$game_variables[27]]
  end