({
    doInit : function(component, event, helper) {
        helper.getArchetypes(component);
        helper.armors(component);
    },

    selectArchetype : function(component, event, helper) {
        component.set("v.selArch", event.currentTarget.value);

        helper.resetPage(component);
        helper.armors(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);

        helper.armors(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);

        helper.armors(component);
    }
})