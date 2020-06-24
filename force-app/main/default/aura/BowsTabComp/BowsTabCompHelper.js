({
    archetypes : function(component) {
        var action = component.get("c.getBowArch");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.bowArchs", result);
            }
        });

        $A.enqueueAction(action);
    },

    bows : function(component) {
        var action = component.get("c.getBows");

        action.setParams({
            page: component.get("v.page"),
            perPage: component.get("v.perPage"),
            archetype: component.get("v.archetype"),
            material: component.get("v.material"),
            effect: component.get("v.effect")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.bows", result);
                helper.bowCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    bowCount : function(component) {
        var action = component.get("c.getbowCount");

        action.setParams({
            archetype: component.get("v.archetype"),
            material: component.get("v.material"),
            effect: component.get("v.effect")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.bowCount", result);
                helper.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    disable : function(component)
    {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var bowCount = component.get("v.bowCount");
        if(page < 1)
        {
            this.resetPage();
            page = 1;
        }
        
        component.set("v.disPrev", page == 1);
        component.set("v.disNext", bowCount <= page * perPage);
    },

    resetPage : function(component)
    {
        component.set("v.page", 1);
    }
})