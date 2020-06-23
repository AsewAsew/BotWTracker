({
    doInit : function(component, event, helper) {
        helper.disable(component);
        var r = component.get("v.shrineReward.Repeatable__c");
        var c = component.get("v.btnClass");
        c += r ? " slds-button_success" : " slds-button_brand";
        
        component.set("v.btnClass", c);
    },

    updateShrineReward : function(component, event, helper) {
        if(component.get("v.shrineReward.Obtained__c")) return;
        var action = component.get("c.setObtained");

        action.setParams({
            sr: component.get("v.shrineReward")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shrineReward", result);
                helper.disable(component);
            }
        });

        $A.enqueueAction(action);
    },
})
