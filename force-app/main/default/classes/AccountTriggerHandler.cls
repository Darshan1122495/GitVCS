public class AccountTriggerHandler {
    public static void updateContactDescription(List<Account> newList, Map<Id, Account> accMap){
        Map<Id, Account> accMap1 = new Map<Id, Account>();        
        for(Account acc : newlist){
            if(acc.Description != accMap.get(acc.id).Description){
                accMap1.put(acc.Id, acc);
            }
        }
        List<Contact> getCon = [select id, Description, AccountId from contact where Accountid in: accMap1.keyset()];
        List<Contact> updateAccounts = new List<Contact>();
        for(Contact con : getCon){
            if(accMap1.containskey(con.AccountId)){
                Account a = accMap1.get(con.AccountId);
                con.Description = a.Description;
                updateAccounts.add(con);
            }
        }
        if(updateAccounts != null){
            update updateAccounts;
        }
    }
}