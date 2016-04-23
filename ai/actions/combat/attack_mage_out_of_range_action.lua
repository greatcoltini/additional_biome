local Entity = _radiant.om.Entity
local Point3 = _radiant.csg.Point3

local AttackMageOutOfRange = class()

AttackMageOutOfRange.name = 'attack mage out of range'
AttackMageOutOfRange.does = 'stonehearth:combat:attack'
AttackMageOutOfRange.args = {
   target = Entity
}
AttackMageOutOfRange.version = 2
AttackMageOutOfRange.priority = 2
AttackMageOutOfRange.weight = 1


local ai = stonehearth.ai
return ai:create_compound_action(AttackMageOutOfRange)
   :execute('stonehearth:combat:get_in_range', {
      target = ai.ARGS.target
   })
   :execute('additional_biomes:combat:attack_mage', {
      target = ai.ARGS.target,
   })
