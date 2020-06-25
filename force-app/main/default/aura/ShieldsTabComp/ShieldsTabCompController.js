({
    doInit : function(component, event, helper) {
        helper.archetypes(component);
        helper.shields(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.shields(component);
    },

    selectType : function(component, event, helper) {
        component.set("v.archetype", event.currentTarget.value);

        helper.resetPage(component);
        helper.shields(component);
    },

    selectMaterial : function(component, event, helper) {
        component.set("v.material", event.currentTarget.value);

        helper.resetPage(component);
        helper.shields(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.shields(component);
    }
})
