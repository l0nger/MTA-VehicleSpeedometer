--[[
  Author: l0nger <l0nger.programmer@gmail.com>
  Licence: GPLv2
  
  (c) 2015 <l0nger.programmer@gmail.com>
  
  -- Usefull notes:
  -- this code was used on the server 'our-game', but server was died
  -- probably this script has support for all resolutions (but i don't know how much percent is true)
]]

local screenW, screenH=GuiElement.getScreenSize()
local fontDistance=dxCreateFont('assets/distanceFont.ttf', 24)

-- utils functions 
-- this functions must be on top
local function dxDrawRelativeImage(startX, startY, width, height, image, rot, rotX, rotY, color, postGUI)
	dxDrawImage(startX * screenW, startY * screenH, width * screenW, height * screenH, image, rot or 0, rotX or 0, rotY or 0, color, postGUI or false)
end

local function dxDrawRelativeText(text, left, top, x, y, color, scale, font, x2, y2, clip, wordbreak, postGUI, colorcoded)
	dxDrawText(text, left * screenW, top * screenH, x * screenW, y * screenH, color, scale, font, x2, y2, clip, wordbreak or false, postGUI or false, colorcoded or true)
end

-- rendering
local function render()
  -- IMPORTANT:
  -- this code has not implemented algorithm fuel and mileage counter (you must write own implementation ;-))...
  
  
  -- if not localPlayer:getData('islogged') then return end 
	local veh=getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	
	local vel=veh.velocity
	local speed=(vel.x^2 + vel.y^2 + vel.z^2)^(0.5)
	local fuel=veh:getData('vehicle.fuel') or 0 -- if data==0 or nil
	local mileage=veh:getData('vehicle.mileage') or 0 -- if data==0 or nil 

	dxSetBlendMode('modulate_add')

	dxDrawRelativeImage(0.66, 0.61, 0.33, 0.49, 'assets/licznik.vag')
	dxDrawRelativeText(('%06d'):format(math.floor(mileage)), 0.84, 0.885, 0.925, 0.885, tocolor(255, 255, 255, 230), 0.7, fontDistance, 'center', 'center')
	dxDrawRelativeImage(0.7825, 0.61, 0.2, 0.46, 'assets/arrow.vag', -146+(speed*180))
	dxDrawRelativeImage(0.665, 0.77, 0.13, 0.3, 'assets/arrowFuel.vag', -55+(fuel))
	
	dxSetBlendMode('blend')
end
addEventHandler('onClientRender', root, render)

-- finaly!!! emmmm, EOF.
