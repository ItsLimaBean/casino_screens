local screenTypes = {
    ["diamonds"] = "CASINO_DIA_PL",
    ["skulls"] = "CASINO_HLW_PL",
    ["snowflakes"] = "CASINO_SNWFLK_PL",
    ["winner"] = "CASINO_WIN_PL"
}

local running = true
local inCasino = false

local interiorId = 275201

local targetName = "casinoscreen_01"
local targetModel = 1800987616

local textureDict = "Prop_Screen_Vinewood"
local textureName = "BG_Wall_Colour_4x4"

Citizen.CreateThread(function() 
    while running do 
        if inCasino ~= (GetInteriorFromEntity(PlayerPedId()) == interiorId) then 
            inCasino = not inCasino
            ToggleCasinoScreens(inCasino)
        end

        Citizen.Wait(2000)
    end
end)

function ToggleCasinoScreens(toggle) 
    if toggle then 
        RequestStreamedTextureDict(textureDict, 0)
        while not HasStreamedTextureDictLoaded(textureDict) do
            Citizen.Wait(100)
        end
    
        RegisterNamedRendertarget(targetName, 0)
        LinkNamedRendertarget(targetModel)
    
        SetScreenType()
    
        local rendertarget = GetNamedRendertargetRenderId(targetName)
        Citizen.CreateThread(function() 
            while inCasino do 
                SetTextRenderId(rendertarget)
                SetScriptGfxDrawOrder(4)
                SetScriptGfxDrawBehindPausemenu(true)
                DrawInteractiveSprite(textureDict, textureName, 0.25, 0.5, 0.5, 1.0, 0.0, 255, 255, 255, 255)
                DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                SetTextRenderId(1)
                Citizen.Wait(0)
            end
        end)
    else 
        ReleaseNamedRendertarget(targetName)
        SetStreamedTextureDictAsNoLongerNeeded(textureDict)
        SetTvChannel(-1)
    end
end

function SetScreenType(type) 
    SetTvChannelPlaylist(0, screenTypes[type or "diamonds"], true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(0)
end

exports("SetScreenType", SetScreenType)

AddEventHandler("onClientResourceStop", function(resource) 
    if resource == GetCurrentResourceName() then 
        running = false
        inCasino = false
    end
end)