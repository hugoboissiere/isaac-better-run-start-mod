
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file)
    if ____moduleCache[file] then
        return ____moduleCache[file]
    end
    if ____modules[file] then
        ____moduleCache[file] = ____modules[file]()
        return ____moduleCache[file]
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["main"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
betterRunStart = RegisterMod("betterRunStart", 1)
game = Game()
function postGetCollectible(self, collectibleType, _itemPoolType, _decrease, _seed)
    local newItem = collectibleType
    local level = game:GetLevel()
    local config = Isaac.GetItemConfig()
    local itemPool = game:GetItemPool()
    if (level:GetAbsoluteStage() == LevelStage.STAGE1_1) and (level:GetCurrentRoom():GetType() == RoomType.ROOM_TREASURE) then
        if config:GetCollectible(newItem).Quality < 2 then
            newItem = itemPool:GetCollectible(
                itemPool:GetPoolForRoom(
                    level:GetCurrentRoom():GetType(),
                    level:GetCurrentRoom():GetAwardSeed()
                ),
                false,
                Random(),
                CollectibleType.COLLECTIBLE_NULL
            )
        end
    end
    return newItem
end
betterRunStart:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, postGetCollectible)
end,
}
return require("main")
