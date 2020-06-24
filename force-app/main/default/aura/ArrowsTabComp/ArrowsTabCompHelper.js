({
    arrows : function(component) {
        var action = component.get("c.getArrows");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.arrows", result);
            }
        });

        $A.enqueueAction(action);
    }
})