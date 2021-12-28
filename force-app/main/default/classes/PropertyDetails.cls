public with sharing class PropertyDetails {
	public PropertyDetails() {
        }    
        @AuraEnabled(cacheable=true)
        public Static List<Product2>getLatestProperty(){
        List<Product2>allPropertyList= new List<Product2>();
        allPropertyList = [SELECT Id,
														ZIP_Code__c,
                            State__c, 
                            Rent_Amount__c, 
                            Property_Type__c, 
                            Property_Image__c, 
                            Occupancy_Status__c, 
                            Name, 
                            IsActive, 
                            Geo_Map__c, 
                            Description, City__c, 
                            Account__c,
                            Address__c, 
                            Area_Sq_ft__c,
                            BedRooms__c, 
                            Bathrooms__c,
                            Location__c,
														Property_Owner__c
                            FROM Product2 WHERE IsActive !=False AND Rent_Amount__c != NULL LIMIT 50];
            return allPropertyList;                
        }    
    @AuraEnabled(cacheable=true)
        public static List<Product2> getSearchedProperty(String Location, String BedRooms,String Bathrooms, String maxBudget ) {
					List<Product2>allPropertyList= new List<Product2>();
            String propertyQuery = 'SELECT Id, ZIP_Code__c, State__c,Rent_Amount__c,Property_Type__c, Property_Image__c, Occupancy_Status__c,Property_Owner__c';
        
            propertyQuery = propertyQuery +' Name, IsActive, Geo_Map__c, Description, City__c, Account__c, Address__c, Area_Sq_ft__c, BedRooms__c, Bathrooms__c,Location__c';

            propertyQuery = propertyQuery +' FROM Product2 ';
        
            string whereClause = 'WHERE Rent_Amount__c!=NULL';
        
            system.debug('****location'+location);
        
            if(string.isNotBlank(location)){
            //string locationSearch = +location+'%';
            if(location !='ALL'){
                whereClause = whereClause+' AND Location__c = :location';
            }
        }
        system.debug('****bedroom'+BedRooms);
        integer bedroomcount;
        if(string.isNotBlank(BedRooms)){
            if(BedRooms !='ALL'){
                  bedroomcount= integer.valueOf(BedRooms);
                 system.debug('****bedroomcount'+bedroomcount);
            whereClause  = whereClause+' AND BedRooms__c=:bedroomcount';  
            }
        }
        system.debug('****bathroom'+Bathrooms);
          integer bathroomcount;
        if(string.isNotBlank(Bathrooms)){
             if(Bathrooms !='ALL'){
                 bathroomcount= integer.valueOf(Bathrooms);
                whereClause  = whereClause+' AND Bathrooms__c=:bathroomcount';  
             }  
        }
        system.debug('****maxbudget'+Bathrooms);
        double maxBudgetValue;
        if(string.isNotBlank(maxbudget)){
            
            maxBudgetValue = double.valueOf(maxbudget) ;    
            whereClause  = whereClause+' AND Rent_Amount__c<=:maxBudgetValue';      
        }
        propertyQuery = propertyQuery +' '+whereClause;
        system.debug('propertyQuery'+propertyQuery);
        allPropertyList = Database.query(propertyQuery);
        system.debug('allPropertyList'+ allPropertyList);
        return allPropertyList;
    }
    @AuraEnabled(cacheable=true)
    public static Product2 getDetails(string propId){
			Product2 prop = [SELECT Id,
                                    Area_Sq_ft__c,
                                    Geo_Map__c,
                                    Location__c,
                                    Address__c,
                                    Bathrooms__c,
                                    BedRooms__c,
                                    Description,
                                    Property_Image__c,
                                    Name,
                                    Rent_Amount__c,
                                    Occupancy_Status__c,
																		Property_Owner__c
                                    FROM Product2
                                    WHERE Id=:propId
                                    LIMIT 50
                                    ];
        return prop;
    }
}