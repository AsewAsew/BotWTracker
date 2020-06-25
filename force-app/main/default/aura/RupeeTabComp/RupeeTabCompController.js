({
    doInit : function(component, event, helper) {
        var action = component.get("c.getRupees");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.rupees", result);
            }
        });

        $A.enqueueAction(action);
    }
})
