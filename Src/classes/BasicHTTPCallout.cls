public class BasicHTTPCallout {
    
    public static void callout(){
        //should use custom setting / custom label for endpoint.
        String endpoint = 'https://postman-echo.com/get?foo1=bar1&foo2=bar2';
        Map<String, String> header = null; //set Header if required.
        HTTPUtil httpUtil = new HTTPUtil(endpoint, header);
        HttpResponse response = httpUtil.get();
        if(response.getStatusCode() == 200){
            System.debug(response.getBody());  
        }else{
            System.debug('Error Code::' + response.getStatusCode() + 'Error ::' + response.getStatus());
        }
        
    }
}