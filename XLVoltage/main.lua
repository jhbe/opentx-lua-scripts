--[[
Presents the Crossfire Lipo  Po voltage using a very large font.
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

-- Invoked repeatedly by OpenTX when the widget is visible.
--
local function refresh(widget)
  if widget      == nil then return end
  if widget.zone == nil then return end

  local voltage = getValue("RxBt")
  if voltage then
    lcd.drawText (widget.zone.x + 10, widget.zone.y + 10, string.format("% 4.1f   V", voltage), XXLSIZE)
  else
    lcd.drawText (widget.zone.x + 10, widget.zone.y + 10, "--.-   V", XXLSIZE)
  end
end


return {
  name      = "XLVoltage",
  options   = {},
  create    = create,
  update    = update,
  background= background,
  refresh   = refresh
}
