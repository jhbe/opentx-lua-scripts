--[[
Reads four switches (SC, SD, SE and SF) and present their meaning
when used with my ALZRC X360 helicopter. SC is the Flight or "Stunt" mode
and effectively controls the rotor RPM. SD is the Tail Lock and show
much the heli resist weather cocking. SE is the AutoLevel. SF is the
main Arming.

The location of the text somewhat mimics the location of the switch on the TX16S.
--]]

-- Invoked once by OpenTX when the widget is first created.
--
local function create(zone, options)
  return {zone = zone}
end

-- Invoked by OpenTX when options are changed.
--
local function update(widget, options)
  if widget == nil then return end

  widget.options = options
end

-- Invoked repeatedly by OpenTX when the widget is not visible.
--
local function background(widget)
  if widget == nil then return end
end


local function drawSwitch(x, y, name, value, down, middle, up)
  lcd.drawText (x, y, name, SMLSIZE)
  if value < 0 then
    lcd.drawText (x, y + 15, down, DBLSIZE)
  elseif value > 0 then
    lcd.drawText (x, y + 15, up, DBLSIZE)
  else
    lcd.drawText (x, y + 15, middle, DBLSIZE)
  end  
end

-- Invoked repeatedly by OpenTX when the widget is visible.
--
local function refresh(widget)
  if widget      == nil then return end
  if widget.zone == nil then return end

  local stuntMode = getValue(getFieldInfo("sc").id)
  local tailLock  = getValue(getFieldInfo("sd").id)
  local autoLevel = getValue(getFieldInfo("se").id)
  local arm       = getValue(getFieldInfo("sf").id)
  
  drawSwitch(widget.zone.x + 150, widget.zone.y + 100, "SC - Mode"    , stuntMode, "Normal", "ONE", "TWO")
  drawSwitch(widget.zone.x + 300, widget.zone.y + 100, "SD - TailLock", tailLock , "-", "?", "LOCK")
  drawSwitch(widget.zone.x +  20, widget.zone.y + 100, "SE - AutoLvl" , autoLevel, "-", "?", "LEVEL")
  drawSwitch(widget.zone.x +  20, widget.zone.y + 20 , "SF - Arm"     , arm      , "ARMED", "-", "-")
end


return {
  name      = "HeliStat",
  options   = {},
  create    = create,
  update    = update,
  background= background,
  refresh   = refresh
}
