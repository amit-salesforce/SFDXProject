public with sharing class AccountController {
<<<<<<< HEAD

=======
  
>>>>>>> 7dbcd08fdcc5b9330d304993ca0bba5c438c5d3c
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }

}