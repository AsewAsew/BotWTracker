({
    weaArchs : function(component) {
        var action = component.get("c.getWeaArchs");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.weaArchs", result);
            }
        });

        $A.enqueueAction(action);
    },

    weapons : function(component) {
        var action = component.get("c.getWeapons");

        action.setParams({
            page: component.get("v.page"),
            perPage: component.get("v.perPage"),
            archetype: component.get("v.archetype"),
            category: component.get("v.category"),
            material: component.get("v.material")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.weapons", result);
                this.weaponCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    weaponCount : function(component) {
        var action = component.get("c.getWeaponCount");

        action.setParams({
            archetype: component.get("v.archetype"),
            category: component.get("v.category"),
            material: component.get("v.material")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.weaponCount", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    disable : function(component) {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var weaponCount = component.get("v.weaponCount");
        if(page < 1)
        {
            page = 1;
            this.resetPage(component);
        }

        component.set("v.disPrev", page == 1);
        component.set("v.disNext", weaponCount <= page * perPage);
    },

    resetPage : function(component) {
        component.set("v.page", 1);
    }
})