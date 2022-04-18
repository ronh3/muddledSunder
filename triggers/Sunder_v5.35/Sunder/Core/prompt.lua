cecho(" <red>[<white>" .. snd.target .. "<red>]")
if snd.offense_loaded then
  local msg
  snd.battle_aff = "none"
  snd.chasten_aff = "none"
  snd.last_cured = ""
  snd.rebounded = false
  snd.run_alerts()
  if #snd.alertness >= 1 and snd.toggles.affcalling then
    dir = snd.parseDir(snd.alertnessDir)
    msg = "wt [" .. string.upper(snd.alertType) .. "] -" .. string.upper(dir) .. "- "
    for i in pairs(snd.alertness) do
      msg = msg .. snd.alertness[i] .. " "
    end
    snd.send(msg)
  end
  snd.alertness = {}
  snd.alertnessDir = "none"
end

snd.last_affs = {}
snd.maybe_affs = {}
snd.last_limb_dmg = 0
snd.last_hit_limb = "none"
snd.defended = false
disableTrigger("Sunder Dodge")
disableTrigger("Sunder Parry")
disableTrigger("Sunder Rebounding")
snd.core()

if snd.delete_prompt then
  deleteLine()
  snd.delete_prompt = false
end

if snd.bashing_loaded or snd.toggles.fastwalk then

  if snd.new.area then
    if gmcp.Room.Info.area == "the Shattered Vortex" then
      x, y = string.match(gmcp.Char.Status.level, "(.*) (.*)")
      level = tonumber(x)
      if level < 100 then
        area = "the Shattered Vortex (Low Level)"
        elseif snd.faction == "spirit" then
        area = "the Shattered Vortex (Spirit)"
      elseif snd.faction == "shadow" then
        area = "the Shattered Vortex (Shadow)"
      end
      if area ~= snd.my.area then
        cecho("\n<green>Entering: " .. area)
        snd.load_targets(area)
        send(" ")
      end
    else
      cecho("\n<green>Entering: " .. gmcp.Room.Info.area)
      snd.load_targets(gmcp.Room.Info.area)
      send(" ")
    end
    snd.new.area = false
  end

  if snd.new.room and (snd.toggles.fasthunt or snd.toggles.fastwalk) then
    snd.ylem_check = false
    if bot.going and (snd.pathing or speedWalkCounter ~= 0) then

      return
    end

    if snd.toggles.fasthunt and snd.are_we_with_grouped() then
      snd.toggles.bashing = true
      snd.waiting.balance = false
      snd.room_clear = true
      snd.runBasher()
      snd.core()
    elseif bot.going then
      expandAlias("move")
    end
    -- send("who here", false)
  end
end

snd.new.room = false
