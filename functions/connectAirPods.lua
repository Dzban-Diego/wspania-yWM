local awful          = require("awful")
local naughty        = require("naughty")

local function connectAirPods()
  local handle = io.popen("bluetoothctl info 9C:FC:28:55:02:CD")
  if handle == nil then
    naughty.notify({
      title = "Błąd połączenia",
      text = "Nie udało się połączyć z bluetoothctl"
    })
    return
  end
  local result = handle:read("*a")
  local resultWithoutWhiteSymbols = result:gsub("%s+", "")
  local isConnected = string.find(resultWithoutWhiteSymbols , "Connected:yes")

  if isConnected then
    naughty.notify({
      title = "Airpods",
      text = "Airpodsy są połączone, rozłączam..."
    })
    awful.spawn('bluetoothctl disconnect 9C:FC:28:55:02:CD')
  else
    naughty.notify({
      title = "Airpods",
      text = "Łączę z Airpodsy...",
    })
    awful.spawn('bluetoothctl connect 9C:FC:28:55:02:CD')
  end
  handle:close()
end

return connectAirPods
