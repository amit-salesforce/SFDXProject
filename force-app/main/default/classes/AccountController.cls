/**
 * @description       : 
 * @author            : Gerardo Martinez
 * @group             : 
 * @last modified on  : 08-16-2022
 * @last modified by  : Gerardo Martinez
**/
public with sharing class AccountController {
    //changes
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }

}