public class ContactTriggerHandler {
    public static void blockDuplicateEmail(List<Contact> cons, Map<Id, Contact> contactMap1){
        Set<String> emailsets = new Set<String>();
        List<Contact> newCons = new List<Contact>();
        for(Contact ccc : cons){
            if(ccc.Email != null && contactMap1.get(ccc.id).Email != ccc.Email){
                   emailsets.add(ccc.Email);
                   newCons.add(ccc);
            }
        }
        
        Map<String, Contact> contactMap = new Map<String, Contact>();
        
            for(Contact cc : [select id, email from contact where Email in: emailsets]){
                contactMap.put(cc.Email, cc);
            }
        for(Contact c : newCons){
            if(contactMap.containskey(c.email)){
                c.addError('Contact Duplicate');
            }
        }           
    }
    
    public static void updateContactsCount(List<Contact> contactList, Map<Id, Contact> contactMap){
        Set<Id> ids = new Set<Id>();     
        for(Contact cc: contactList){
            if(cc.AccountId != contactMap.get(cc.Id).AccountId && contactMap.get(cc.Id).AccountId != null){
                ids.add(contactMap.get(cc.Id).AccountId);
            }
            if(cc.AccountId != null){
                ids.add(cc.AccountId);
            }
        }
        Map<Id, Integer> accountMap = new Map<Id, Integer>();
        for(AggregateResult ar : [select AccountId, Count(Id)counts from contact where Accountid in: ids group by AccountId]){
            accountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('counts'));
        }
        List<Account> accountsToUpdate = new List<Account>();
        for(Id accid : ids){
            Integer int1 = accountMap.get(accid);
            accountsToUpdate.add(new Account(
                   Id = accid,
                    Total_Contacts__c  = int1
                ));
        }
        if(accountsToUpdate != null){
            update accountsToUpdate;
        }
        
    }
    
}