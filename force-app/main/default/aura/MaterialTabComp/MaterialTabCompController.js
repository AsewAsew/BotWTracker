({
    doInit : function(component, event, helper) {
        helper.materials(component);
        helper.effects(component);
    },

    selectType : function(component, event, helper) {
        var archetype = event.currentTarget.value;
        component.set("v.archetype", archetype);

        if(archetype != 'Ingredient')
        {
            component.set("v.category", "");
            component.set("v.subcat", "");
        }
        helper.categories(component);
        helper.subcats(component);
        helper.materials(component);
    },

    selectCategory : function(component, event, helper) {
        var category = event.currentTarget.value;
        component.set("v.category", category);

        if(category != 'Meat' && category != 'Seafood')
            component.set("v.subcat", "");
        helper.subcats(component);
        helper.materials(component);
    },

    selectSubCat : function(component, event, helper) {
        component.set("v.subcat", event.currentTarget.value);
        helper.materials(component);
    },

    selectEffect : function(component, event, helper) {
        component.set("v.effect", event.currentTarget.value);
        helper.materials(component);
    },

    prevPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") - 1);
        helper.materials(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.page", component.get("v.page") + 1);
        helper.materials(component);
    }
})
