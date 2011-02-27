----------------------------------------------------------------------------------------
--	Move vehicle indicator
----------------------------------------------------------------------------------------
local VehicleAnchor = CreateFrame("Frame", "VehicleAnchor", UIParent)
VehicleAnchor:SetPoint(unpack(SettingsCF.position.vehicle))
VehicleAnchor:SetSize(120, 20)
VehicleAnchor:SetMovable(true)
VehicleAnchor:SetClampedToScreen(true)
SettingsDB.SkinFadedPanel(VehicleAnchor)
VehicleAnchor:SetBackdropBorderColor(1, 0, 0)
VehicleAnchor:SetAlpha(0)
VehicleAnchor.text = VehicleAnchor:CreateFontString("VehicleAnchorText", "OVERLAY", nil)
VehicleAnchor.text:SetFont(SettingsCF.media.pixel_font, SettingsCF.media.pixel_font_size, SettingsCF.media.pixel_font_style)
VehicleAnchor.text:SetPoint("CENTER")
VehicleAnchor.text:SetText("Vehicle Anchor")

hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(_, _, parent)
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint("BOTTOM", VehicleAnchor, "BOTTOM", 0, 24)
		VehicleSeatIndicator:SetFrameStrata("LOW")
    end
end)

----------------------------------------------------------------------------------------
--	Vehicle indicator on mouseover
----------------------------------------------------------------------------------------
if SettingsCF.misc.vehicle_mouseover == true then
	local function VehicleNumSeatIndicator()
		if VehicleSeatIndicatorButton6 then
			SettingsDB.numSeat = 6
		elseif VehicleSeatIndicatorButton5 then
			SettingsDB.numSeat = 5
		elseif VehicleSeatIndicatorButton4 then
			SettingsDB.numSeat = 4
		elseif VehicleSeatIndicatorButton3 then
			SettingsDB.numSeat = 3
		elseif VehicleSeatIndicatorButton2 then
			SettingsDB.numSeat = 2
		elseif VehicleSeatIndicatorButton1 then
			SettingsDB.numSeat = 1
		end
	end

	local function vehmousebutton(alpha)
		for i = 1, SettingsDB.numSeat do
		local pb = _G["VehicleSeatIndicatorButton"..i]
			pb:SetAlpha(alpha)
		end
	end

	local function vehmouse()
		if VehicleSeatIndicator:IsShown() then
			VehicleSeatIndicator:SetAlpha(0)
			VehicleSeatIndicator:EnableMouse(true)
			
			VehicleNumSeatIndicator()
			
			VehicleSeatIndicator:HookScript("OnEnter", function() VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
			VehicleSeatIndicator:HookScript("OnLeave", function() VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)

			for i = 1, SettingsDB.numSeat do
				local pb = _G["VehicleSeatIndicatorButton"..i]
				pb:SetAlpha(0)
				pb:HookScript("OnEnter", function(self) VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
				pb:HookScript("OnLeave", function(self) VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)
			end
		end
	end
	hooksecurefunc("VehicleSeatIndicator_Update", vehmouse)
end