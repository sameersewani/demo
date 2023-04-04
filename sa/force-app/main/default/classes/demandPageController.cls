public with sharing class demandPageController {
    @AuraEnabled(Cacheable=true)
    public static list<demandPage__c> myMethod(){
        list<demandPage__c> dpInfo = [SELECT Id, Class_Name__c, Teacher_Name__c, Blue_Button__c, White_Button__c, Required_Props__c, Description__c, Type__c FROM demandPage__c];
        return dpInfo;
    }
}