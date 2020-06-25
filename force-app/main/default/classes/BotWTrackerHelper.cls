public class BotWTrackerHelper {

    @AuraEnabled(Cacheable=true)
    public static List<Shrine__c> getShrines(integer page, integer perPage, String regionId, String type, String level)
    {
        integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Region__r.Name, Subarea__c, Quest__r.Name, Challenge_Name__c, Completed__c' +
                       ', (SELECT Id, Item__r.Name, Obtained__c, Repeatable__c FROM Shrine_Rewards__r) FROM Shrine__c';
        if(regionId != '' || type != '' || level != '')
        {
            query += ' WHERE';
            if(regionId != '')
            {
                query += ' Region__c =: regionId';
                if(type != level)
                    query += ' AND';
            }
            if(type != '')
            {
                query += ' Type__c =: type';
                if(level != '')
                    query += ' AND';
            }
            if(level != '')
            {
                query += ' Strength_Level__c =: level';
            }
        }
        query += ' LIMIT :perPage OFFSET :pageOffset';
        
        return Database.query(query);
    }
    @AuraEnabled(Cacheable=true)
    public static integer getShrineCount(String regionId, String type, String level)
    {
        String query = 'SELECT COUNT() FROM Shrine__c';
        if(regionId != '' || type != '' || level != '')
        {
            query += ' WHERE';
            if(regionId != '')
            {
                query += ' Region__c =: regionId';
                if(type != level)
                    query += ' AND';
            }
            if(type != '')
            {
                query += ' Type__c =: type';
                if(level != '')
                    query += ' AND';
            }
            if(level != '')
            {
                query += ' Strength_Level__c =: level';
            }
        }
        return Database.countQuery(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<Region__c> getRegions()
    {
        return [SELECT Id, Name FROM Region__c ORDER BY Name ASC];
    }
    
    @AuraEnabled
    public static Shrine__c setCompleted(Shrine__c s, String c)
    {
        s.Completed__c = c;
        update s;
        return s;
    }

    @AuraEnabled
    public static Shrine_Reward__c setObtained(Shrine_Reward__c sr)
    {
        sr.Obtained__c = true;
        update sr;
        return sr;
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getArmArch()
    {
        return new List<String>{'None', 'Ancient Soldier Gear', 'Barbarian Set', 'Climbing Set', 'Dark Series', 'Desert Voe Set',
                                'Fireproof Armor', 'Gerudo Set', 'Hero of the Wild Set', 'Hylian Set', 'Radiant Set', 'Rubber Set',
                                'Salvager Set', 'Snowquill Set', 'Soldier\'s Gear', 'Stealth Set', 'Well-Worn Outfit', 'Zora Set'};
    }

    @AuraEnabled(Cacheable=true)
    public static List<Item__c> getArmors(Integer page, Integer perPage, String archetype)
    {
        integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Effect__c, Archetype__c, Total_Power__c, Set_Bonus__c FROM Item__c WHERE RecordType.Name = \'Armor\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        query += ' LIMIT :perPage OFFSET :pageOffset';

        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getArmorsCount(String archetype)
    {
        String query = 'SELECT COUNT() FROM Item__c WHERE RecordType.Name = \'Armor\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';

        return Database.countQuery(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<Item__c> getArrows()
    {
        return [SELECT Id, Name, Effect__c FROM Item__c WHERE RecordType.Name = 'Arrow'];
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getBowArch()
    {
        return new List<String>{
            'None', 'Ancient Soldier Gear', 'Bokoblin Gear', 'Gerudo Gear',
            'Knight\'s Gear', 'Korok Gear', 'Lizalfos Gear', 'Lynel Gear',
            'Rito Gear', 'Royal Gear', 'Royal Guard\'s Series', 'Sheikah Gear',
            'Soldier\'s Gear', 'Traveler\'s Gear', 'Yiga Clan Gear', 'Zora Gear'
        };
    }

    @AuraEnabled(Cacheable=true)
    public static List<Item__c> getBows(Integer page, Integer perPage, String archetype, String material, String effect)
    {
        integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Archetype__c, Material__c, Effect__c, Base_Power__c, Durability__c, Range__c FROM Item__c WHERE RecordType.Name = \'Bow\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(material != '')
            query += ' AND Material__c =: material';
        if(effect != '')
            query += ' AND Effect__c ' + (effect == 'None' ? ' = ' : ' != ') + '\'\'';
        query += ' LIMIT :perPage OFFSET :pageOffset';

        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getBowCount(String archetype, String material, String effect)
    {
        String query = 'SELECT COUNT() FROM Item__c WHERE RecordType.Name = \'Bow\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(material != '')
            query += ' AND Material__c =: material';
        if(effect != '')
            query += ' AND Effect__c ' + (effect == 'None' ? ' = ' : ' != ') + '\'\'';

        return Database.countQuery(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getShiArchs()
    {
        return new List<String>{
            'None', 'Ancient Soldier Gear', 'Bokoblin Gear', 'Gerudo Gear', 'Goron Gear',
            'Guardian Gear', 'Knight\'s Gear', 'Korok Gear', 'Lizalfos Gear', 'Lynel Gear',
            'Moblin Gear', 'Rito Gear', 'Royal Gear', 'Royal Guard\'s Series', 'Rusty Gear',
            'Sheikah Gear', 'Soldier\'s Gear', 'Traveler\'s Gear', 'Zora Gear'
        };
    }

    @AuraEnabled(Cacheable=true)
    public static List<Item__c> getShields(Integer page, Integer perPage, String archetype, String material)
    {
        Integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Archetype__c, Material__c, Base_Power__c, Durability__c FROM Item__c WHERE RecordType.Name = \'Shield\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(material != '')
            query += ' AND Material__c =: material';
        query += ' LIMIT :perPage OFFSET :pageOffset';

        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getShieldCount(String archetype, String material)
    {
        String query = 'SELECT COUNT() FROM Item__c WHERE RecordType.Name = \'Shield\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(material != '')
            query += ' AND Material__c =: material';

        return Database.countQuery(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getWeaArchs()
    {
        return new List<String>{
            'None', 'Ancient Soldier Gear', 'Bokoblin Gear', 'Boomerang', 'Daily Use Goods', 'Gerudo Gear',
            'Goron Gear', 'Guardian Gear', 'Hammer', 'Knight\'s Gear', 'Korok Gear', 'Lizalfos Gear',
            'Lynel Gear', 'Magic Gear', 'Rito Gear', 'Royal Gear', 'Royal Guard\'s Series', 'Rusty Gear',
            'Sheikah Gear', 'Soldier\'s Gear', 'Traveler\'s Gear', 'Yiga Clan Gear', 'Zora Gear'
        };
    }

    @AuraEnabled(Cacheable=true)
    public static List<Item__c> getWeapons(Integer page, Integer perPage, String archetype, String category, String material)
    {
        integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Archetype__c, Material__c, Base_Power__c, Durability__c, Category__c FROM Item__c WHERE RecordType.Name = \'Weapon\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(category != '')
            query += ' AND Category__c =: category';
        if(material != '')
            query += ' AND Material__c =: material';
        query += ' LIMIT :perPage OFFSET :pageOffset';

        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getWeaponCount(String archetype, String category, String material)
    {
        String query = 'SELECT COUNT() FROM Item__c WHERE RecordType.Name = \'Weapon\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(category != '')
            query += ' AND Category__c =: category';
        if(material != '')
            query += ' AND Material__c =: material';

        return Database.countQuery(query);
    }

    @AuraEnabled
    public static List<Quest__c> getQuests(Integer page, Integer perPage, String regionId, String type)
    {
        integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Type__c, Region__c, Location__c, Giver__c, Completed__c FROM Quest__c';
        if(regionId != '' || type != '')
        {
            query += ' WHERE';
            if(regionId != '')
            {
                query += ' Region__c =: regionId';
                if(type != '')
                    query += ' AND';
            }
            if(type != '')
                query += ' Type__c =: type';
        }
        query += ' LIMIT :perPage OFFSET :pageOffset';

        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getQuestCount(String regionId, String type)
    {
        String query = 'SELECT COUNT() FROM Quest__c';
        if(regionId != '' || type != '')
        {
            query += ' WHERE';
            if(regionId != '')
            {
                query += ' Region__c =: regionId';
                if(type != '')
                    query += ' AND';
            }
            if(type != '')
                query += ' Type__c =: type';
        }

        return Database.countQuery(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getMatCats(String archetype)
    {
        if(archetype != 'Ingredient') return new List<String>();
        return new List<String>{
            'Flower and Herb', 'Fruit', 'Meat',
            'Misc', 'Mushroom', 'Seafood', 'Vegetable'
        };
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getSubCats(String archetype, String category)
    {
        if(category == 'Meat') return new List<String>{'Poultry', 'Red Meat'};
        if(category == 'Seafood') return new List<String>{'Crab', 'Fish and Snail'};
        return new List<String>();
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getEffects()
    {
        return new List<String>{
            'Chilly', 'Electro', 'Enduring',
            'Energizing', 'Fireproof', 'Hasty', 'Hearty',
            'Mighty', 'Sneaky', 'Spicy', 'Tough'
        };
    }

    @AuraEnabled(Cacheable=true)
    public static List<Item__c> getMaterials(Integer page, Integer perPage, String archetype, String category, String setBonus, String effect)
    {
        Integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Base_Power__c, Effect__c, Archetype__c, Category__c, Set_Bonus__c FROM Item__c WHERE RecordType.Name = \'Material\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(category != '')
            query += ' AND Category__c =: category';
        if(setBonus != '')
            query += ' AND Set_Bonus__c =: setBonus';
        if(effect != '')
            query += ' AND Effect__c =: effect';
        query += ' Limit :perPage OFFSET :pageOffset';

        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getMaterialCount(String archetype, String category, String setBonus, String effect)
    {
        String query = 'SELECT COUNT() FROM Item__c WHERE RecordType.Name = \'Material\'';
        if(archetype != '')
            query += ' AND Archetype__c =: archetype';
        if(category != '')
            query += ' AND Category__c =: category';
        if(setBonus != '')
            query += ' AND Set_Bonus__c =: setBonus';
        if(effect != '')
            query += ' AND Effect__c =: effect';

        return Database.countQuery(query);
    }
}