public with sharing class ContactController {

<<<<<<< HEAD:force-app/main/default/classes/ContactController.cls
=======
  /* change-2-2 */
>>>>>>> 06d63e03fc875a7569d182dfbe1a313877913fd3:force-app/main/default/classes/ContactController1.cls
public static List<Contact> getContactList() {
        return [SELECT Id, Name, Title, Phone, Email FROM Contact  LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WHERE Name LIKE :key  LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact(){
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 1];
    }

}
