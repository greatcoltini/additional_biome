local Point3 = _radiant.csg.Point3

local WorkerClass = class()
local BaseJob = require 'jobs.base_job'
radiant.mixin(WorkerClass, BaseJob)

--[[
   A controller that manages all the relevant data about the worker class
   Workers don't level up, so this is all that's needed.
]]

function WorkerClass:initialize()
   BaseJob.initialize(self)
   self._sv.no_levels = true
   self._sv.is_max_level = true
end

-- Returns all the data for all the levels
function WorkerClass:get_level_data()
   return nil
end

-- Given the ID of a perk, find out if we have the perk. 
function WorkerClass:has_perk(id)
   return false
end

return WorkerClass
