/*
* @purpose:To Handle the ContactTrigger 
* */
public class ContactTriggerHandler{
    
    public static void onAfterInsert(List<contact> newContactList){
        increamentCount(newContactList);
    }
    
    public static void onAfterUpdate(List<contact> oldContactList, Map<Id,contact> newContactMap){
        List<Contact> decrementCountList = new List<Contact>();
        List<Contact> increamentCountList = new List<Contact>();
        for(Contact oldContact: oldContactList){
        	Contact newContact = newContactMap.get(oldContact.Id);
            if(oldContact.AccountId != newContact.AccountId){
                decrementCountList.add(oldContact);
                increamentCountList.add(newContact);
            }
        }
        
        if(!decrementCountList.isEmpty()){
             decreamentCount(decrementCountList);
		}
        
        if(!increamentCountList.isEmpty()){
            increamentCount(increamentCountList);
		}
    }
    
    public static void onAfterDelete(List<contact> oldContactList){
        decreamentCount(oldContactList);
    }
    
    public static void onAfterUndelete(List<contact> newContactList){
        increamentCount(newContactList);
    }
    
    
    private static void increamentCount(List<Contact> contactList){
        Map<Id,Account> accountMap = getAccounts(contactList);
        for(Contact contact: contactList){
            Account account = accountMap.get(contact.AccountId);
            account.Number_Of_Contacts__c = account.Number_Of_Contacts__c == Null ? 1 : account.Number_Of_Contacts__c + 1;
            accountMap.put(account.Id , account);
        }
        
        UPDATE accountMap.Values();
    }
    
    private static void decreamentCount(List<Contact> contactList){
        Map<Id,Account> accountMap = getAccounts(contactList);
        for(Contact contact: contactList){
            Account account = accountMap.get(contact.AccountId);
            account.Number_Of_Contacts__c = account.Number_Of_Contacts__c == Null ? 0 : account.Number_Of_Contacts__c - 1;
            accountMap.put(account.Id , account);
        }
        
        UPDATE accountMap.Values();
    }
    
    private static Map<Id,Account> getAccounts(List<Contact> contactList){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact contact: contactList){
            accountIdSet.add(contact.AccountId);
        }
        
        return new Map<Id,Account>([SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :accountIdSet]);
    }
}