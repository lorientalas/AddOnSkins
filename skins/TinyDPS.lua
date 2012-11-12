if IsAddOnLoaded("TinyDPS") then return end
local E, L, V, P, G,_ = unpack(ElvUI)
local AS = E:GetModule('AddOnSkins')

local name = "TinyDPSSkin"
local function SkinTinyDps(self)
	local frame = tdpsFrame
	local anchor = tdpsAnchor
	local status = tdpsStatusBar
	local tdps = tdps
	local font = tdpsFont
	local position = tdpsPosition
	local template
	if AS:CheckOption("EmbedTDPS") then template = "Default" else template = "Transparent" end
	frame:SetTemplate(template, true)
	
	if(tdps) then
		tdps.width = Minimap:GetWidth()
		tdps.spacing = 1
		tdps.barHeight = 14
		--font.name = AS:x.datatext_font
		--font.size = 12
		--font.outline = "OUTLINE"
	end

	if(status) then
		tdpsStatusBar:SetBackdrop( {
			bgFile = E["media"].normTex,
			edgeFile = E["media"].blank,
			tile = false,
			tileSize = 0,
			edgeSize = 1,
			insets = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0
			}
		})
		tdpsStatusBar:SetStatusBarTexture(E["media"].normTex)
	end
end
AS:RegisterSkin(name,SkinTinyDps)

function EmbedTDPS()
	if not IsAddOnLoaded("TinyDPS") then AS:DisableOption("EmbedTDPS") return end
	if TukuiChatBackgroundRight then tdpsFrame:SetParent(TukuiChatBackgroundRight) end
	if RightChatPanel then tdpsFrame:SetParent(RightChatPanel) end
	tdpsFrame:SetFrameStrata("MEDIUM")
	tdpsFrame.spacing = 0
	tdpsFrame.barHeight = 14
	tdpsVisibleBars = 9
	EmbedTDPSResize()
	tdpsAnchor:Point("TOPLEFT", EmbeddingWindow, "TOPLEFT", 0, 0)

	tdpsRefresh()
	if (AS:CheckOption("EmbedOoC")) then
		if (AS:CheckOption("EmbedTDPS")) then
			tdpsFrame:Hide()
		end
	end
end

function EmbedTDPSResize()
	tdpsFrame:SetWidth(EmbeddingWindow:GetWidth())
	tdpsRefresh()
end

local TinyDPS_Embed = CreateFrame("Frame",nil)
	TinyDPS_Embed:RegisterEvent("PLAYER_ENTERING_WORLD")
	TinyDPS_Embed:SetScript("OnEvent", function(self)
		if(AS:CheckOption("EmbedTDPS")) then
			EmbedTDPS()
		end
	end)