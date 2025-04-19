//PRtest
public class CaseTriggerHandler {
    public static void updateAccountDescription(List<Case> caseList, Map<Id, Case> caseMap){
        Set<Id> ids = new Set<id>();
        List<Case> case1 = new List<Case>();
        for(Case css:caselist){
            if(css.Status != null && css.Status != caseMap.get(css.id).Status){
                ids.add(css.AccountId);
                case1.add(css);
            }
        }
<<<<<<< HEAD
        
=======
>>>>>>> Test/BugFix
        Map<Id, Account> accountMap2 = new Map<Id, Account>([select id, description from account where id in:ids]);
            
        List<Account> newAcc = new List<Account>();            
        
        for(Case cas : case1){
            if(accountMap2.containskey(cas.AccountId)){
                Account acc = accountMap2.get(cas.AccountId);
                    acc.Description = cas.CaseNumber+ 'Status' +cas.status;
                newAcc.add(acc);
            }
        }
        if(newAcc != null){
            update newAcc;
        }
    }
    //updateRating
    public static void updateAccountRating(List<Case> caseList, Map<Id, Case> caseMap){
        Set<Id> ids = new Set<Id>();
        for(Case css:caselist){
            if(css.Status != null && css.Status != caseMap.get(css.id).Status){
                ids.add(css.AccountId);
            }
        }
        Map<Id, Integer> case2 = new Map<Id, Integer>();
        for(AggregateResult arr : [select AccountId, count(Id)cc from case where AccountId in: ids and status = 'Escalated' group by AccountId]){
            case2.put((Id)arr.get('AccountId'), (Integer)arr.get('cc'));
        
        }
        List<Account> accountsToUpdate = new List<Account>();
        for(Id ids1 : ids){
            Integer count = case2.get(ids1);
            if(count != null){
                String rate;
                if(count == 3){
                    rate = 'Hot';
                }
                else if(count == 2){
                    rate = 'Warm';
                }
                else if(count == 1){
                    rate = 'Cold';
                }
                else{
                    continue;
                }
                accountsToUpdate.add(new Account(
                   Id = ids1,
                    Rating = rate
                ));
            }
        }
        if(accountsToUpdate.size() > 0){
            update accountsToUpdate;
        }
    }
}