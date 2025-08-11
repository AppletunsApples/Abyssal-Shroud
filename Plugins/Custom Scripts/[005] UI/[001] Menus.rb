# PokeGear menu
MenuHandlers.add(:pause_menu, :encounters, {
  "name"      =>  _INTL("Encounters"),
  "order"     => 50,
  "effect"    => proc { |menu|
    pbPlayDecisionSE
    pbFadeOutIn {
      scene = EncounterList_Scene.new
      screen = EncounterList_Screen.new(scene)
      screen.pbStartScreen
      menu.pbRefresh
    }
    next false
  }
})

# Portable PC
MenuHandlers.add(:pokegear_menu, :pc, {
  "name"      => _INTL("Portable PC"),
  "icon_name" => "pc",
  "order"     => 40,
  "condition" => proc {(!$game_switches[Settings::DISABLE_BOX_LINK_SWITCH])},
  "effect"    => proc { |menu|
    pbFadeOutIn {
      scene = PokemonStorageScene.new
      screen = PokemonStorageScreen.new(scene, $PokemonStorage)
      screen.pbStartScreen(0)
    }
    next false
    }
  })

# Load Menu
MenuHandlers.add(:load_screen, :controls, {
  "name"      => _INTL("Controls"),
  "order"     => 61,
  "effect"    => proc { |screen|
  System.show_settings
  }
})