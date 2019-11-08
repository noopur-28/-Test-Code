public class RecentRecordsController {

    public class Response{
        @AuraEnabled 
        public Boolean isSuccess;
        @AuraEnabled 
        public Object Data;
        @AuraEnabled 
        public String Message;
       
        Response(Boolean isSuccess, Object data, String message){
            this.isSuccess = isSuccess;
            this.Data = data;
            this.Message = message;
        }
    }
    
    @AuraEnabled
    public static Response getAccounts(){
        try{
            List<Account> accountList = [SELECT Id, Name FROM Account Order By CreatedDate Desc LIMIT 10];
            return new Response(true, accountList, null);
        }catch (Exception e){
            System.debug('Exception : ' + e.getMessage());
            return new Response(false, null, e.getMessage());
        }
    }
}