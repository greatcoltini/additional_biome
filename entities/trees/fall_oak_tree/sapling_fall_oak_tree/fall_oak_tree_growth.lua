--This optional class gates a crop's ability to get to the next level

local fall_oak_tree_growth_class = {}

--Corn can only progress to level 5 corn if it's on really good dirt
function fall_oak_tree_growth_class.growth_check(entity, target_growth_stage, growth_attempts)
   return target_growth_stage
end

return fall_oak_tree_growth_class