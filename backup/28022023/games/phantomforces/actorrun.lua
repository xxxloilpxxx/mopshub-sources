getactors = getactors
syn = syn

local function findByName(t, name) for _, v in pairs(t) do if v.name == name then return v end end end
local actor = findByName(getactors(), 'lol')
syn.run_on_actor(actor, [[
	
]])