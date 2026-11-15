local Script = setmetatable({}, {__index = Base})
Script.__index = Script

function Script:isReceptive(mechanics, unit)
-- Ascertaining a TRUE/FALSE statment for the RECEPTIVE mechanic based on the interaction with a UNIT.
	if mechanics:getSpell():getJsonKey() == "tears-of-ashan:lightningBreath" then
-- If the spell is Lightning Breath...
		if mechanics:getCasterSide() == unit:getSide() then
-- AND if the CASTER SIDE is equal == to the UNIT SIDE...
			return false
-- Then the CASTER SIDE's UNITS are not receptive to the spell, thus they are unaffected by it.
		end
	end
	
	return Base.isReceptive(self, mechanics, unit)
-- Returns the value to the code that called it, allowing the script to function properly (otherwise the result will be ascertained but unused); returned values can be stored, passed to other functions, or used in expressions.
end

return Script