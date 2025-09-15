--Creatred by GTFreeFlyer
--This script grabs the UCID of players when they change slots or when they kill another player and logs it.
--Place this script in the ...Saved Games\DCS\Scripts\Hooks\ folder on the server.

local UCID_Grabber = {}

function UCID_Grabber.onPlayerChangeSlot(playerID)
	local _ucid = net.get_player_info(playerID, 'ucid')
	local _slotID = net.get_player_info(playerID, 'slot')
	local _playerName = net.get_player_info(playerID, 'name')

	net.log("Player: " .._playerName.. " entered slot " .. _slotID .. ". UCID: " .. _ucid)
	
	return true -- allow the player to connect
end

function UCID_Grabber.onGameEvent(eventName, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	--"kill", killerPlayerID, killerUnitType, killerSide, victimPlayerID, victimUnitType, victimSide, weaponName
	if eventName == "kill" then
		local _ucid = net.get_player_info(arg1, 'ucid')
		local _playerName = net.get_player_info(arg1, 'name')
		net.log("Killer name: " .. _playerName .. ". UCID: " .. _ucid)
	end
end

DCS.setUserCallbacks(UCID_Grabber)

net.log("Loaded UCID grabber by GTFreeFlyer")
