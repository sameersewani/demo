public class HtmlContentPreview {
    @AuraEnabled
    public static String mymethod(String Name,String text)
    {
       
         HttpRequest request=new HttpRequest();
       Http send=new Http();
       HttpResponse res=new HttpResponse();
        request.setEndpoint('https://api.postgrid.com/print-mail/v1/templates');
        request.setMethod('POST');
        request.setHeader('x-api-key', 'test_sk_mzn6tpRPQjpwdnDwdjHmoC');
        String body='description='+EncodingUtil.urlEncode('Test', 'UTF-8')+'&html='+EncodingUtil.urlEncode(text,'UTF-8');
        request.setBody(body);
        res=send.send(request);
        System.debug(res); 
        return (String)res.getBody();  
    }

}