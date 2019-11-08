public class HTTPUtil {
	private string endpoint;
    private Map<String, String> header;
    private Http http;
    private HttpRequest request;
        
    public HTTPUtil(String endpoint, Map<String, String> header){
        //set endpoint
        this.endpoint = endpoint;
        //set headers
        this.header = new Map<String, String>();
        if(header != null){
        	this.header = header;     
        }           
		this.http= new Http();
        this.request = new HttpRequest();
        
    }
    
    //get method
    public HttpResponse get(){
        //set request
        this.request.setEndpoint(this.endpoint);
        for(String key : header.keySet()){
            String value = header.get(key);
            this.request.setHeader(key, value);
        }
        this.request.setMethod('GET');
        //get response
        return getResponse();
    }
    
    //get response from server
    private HttpResponse getResponse(){        
        HttpResponse response;        
        try {
            response = http.send(request);                                
        }catch(system.CalloutException e){            
            system.debug('error:'+e);
        }
        return response;
    }
}