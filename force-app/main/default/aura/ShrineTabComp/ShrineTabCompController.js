({
    doInit : function(component, event, helper) {
        
        helper.regions(component);
        helper.shrines(component);
    },

    selectRegion : function(component, event, helper) {
        component.set("v.regionId", event.currentTarget.value);

        helper.resetPage(component);
        helper.shrines(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.shrines(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.shrines(component);
    }
})