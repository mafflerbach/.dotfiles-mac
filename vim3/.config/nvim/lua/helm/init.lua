function Helm ()

local function deploy()
   
--helm secrets upgrade --install   service-generic-event-receiver                         \
                                 --service-generic-event-receiver                         \
                     ----values    service-generic-event-receiver/values/stage/values.yaml  \
                     ----values    service-generic-event-receiver/values/stage/secrets.yaml \
                     ----namespace it-integration




end


return {
deploy = deploy
}
end
