({
    doInit : function(component, event, helper) {
        helper.regions(component);
        helper.quests(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.quests(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.quests(component);
    },

    selectRegion : function(component, event, helper) {
        component.set("v.regionId", event.currentTarget.value);

        helper.resetPage(component);
        helper.quests(component);
    },

    selectType : function(component, event, helper) {
        component.set("v.type", event.currentTarget.value);

        helper.resetPage(component);
        helper.quests(component);
    }
})