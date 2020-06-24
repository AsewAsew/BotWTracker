({
    doInit : function(component, event, helper) {
        helper.archetypes(component);
        helper.bows(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.bows(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.bows(component);
    },

    selectType : function(compoent, event, helper) {
        component.set("v.archetype", event.currentTarget.value);
        
        helper.resetPage(component);
        helper.bows(component);
    },

    selectMaterial : function(component, event, helper) {
        component.set("v.material", event.currentTarget.value);
        
        helper.resetPage(component);
        helper.bows(component);
    },

    selectEffect : function(component, event, helper) {
        component.set("v.effect", event.currentTarget.value);
        
        helper.resetPage(component);
        helper.bows(component);
    }
})