public with sharing class ResetDatabase {
    
    public static void HardResetAll()
    {
        delete [SELECT Id FROM Upgrade__c];
        delete [SELECT Id FROM Region__c];
        delete [SELECT Id FROM Item__c];

        Map<String, Id> armMap = ResetArmor();
        ResetArrows();
        ResetBows();
        Map<String, Id> matMap = ResetMaterials();
        ResetShields();
        ResetRupees();
        ResetWeapons();
        ResetKeyItems();

        ResetUpgrades(armMap, matMap);
        
        Map<String, Id> regMap = ResetRegions();
        Map<String, Id> queMap = ResetQuests(regMap);
        ResetShrines(regMap, queMap);
        ResetKoroks(regMap);
    }

    public static void ResetAll()
    {
        List<Shrine__c> shrines = [SELECT Id, Completed__c FROM Shrine__c WHERE Completed__c != 'Hidden'];
        for(Shrine__c o : shrines) o.Completed__c = 'Hidden';
        update shrines;
        List<Quest__c> quests = [SELECT Id, Completed__c FROM Quest__c WHERE Completed__c = true];
        for(Quest__c o : quests) o.Completed__c = true;
        update quests;
        List<Quest_Stage__C> qStages = [SELECT Id, Completed__c FROM Quest_Stage__C WHERE Completed__c = true];
        for(Quest_Stage__C o : qStages) o.Completed__c = true;
        update qStages;
        List<Shrine_Reward__c> sRewards = [SELECT Id, Obtained__c FROM Shrine_Reward__c WHERE Obtained__c = true];
        for(Shrine_Reward__c o : sRewards) o.Obtained__c = true;
        update sRewards;
        List<Upgrade__c> upgrades = [SELECT Id, Obtained__c FROM Upgrade__c WHERE Obtained__c = true];
        for(Upgrade__c o : upgrades) o.Obtained__c = true;
        update upgrades;
        List<Region__c> regions = [SELECT Id, Found_Koroks__c FROM Region__c WHERE Found_Koroks__c != 0];
        for(Region__c r : regions) r.Found_Koroks__c = 0;
        update regions;
    }

    public static Map<String, Id> ResetArmor()
    {
        String body = GetBody('Armors');
        
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

        Map<String, Id> armMap = new Map<String, Id>();
        for(Item__c a : armors)
            armMap.put(a.Name, a.Id);
        
        return armMap;
    }

    public static void ResetArrows()
    {
        String body = GetBody('Arrows');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Arrow'];
        List<Item__c> arrows = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
            List<String> parts = SplitString(line, 2);

            arrows.add(new Item__c(
                Name = parts.get(0),
                Effect__c = parts.get(1),
                RecordTypeId = rt.Id
            ));
        }

        insert arrows;
    }

    public static void ResetBows()
    {
        String body = GetBody('Bows');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Bow'];
        List<Item__c> bows = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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

    public static void ResetKeyItems()
    {
        String body = GetBody('KeyItems');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'KeyItem'];

        List<Item__c> keyItems = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 3);

            keyItems.add(new Item__c(
                Name = parts.get(0),
                Archetype__c = parts.get(1),
                Effect__c = parts.get(2),
                RecordTypeId = rt.Id
            ));
        }

        insert keyItems;
    }

    public static Map<String, Id> ResetMaterials()
    {
        String body = GetBody('Materials');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Material'];
        List<Item__c> materials = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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

        Map<String, Id> matMap = new Map<String, Id>();
        for(Item__c m : materials)
            matMap.put(m.Name, m.Id);

        return matMap;
    }

    public static void ResetShields()
    {
        String body = GetBody('Shields');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Shield'];
        List<Item__c> shields = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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
        String body = GetBody('Rupees');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Rupee'];
        List<Item__c> rupees = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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
        String body = GetBody('Weapons');

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Weapon'];
        List<Item__c> weapons = new List<Item__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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

    public static void ResetUpgrades(Map<String, Id> armMap, Map<String, Id> matMap)
    {
        String body = GetBody('Upgrades');

        List<Upgrade__c> upgrades = new List<Upgrade__c>();

        for(String line : body.split('\n'))
        {
            List<String> parts = SplitString(line, 7);

            if(matMap.get(parts.get(2)) == null)
                System.debug(parts.get(0));

            // Item__c, stage__c, mat, mat cnt, add mat, add mat cnt, pwr bst
            upgrades.add(new Upgrade__c(
                Name = parts.get(0) + ' ' + parts.get(1),
                Item__c = armMap.get(parts.get(0)),
                Stage__c = Integer.valueOf(parts.get(1)),
                Material__c = matMap.get(parts.get(2)),
                Material_Count__c = Integer.valueOf(parts.get(3)),
                Power_Boost__c = Integer.valueOf(parts.get(6))
            ));

            //System.debug(parts.get(2) + ' ' + matMap.get(parts.get(2)));

            if(!parts.get(4).equals(''))
            {
                upgrades.get(upgrades.size()-1).Additional_Material__c = matMap.get(parts.get(4));
                upgrades.get(upgrades.size()-1).Additional_Material_Count__c = Integer.valueOf(parts.get(5));
            }
        }

        insert upgrades;
    }

    public static Map<String, Id> ResetRegions()
    {
        String body = GetBody('Regions');

        List<Region__c> regions = new List<Region__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
            List<String> parts = SplitString(line, 2);

            regions.add(new Region__c(
                Name = parts.get(0),
                Koroks__c = Integer.valueOf(parts.get(1))
            ));
        }

        insert regions;

        Map<String, Id> regMap = new Map<String, Id>();
        for(Region__c r : regions)
            regMap.put(r.Name, r.Id);

        return regMap;
    }

    public static Map<String, Id> ResetQuests(Map<String, Id> regMap)
    {
        String body = GetBody('Quests');

        List<Quest__c> quests = new List<Quest__c>();

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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
        String body = GetBody('Shrines');

        List<Shrine__c> shrines = new List<Shrine__c>();
        
        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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
        String body = GetBody('Koroks');

        List<Korok__c> koroks = new List<Korok__c>();
        integer k = 0;

        for(String line : body.split('\n'))
        {
            if(line.equals('')) continue;
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

    private static String GetBody(String type)
    {
        String input = 'Input' + type;
        StaticResource sr = [SELECT Body FROM StaticResource WHERE Name =: input];
        return sr.Body.toString();
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