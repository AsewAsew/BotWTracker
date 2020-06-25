({
    doInit : function(component, event, helper) {
        helper.weaArchs(component);
        helper.weapons(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.weapons(component);
    },

    nextPage : function(component, event, helper) {
        console.log("next page");
        component.set("v.page", component.get("v.page") + 1);
        helper.weapons(component);
    },

    selectType : function(component, event, helper) {
        component.set("v.archetype", event.currentTarget.value);

        helper.resetPage(component);
        helper.weapons(component);
    },

    selectCategory : function(component, event, helper) {
        component.set("v.category", event.currentTarget.value);

        helper.resetPage(component);
        helper.weapons(component);
    },

    selectMaterial : function(component, event, helper) {
        component.set("v.material", event.currentTarget.value);

        helper.resetPage(component);
        helper.weapons(component);
    }
})