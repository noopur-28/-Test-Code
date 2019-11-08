trigger ContactTrigger on Contact (after insert,after Update,after delete,after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerHandler.onAfterInsert(Trigger.new);  
        }
        
        if(Trigger.isUpdate){
            ContactTriggerHandler.onAfterUpdate(Trigger.old, Trigger.newMap);  
        }
        
        if(Trigger.isDelete){
            ContactTriggerHandler.onAfterDelete(Trigger.old);  
        }
        
        if(Trigger.isUndelete){
            ContactTriggerHandler.onAfterUndelete(Trigger.new); 
        }
    }
}