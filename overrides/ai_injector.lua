local AiInjector = class()

function AiInjector:__init(entity, ai)
   self._entity = entity
   self._injected = {
      actions = {},
      observers = {},
   }

   self._log = radiant.log.create_logger('ai.injector')
                              :set_entity(self._entity)

   self:_flatten_ai(ai)
   self:_inject_ai()
end

function AiInjector:_flatten_ai(ai)
   if ai.actions then
      for _, uri in ipairs(ai.actions) do
         self._injected.actions[uri] = true
      end
   end

   if ai.observers then
      for _, uri in ipairs(ai.observers) do
         self._injected.observers[uri] = true
      end
   end

   if ai.ai_packs then
      for _, uri in pairs(ai.ai_packs) do
         self:_flatten_ai_pack(uri)
      end
   end
end

function AiInjector:_flatten_ai_pack(uri)
   local ai = radiant.resources.load_json(uri, true)
   self:_flatten_ai(ai)
end

function AiInjector:_inject_ai()
   self:_inject_actions()
   self:_inject_observers()
end

function AiInjector:_inject_actions()
   local aic = self._entity:add_component('stonehearth:ai')
   for uri in pairs(self._injected.actions) do
      aic:add_action(uri)
   end
end

function AiInjector:_inject_observers()
   local obs = self._entity:add_component('stonehearth:observers')
   for uri in pairs(self._injected.observers) do
      obs:add_observer(uri)
   end
end

function AiInjector:destroy()
   if not self._entity:is_valid() then
      self._log:info('entity destroyed before revoking injected ai')
      return
   end

   self._log:info('revoking injected ai')

   local ai = self._entity:add_component('stonehearth:ai')
   for uri in pairs(self._injected.actions) do
      ai:remove_action(uri)
   end

   local obs = self._entity:add_component('stonehearth:observers')
   for uri in pairs(self._injected.observers) do
      obs:remove_observer(uri)
   end
end

return AiInjector
