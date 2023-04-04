public with sharing class DNAComponentClass {
    public DNAComponentClass() {

    }
    @AuraEnabled(cacheable = true)
    public static Map<ID,DNAClassCard__c> getRecords(){
        List<DNAClassCard__c> oppList = [Select Id,Name,ExcerciseName__c,Level__c,Description__c,Email__c From DNAClassCard__c];
        List<ID> oppIds = new List<ID>();
        Map<ID,DNAClassCard__c> OppIdMap = new Map<ID,DNAClassCard__c>();
        for(DNAClassCard__c o : oppList){
            oppIds.add(o.Id);
            OppIdMap.put(o.Id , o);
        }
        Map<ID,DNAClassCard__c> OppCdIdMap = new Map<ID,DNAClassCard__c>();
        List<ContentDocumentLink> cdList = [SELECT id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN : oppIds];
        for(ContentDocumentLink cd : cdList){
            OppCdIdMap.put(cd.ContentDocumentId , OppIdMap.get(cd.LinkedEntityId));
        }
        System.debug(OppCdIdMap);
        Map<ID,DNAClassCard__c> OppCvIdMap = new Map<ID,DNAClassCard__c>();
        List<ContentVersion> cvList = [ SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN : OppCdIdMap.keySet() ];
        System.debug(cvList);
        for(ContentDocumentLink cd : cdList){
            for(ContentVersion cv : cvList){
                if(cv.ContentDocumentId == cd.ContentDocumentId){
                    OppCvIdMap.put(cv.Id , OppCdIdMap.get(cd.ContentDocumentId));
                }
            }
        }
        System.debug(OppCvIdMap);
        return OppCvIdMap;
    }
}