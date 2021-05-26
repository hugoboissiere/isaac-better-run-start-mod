// Register the mod
// (which will make it show up in the list of mods on the mod screen in the main menu)
const betterRunStart = RegisterMod("betterRunStart", 1);
const game = Game();

function postGetCollectible(
	collectibleType: CollectibleType | int,
	_itemPoolType: ItemPoolType,
	_decrease: boolean,
	_seed: int,
): CollectibleType | int | null {

	let newItem = collectibleType;
	let level = game.GetLevel();
	let config = Isaac.GetItemConfig();
	let itemPool = game.GetItemPool();

	//checking if this is an item room on the first floor
	// TODO check if we're in downpour/dross since they're also considered as stage 1-1
	if (level.GetAbsoluteStage() == LevelStage.STAGE1_1 && level.GetCurrentRoom().GetType() == RoomType.ROOM_TREASURE) {
		//since generating a new item will call the callback again, a if works even tho a while seems more logical
		// TODO replace 2 by a value the user can choose
		if (config.GetCollectible(newItem).Quality < 2) {
			newItem = itemPool.GetCollectible(itemPool.GetPoolForRoom(level.GetCurrentRoom().GetType(), level.GetCurrentRoom().GetAwardSeed()), false, Random(), CollectibleType.COLLECTIBLE_NULL);
		}
	}

	return newItem;
}

betterRunStart.AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, postGetCollectible);