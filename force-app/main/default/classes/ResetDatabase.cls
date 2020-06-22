public with sharing class ResetDatabase {
    
    public static void ResetAll()
    {
        delete [SELECT Id FROM Region__c];
        delete [SELECT Id FROM Item__c];

        ResetArmor();
        ResetArrows();
        ResetBows();
        ResetMaterials();
        ResetShields();
        ResetRupees();
        ResetWeapons();

        Map<String, Id> regMap = ResetRegions();
        Map<String, Id> queMap = ResetQuests(regMap);
        ResetShrines(regMap, queMap);
        ResetKoroks(regMap);
    }

    public static void ResetArmor()
    {
        String body = getBody('Armors');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Armor'];
        List<Item__c> armors = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 5);

            armors.add(new Item__c(
                Name = parts.get(0),
                Archetype__c = parts.get(1),
                Set_Bonus__c = parts.get(2),
                Effect__c = parts.get(3),
                Base_Power__c = Integer.valueOf(parts.get(4)),
                RecordTypeId = rt.Id
            ));
        }

        insert armors;
    }

    public static void ResetArrows()
    {
        String body = getBody('Arrows');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Arrow'];
        List<Item__c> arrows = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 2);

            arrows.add(new Item__c(
                Name = parts.get(0),
                Base_Power__c = Integer.valueOf(parts.get(1)),
                RecordTypeId = rt.Id
            ));
        }

        insert arrows;
    }

    public static void ResetBows()
    {
        String body = getBody('Bows');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Bow'];
        List<Item__c> bows = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 7);

            bows.add(new Item__c(
                Name = parts.get(0),
                Archetype__c = parts.get(1),
                Effect__c = parts.get(2),
                Material__c = parts.get(3),
                Base_Power__c = Integer.valueOf(parts.get(4)),
                Durability__c = Integer.valueOf(parts.get(5)),
                Range__c = Integer.valueOf(parts.get(6)),
                RecordTypeId = rt.Id
            ));
        }

        insert bows;
    }

    public static void ResetMaterials()
    {
        String body = getBody('Materials');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Material'];
        List<Item__c> materials = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 6);

            materials.add(new Item__c(
                Name = parts.get(0),
                Effect__c = parts.get(1),
                Archetype__c = parts.get(2),
                Category__c = parts.get(3),
                Set_Bonus__c = parts.get(4),
                Base_Power__c = Integer.valueOf(parts.get(5)),
                RecordTypeId = rt.Id
            ));
        }

        insert materials;
    }

    public static void ResetShields()
    {
        String body = getBody('Shields');
        // name, archetype, material, base, durability
        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Shield'];
        List<Item__c> shields = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 5);

            shields.add(new Item__c(
                Name = parts.get(0),
                Archetype__c = parts.get(1),
                Material__c = parts.get(2),
                Base_Power__c = Integer.valueOf(parts.get(3)),
                Durability__c = Integer.valueOf(parts.get(4)),
                RecordTypeId = rt.Id
            ));
        }

        insert shields;
    }

    public static void ResetRupees()
    {
        String body = getBody('Rupees');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Rupee'];
        List<Item__c> rupees = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 2);

            rupees.add(new Item__c(
                Name = parts.get(0),
                Base_Power__c = Integer.valueOf(parts.get(1)),
                RecordTypeId = rt.Id
            ));
        }

        insert rupees;
    }

    public static void ResetWeapons()
    {
        String body = getBody('Weapons');
        //name, archetype, category, material, base, durability
        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Weapon'];
        List<Item__c> weapons = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 6);

            weapons.add(new Item__c(
                Name = parts.get(0),
                Archetype__c = parts.get(1),
                Category__c = parts.get(2),
                Material__c = parts.get(3),
                Base_Power__c = Integer.valueOf(parts.get(4)),
                Durability__c = Integer.valueOf(parts.get(5)),
                RecordTypeId = rt.Id
            ));
        }

        insert weapons;
    }

    public static Map<String, Id> ResetRegions()
    {
        String body = getBody('Regions');

        List<Region__c> regions = new List<Region__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 1);

            regions.add(new Region__c(Name = parts.get(0)));
        }

        insert regions;

        Map<String, Id> regMap = new Map<String, Id>();
        for(Region__c r : regions)
            regMap.put(r.Name, r.Id);

        return regMap;
    }

    public static Map<String, Id> ResetQuests(Map<String, Id> regMap)
    {
        String body = getBody('Quests');

        List<Quest__c> quests = new List<Quest__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 6);

            quests.add(new Quest__c(
                Name = parts.get(0),
                Region__c = regMap.get(parts.get(1)),
                Location__c = parts.get(2),
                Giver__c = parts.get(3),
                Type__c = parts.get(4),
                DLC__c = Boolean.valueOf(parts.get(5))
            ));
        }

        insert quests;

        Map<String, Id> queMap = new Map<String, Id>();
        for(Quest__c q : quests)
            queMap.put(q.Name, q.Id);

        return queMap;
    }

    public static void ResetShrines(Map<String, Id> regMap, Map<String, Id> queMap)
    {

        String body = getBody('Shrines');
        // Name, Region, Challenge Name, Type, Strength Level, Subarea, Divine Beast, DLC, Completed

        List<Shrine__c> shrines = new List<Shrine__c>();
        
        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 10);

            shrines.add(new Shrine__c(
                Name = parts.get(0),
                Region__c = regMap.get(parts.get(1)),
                Challenge_Name__c = parts.get(2),
                Type__c = parts.get(3),
                Subarea__c = parts.get(5),
                Divine_Beast__c = Boolean.valueOf(parts.get(6)),
                DLC__c = Boolean.valueOf(parts.get(7)),
                Completed__c = parts.get(8)
            ));

            if(!parts.get(4).equals(''))
                shrines.get(shrines.size() - 1).Strength_Level__c = parts.get(4);
            if(!parts.get(9).equals(''))
                shrines.get(Shrines.size() - 1).Quest__c = queMap.get(parts.get(9));
        }

        insert shrines;
    }

    public static void ResetKoroks(Map<String, Id> regMap)
    {
        String body = getBody('Koroks');

        List<Korok__c> koroks = new List<Korok__c>();
        integer k = 0;

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 2);
            integer cnt = Integer.valueOf(parts.get(1));

            for(integer i = 0; i < cnt; i++)
            {
                koroks.add(new Korok__c(
                    Name = ('Korok ' + ++k),
                    Region__c = regMap.get(parts.get(0))
                ));
            }
        }

        insert koroks;
    }

    private static String getBody(String input)
    {
        input = 'Input' + input;
        StaticResource sr = [SELECT body FROM StaticResource WHERE Name =: input];
        return sr.body.toString();
    } 

    private static List<String> SplitString(String line, integer cnt)
    {
        List<String> parts = new List<String>();

        for(integer i = 0; i < cnt; i++)
        {
            String s = line.substring(line.indexOf('\"') + 1, line.indexOf('\"', 1));
            parts.add(s);
            
            if(i < cnt - 1)
                line = line.substring(line.indexOf('\"', 1) + 2);
        }

        return parts;
    }
}