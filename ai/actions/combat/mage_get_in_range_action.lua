local Entity = _radiant.om.Entity
local Point3 = _radiant.csg.Point3

local MageGetInRange = class()

MageGetInRange.name = 'Mage unit try get in range'
MageGetInRange.does = 'stonehearth:combat:get_in_range'
MageGetInRange.args = {
   target = Entity
}
MageGetInRange.version = 2
MageGetInRange.priority = 2
MageGetInRange.weight = 1

local function InRange(entity, target)
   local weapon = stonehearth.combat:get_main_weapon(entity)
   if not weapon or not weapon:is_valid() then
      return false
   end
   
   local result = stonehearth.combat:in_range(entity, target, weapon)
   return result
end

function MageGetInRange:start_thinking(ai, entity, args)
   local weapon = stonehearth.combat:get_main_weapon(entity)
   if not weapon or not weapon:is_valid() then
      return
   end

   -- We only think if the target is not in range.
   -- This prevents unnecessary pathfinding when we can already shoot the target.
   if not stonehearth.combat:in_range(entity, args.target, weapon) then
      ai:set_think_output()
   end
end

local ai = stonehearth.ai
return ai:create_compound_action(MageGetInRange)
   :execute('stonehearth:chase_entity', {
      target = ai.ARGS.target,
      grid_location_changed_cb = InRange,
   })
   :execute('stonehearth:bump_allies', {
      distance = 2,
   })