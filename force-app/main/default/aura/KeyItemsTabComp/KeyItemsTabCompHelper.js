({
    keyItems : function(component) {
        var action = component.get("c.getKeyItems");

        action.setParams({
            page: component.get("v.page"),
            perPage: component.get("v.perPage"),
            archetype: component.get("v.archetype")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.keyItems", result);
                this.keyItemCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    keyItemCount : function(component) {
        var action = component.get("c.getKeyItemCount");

        action.setParams({
            archetype: component.get("v.archetype")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.keyItemCount", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    disable : function(component) {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var keyItemCount = component.get("v.keyItemCount");
        if(page < 1)
        {
            page = 1;
            this.resetPage(component);
        }

        component.set("v.disPrev", page == 1);
        component.set("v.disNext", keyItemCount <= page * perPage);
    },

    resetPage : function(component) {
        component.set("v.page", 1);
    }
})
