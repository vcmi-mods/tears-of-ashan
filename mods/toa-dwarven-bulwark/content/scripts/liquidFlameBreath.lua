local Base = require("combat/combatScript")
local Script = setmetatable({}, {__index = Base})
Script.__index = Script

function Script:getFirewallHexes(target)
	local hexes = target:getHexes()
	local result = {}
	for i = 1, hexes:size() do
		result[i] = hexes:at(i)
	end

	return result
end

function Script:makeFirewall(server, battle, hex, spell, side, power)
	local descriptor = {
		pos              = hex,
		obstacleType     = ENUM.ObstacleType.spellCreated,
		spell            = spell,
		casterSpellPower = power,
		spellLevel       = self.mastery or 0,
		casterSide       = side,
		turnsRemaining   = 2,
		hidden           = false,
		passable         = true,
		nativeVisible    = true,
		trap             = false,
		removeOnTrigger  = false,
		trigger          = "tears-of-ashan.toa-dwarven-bulwark:liquidFlameBreathTrigger",
		appearSound      = "FIREWALL",
		appearAnimation  = "spells/liquidFlameBreath/flameAppear",
		animation        = "spells/liquidFlameBreath/flameObstacle",
		removalAnimation = "spells/liquidFlameBreath/flameDisappear",
		customSize       = { hex },
	}

	server:addObstacle(battle, descriptor)
end

function Script:onAfterAttack(server, battle, unit, other, payload)
	if payload.attackIndex > 0 then return end
	local spell = LIBRARY:getSpellByName("tears-of-ashan.toa-dwarven-bulwark:liquidFlameBreath")
	local side = unit:getSide()
	local hexes = self:getFirewallHexes(other)
	local power = unit:getCount()
	for _, hex in ipairs(hexes) do
		self:makeFirewall(server, battle, hex, spell, side, power)
	end
end

return Script