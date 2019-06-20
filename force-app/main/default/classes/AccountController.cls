public with sharing class AccountController {
<<<<<<< HEAD

    /*change in Acc2 */
=======
/* Change 2 New*/
>>>>>>> d36b050bd27a49d9aee5a5b39e6224e3b402eae6
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }

}