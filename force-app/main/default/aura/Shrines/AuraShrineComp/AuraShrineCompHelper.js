({
    disable : function(component) {
        var shrine = component.get("v.shrine");

        if(shrine.Completed__c == "Registered")
            component.set("v.disReg", true);
        if(shrine.Completed__c == "Completed")
            component.set("v.disCom", true);
    },

    updateShrine : function(component, shrine, co) {
        try{
        var action = component.get("c.setCompleted");

        action.setParams({
            s: shrine,
            c: co
        });

        action.setCallback(this, function(response) {
            console.log(response.getState());
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shrine", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
        } catch(error) {
            console.log(error);
        }
    }
})