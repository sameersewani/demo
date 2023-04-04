public class signInController {
    @AuraEnabled(cacheable=true)
    public static string signInApexMethod(string emailInput, string password) {
        system.debug('Email:'+ emailInput);
        system.debug('password:'+ password);
        
        
        
        
        return 'success';
        
    }

}