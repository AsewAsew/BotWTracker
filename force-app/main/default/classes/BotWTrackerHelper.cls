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
}