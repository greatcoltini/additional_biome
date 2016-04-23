local Entity = _radiant.om.Entity

local AttackMageInRange = class()

AttackMageInRange.name = 'attack mage in range'
AttackMageInRange.does = 'stonehearth:combat:attack'
AttackMageInRange.args = {
   target = Entity
}
AttackMageInRange.version = 2
AttackMageInRange.priority = 2
AttackMageInRange.weight = 1

function AttackMageInRange:start_thinking(ai, entity, args)
   local weapon = stonehearth.combat:get_main_weapon(entity)
   if not weapon or not weapon:is_valid() then
      return
   end

   if stonehearth.combat:in_range(entity, args.target, weapon) then
      ai:set_think_output()
   end
end

local ai = stonehearth.ai
return ai:create_compound_action(AttackMageInRange)
   :execute('stonehearth:bump_allies', {
      distance = 2,
   })
   :execute('additional_biomes:combat:attack_mage', {
      target = ai.ARGS.target,
   })
