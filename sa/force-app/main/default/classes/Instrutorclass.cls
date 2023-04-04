public with sharing class Instrutorclass 
{
    @AuraEnabled
    public static List<Instructor__c> getdata(String name)
    {
        String keyString = '%'+name+'%';
      List<Instructor__c> names = [select Name,Designation__c,Description__c,Photo__c,Icon__c from Instructor__c where Name like:keyString];
      return names;

    }
}
