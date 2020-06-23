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

    shrines : function(component) {
        var action = component.get("c.getShrines");

        var page = component.get("v.page");
        var perPage = component.get("v.perPage");
        var regionId = component.get("v.regionId");
        var type = component.get("v.type");
        var level = component.get("v.level");

        action.setParams({
            page: page,
            perPage: perPage,
            regionId: regionId,
            type: type,
            level: level
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shrines", result);
                this.shrineCount(component);
            }
        });

        $A.enqueueAction(action);
    },

    shrineCount : function(component) {
        var action = component.get("c.getShrineCount");

        var regionId = component.get("v.regionId");
        var type = component.get("v.type");
        var level = component.get("v.level");

        action.setParams({
            regionId: regionId,
            type: type,
            level: level
        });

        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS")
            {
                var result = response.getReturnValue();
                component.set("v.shrineCount", result);
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
        var shrineCount = component.get("v.shrineCount");
        if(page < 1)
        {
            this.resetPage();
            page = 1;
        }
        
        component.set("v.disPrev", page == 1);
        component.set("v.disNext", shrineCount <= page * perPage);
    }
})