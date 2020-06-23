({
    disable : function(component) {
        var o = component.get("v.shrineReward.Obtained__c");
        var r = component.get("v.shrineReward.Repeatable__c");

        component.set("v.disReward", (o && !r));
    }
})
