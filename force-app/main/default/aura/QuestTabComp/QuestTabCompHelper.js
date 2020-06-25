({
    regions : function(component) {
        var action = component.get("c.getRegions");

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.regions", result);
            }
        });

        $A.enqueueAction(action);
    },

    quests : function(component) {
        var action = component.get("c.getQuests");

        action.setParams({
            page: component.get("v.page"),
            perPage: component.get("v.perPage"),
            regionId: component.get("v.regionId"),
            type: component.get("v.type")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.quests", result);
                this.questCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    questCount : function(component) {
        var action = component.get("c.getQuestCount");

        action.setParams({
            regionId: component.get("v.regionId"),
            type: component.get("v.type")
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.questCount", result);
                this.disable(component);
            }
        });

        $A.enqueueAction(action);
    },

    disable : function(component) {
        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var questCount = component.geT("v.questCount");
        if(page < 1)
        {
            page = 1;
            this.resetPage(component);
        }

        component.set("v.disPrev", page == 1);
        component.set("v.disNext", questCount <= page * perPage);
    },

    resetPage : function(component) {
        component.set("v.page", 1);
    }
})