({
    doInit : function(component, event, helper) {
        helper.disable(component);
    },

    regShrine : function(component, event, helper) {
        var shrine = component.get("v.shrine");
        helper.updateShrine(component, shrine, "Registered");
    },

    comShrine : function(component, event, helper) {
        var shrine = component.get("v.shrine");
        helper.updateShrine(component, shrine, "Completed");
    },
})