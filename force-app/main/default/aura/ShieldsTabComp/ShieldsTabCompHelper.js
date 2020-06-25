({
    archetypes : function(component) {
        var action = component.get("c.getShiArchs");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shiArchs", result);
            }
        });

        $A.enqueueAction(action);
    },

    shields : function(component) {
        var action = component.get("c.getShields");

        action.setParams({
            page: component.get("v.page"),
            perPage: component.get("v.perPage"),
            archetype: component.get("v.archetype"),
            material: component.get("v.material")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shields", result);
                this.shieldCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    shieldCount : function(component) {
        var action = component.get("c.getShieldCount");

        action.setParams({
            archetype: component.get("v.archetype"),
            material: component.get("v.material")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shieldCount", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    disable : function(component){
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var shieldCount = component.get("v.shieldCount");
        if(page < 1)
        {
            page = 1;
            this.resetPage(component);
        }

        component.set("v.disPrev", page == 1);
        component.set("v.disNext", shieldCount <= page * perPage);
    },

    resetPage : function(component) {
        component.set("v.page", 1);
    }
})
