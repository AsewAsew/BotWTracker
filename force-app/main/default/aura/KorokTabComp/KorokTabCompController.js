({
    doInit : function(component, event, helper) {
        var action = component.get("c.getRegions");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.regions", result);
            }
        });

        $A.enqueueAction(action);
    }
})
