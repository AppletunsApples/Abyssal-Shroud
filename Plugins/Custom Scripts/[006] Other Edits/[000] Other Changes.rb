  # @return [Integer] the maximum HP of this Pokémon
  def calcHP(base, level, iv, ev)
    return 1 if base == 1   # For Shedinja
    ev = 0
    return (((base * 2) + iv + (ev / 4)) * level / 100).floor + level + 10
  end

  # @return [Integer] the specified stat of this Pokémon (not used for total HP)
  def calcStat(base, level, iv, ev, nat)
    ev = 0
    return (((((base * 2) + iv + (ev / 4)) * level / 100).floor + 5) * nat / 100).floor
  end

  # Screenshotting
  def pbScreenCapture
    t = Time.now
    filestart = t.strftime("[%Y-%m-%d] %H_%M_%S.%L")
    begin
      folder_name = "Screenshots"
      Dir.create(folder_name) if !Dir.safe?(folder_name)
      capturefile = folder_name + "/" + sprintf("%s.png", filestart)
      Graphics.screenshot(capturefile)
    rescue
      capturefile = RTP.getSaveFileName(sprintf("%s.png", filestart))
      Graphics.screenshot(capturefile)
    end
    pbSEPlay("Screenshot") if FileTest.audio_exist?("Audio/SE/Screenshot")
  end
