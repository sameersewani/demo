public class ImagesFromCMS {
    @AuraEnabled (cacheable=true)
   public static String retrieveMediaFromCMS(String channelName){
       //get the channel id channel which contains our images
       String channelId = getChannelId(channelName);
       System.debug(channelId);
   

      // get the image content
       ConnectApi.ManagedContentVersionCollection obj = 
           ConnectApi.ManagedContent.getAllContent(channelId, 0, 5, 'en_US', 
                                                   'cms_image',false,
                                                   '2011-02-25T18:24:31.000Z','2022-09-25T18:24:31.000Z',true);
       system.debug(obj);
       
       List<ReturnWrapper> wrapperList = new List<ReturnWrapper>();
       System.debug('json value=' + JSON.serialize(obj));
   

       //loop through each item and prepare a wrapper list
       for(ConnectApi.ManagedContentVersion versionObj: obj.items){
           ReturnWrapper wrapper = new ReturnWrapper();
           wrapper.title = versionObj.title;
           
           //get the url
           Map<String,ConnectApi.ManagedContentNodeValue> contentNodesMap = versionObj.contentNodes;
           for(String str:contentNodesMap.keySet()){                
               if(str=='source'){
                   wrapper.url= ((ConnectApi.ManagedContentMediaSourceNodeValue)contentNodesMap.get(str)).url;
               }		
           }
           wrapperList.add(wrapper);	
       }
       System.debug(wrapperList);
       return JSON.serialize(wrapperList);
   }

   @AuraEnabled (cacheable=true)
   public static String getChannelId(String channelName){
       ConnectApi.ManagedContentChannelCollection channelRepObj = 
               ConnectApi.ManagedContent.getAllDeliveryChannels(0,2);        

       //loop through the channels and return the channel Id
       for(ConnectApi.ManagedContentChannel channelObj: channelRepObj.channels){
           if(channelObj.channelName == channelName){
               return channelObj.channelId;
           }
       }
       return null;
   }

   public class ReturnWrapper{
       String title {get;set;}
       String url {get;set;}
   
  }

}