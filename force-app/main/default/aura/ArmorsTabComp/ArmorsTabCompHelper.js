({
    getArchetypes : function(component) {
        var action = component.get("c.getArmArch");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.archetypes", result);
            }
        });

        $A.enqueueAction(action);
    },

    armors : function(component) {
        var action = component.get("c.getArmors");
        
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var archetype = component.get("v.selArch");

        action.setParams({
            page: page,
            perPage: perPage,
            archetype: archetype
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.armors", result);
                this.armorsCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    armorsCount : function(component) {
        var action = component.get("c.getArmorsCount");

        var archetype = component.get("v.selArch");

        action.setParams({
            archetype: archetype
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.armorsCount", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    resetPage : function(component) {
        component.set("v.page", 1);
    },

    disable : function(component) {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var armorsCount = component.get("v.armorsCount");

        if(page < 1)
        {
            this.resetPage();
            page = 1;
        }
        
        component.set("v.disPrev", page == 1);
        component.set("v.disNext", armorsCount <= page * perPage);
    }
})