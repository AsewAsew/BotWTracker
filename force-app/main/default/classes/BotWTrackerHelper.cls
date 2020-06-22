public class BotWTrackerHelper {

    @AuraEnabled(Cacheable=true)
    public static List<Shrine__c> getShrines(integer page, integer perPage, String regionId)
    {
        integer pageOffset = (page - 1) * perPage;
        String query = 'SELECT Id, Name, Region__r.Name, Subarea__c, Quest__r.Name, Challenge_Name__c, Completed__c FROM Shrine__c';
        if(regionId != '')
            query += ' WHERE Region__c =: regionId';
        query += ' LIMIT :perPage OFFSET :pageOffset';
        
        return Database.query(query);
    }
    @AuraEnabled(Cacheable=true)
    public static integer getShrineCount(String regionId)
    {
        String query = 'SELECT COUNT() FROM Shrine__c';
        if(regionId != '')
            query += ' WHERE Region__c =: regionId';
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
}