({
    categories : function(component) {
        var action = component.get("c.getMatCats");

        action.setParams({
            archetype: component.get("v.archetype")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.categories", result);
            }
        });

        $A.enqueueAction(action);
    },

    subcats : function(component) {
        var action = component.get("c.getSubCats");

        action.setParams({
            category: component.get("v.category")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.subcats", result);
            }
        });

        $A.enqueueAction(action);
    },

    effects : function(component) {
        var action = component.get("c.getEffects");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.effects", result);
            }
        });

        $A.enqueueAction(action);
    },

    materials : function(component) {
        var action = component.get("c.getMaterials");

        action.setParams({
            page: component.get("v.page"),
            perPage: component.get("v.perPage"),
            archetype: component.get("v.archetype"),
            category: component.get("v.category"),
            setBonus: component.get("v.subcat"),
            effect: component.get("v.effect")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.materials", result);
                this.materialCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    materialCount : function(component) {
        var action = component.get("c.getMaterialCount");

        action.setParams({
            archetype: component.get("v.archetype"),
            category: component.get("v.category"),
            setBonus: component.get("v.subcat"),
            effect: component.get("v.effect")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.get("v.materialCount", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    disable : function(component) {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var materialCount = component.get("v.materialCount");
        if(page < 1)
        {
            page = 1;
            this.resetPage(component);
        }

        component.set("v.disPrev", page == 1);
        component.set("v.disNext", materialCount <= page * perPage);
    },

    resetPage : function(component) {
        component.set("v.page", 1);
    }
})
