public class OpportunityTriggerHandler {
    public static void createTasks(List<Opportunity> oppsList, Map<Id, Opportunity> oppsMap){
        List<Task> newTask = new List<Task>();
        Task ts = new Task();
        for(Opportunity opps : oppsList){
            if(opps.Amount > 100 && oppsMap == null){
                ts.Subject='Project Task';
                ts.Status = 'In progress';
                ts.Priority = 'High';
                ts.WhatId = opps.Id;
            }
            System.debug(oppsMap);
            if(oppsMap != null){
                if(opps.Amount > 100 && opps.Amount != oppsMap.get(opps.id).Amount && oppsMap.get(opps.id).Amount < 100){
                ts.Subject='Project Task';
                ts.Status = 'In progress';
                ts.Priority = 'High';
                ts.WhatId = opps.Id;
                newTask.add(ts);
                }
            }
        }
        if(newTask.size() > 0){
        insert newTask;
        }
    }
}