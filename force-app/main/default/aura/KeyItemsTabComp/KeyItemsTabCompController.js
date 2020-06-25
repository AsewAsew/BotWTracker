({
    doInit : function(component, event, helper) {
        helper.keyItems(component);
    },

    selectType : function(component, event, helper) {
        component.set("v.archetype", event.currentTarget.value);
        helper.resetPage(component);
        helper.keyItems(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.keyItems(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.keyItems(component);
    }
})
