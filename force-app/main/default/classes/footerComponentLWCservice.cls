public with sharing class footerComponentLWCservice {
	@AuraEnabled(cacheable=true)
		public static List<Footer__c> fetchFooterContent(){
			List<Footer__c>footerContent = new List<Footer__c>();
			try{
				footerContent = [SELECT Id, Name FROM Footer__c WITH SECURITY_ENFORCED LIMIT 3];
			}Catch(Exception e){
				throw new AuraHandledException(e.getMessage());
			}
			return footerContent;
		}
}
