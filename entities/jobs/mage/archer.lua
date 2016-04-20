local ArcherClass = class()
local CombatJob = require 'jobs.combat_job'

radiant.mixin(ArcherClass, CombatJob)

return ArcherClass