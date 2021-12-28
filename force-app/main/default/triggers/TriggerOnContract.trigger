trigger TriggerOnContract on Contract (after insert, after update, after delete, after undelete) {
	Map<Id, List<Contract>> mapAccountIdContractList = new Map<Id, List<Contract>>();
	Map<Id, List<Contract>> mapAccountIdDelContractList = new Map<Id, List<Contract>>();
	Set<Id> AccIds = new Set<Id>();    
	List<Account> AccountList = new List<Account>();
	
	if(trigger.isInsert) {
			for(Contract cs : trigger.New) {
					if(String.isNotBlank(cs.AccountId) && cs.status == 'Activated' ) {
							if(!mapAccountIdContractList.containsKey(cs.AccountId)) {
									mapAccountIdContractList.put(cs.AccountId, new List<Contract>());
							}
							mapAccountIdContractList.get(cs.AccountId).add(cs); 
							AccIds.add(cs.AccountId);
					}   
			}  
	}
	
	if(trigger.isUpdate) {
			for(Contract cs : trigger.New) {
					if(String.isNotBlank(cs.AccountId) && cs.AccountId != trigger.oldMap.get(cs.Id).AccountId && cs.status == 'Activated') {
							if(!mapAccountIdContractList.containsKey(cs.AccountId)){
									mapAccountIdContractList.put(cs.AccountId, new List<Contract>());
							}
							mapAccountIdContractList.get(cs.AccountId).add(cs); 
							AccIds.add(cs.AccountId);
					} else if(String.isBlank(cs.AccountId) && String.isNotBlank(trigger.oldMap.get(cs.Id).AccountId)) {
							if(!mapAccountIdDelContractList.containsKey(cs.AccountId)){
									mapAccountIdDelContractList.put(cs.AccountId, new List<Contract>());
							}
							mapAccountIdDelContractList.get(cs.AccountId).add(cs);   
							AccIds.add(trigger.oldMap.get(cs.Id).AccountId);
					}
			}  
	}
	
	if(trigger.isUndelete) {
			for(Contract cs : trigger.new) {
					if(String.isNotBlank(cs.AccountId)){
							if(!mapAccountIdContractList.containsKey(cs.AccountId)){
									mapAccountIdContractList.put(cs.AccountId, new List<Contract>());
							}
							mapAccountIdContractList.get(cs.AccountId).add(cs);     
							AccIds.add(cs.AccountId);
					}
			}  
	}      

	if(trigger.isDelete) {
			for(Contract cs : trigger.Old) {
					if(String.isNotBlank(cs.AccountId)){
							if(!mapAccountIdDelContractList.containsKey(cs.AccountId)){
									mapAccountIdDelContractList.put(cs.AccountId, new List<Contract>());
							}
							mapAccountIdDelContractList.get(cs.AccountId).add(cs);    
							AccIds.add(cs.AccountId); 
					}
			}  
	}  
}