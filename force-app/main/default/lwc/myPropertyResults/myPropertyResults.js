/* eslint-disable no-console */
import { LightningElement, track, wire, api } from 'lwc';
import getLatestProperty from '@salesforce/apex/PropertyDetails.getLatestProperty';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { NavigationMixin } from 'lightning/navigation';
import getSearchedProperty from '@salesforce/apex/PropertyDetails.getSearchedProperty';
//import { registerListener, unregisterAllListeners } from 'c/pubsub';
//import { CurrentPageReference } from 'lightning/navigation';
//export default class MyPropertyResult extends NavigationMixin(LightningElement) {
export default class MyPropertyResult extends LightningElement {
    @track properties;
    @track propOwnerId;
    @track feedbackPropertyId;
    @track propertiesFound;
    @track propid;
    @api openOwnerDetails = false;
    @api openFeedbackDetails = false;
    @api openPropertyDetails = false;
    //@track locFilter;
    //@track bedroomFilter;
    //@track bathroomFilter;
    //@track budgetFilter;

    // @track propOwnerId;
    // @track openOwnerDetails = false;

    @wire(getLatestProperty)
    wiredProperties({ data, error }) {
        if (data) {
            this.properties = data;
            this.propertiesFound = true;
        } else if (error) {
            this.showToast('Error', error.body.message, 'error');
            this.propertiesFound = false;
        }
    }
    get propertiesFound() {
        if (this.properties) {
            return true;
        }
        return false;
    }
    showToast(title, message, variant) {
            const evt = new ShowToastEvent({
                title: title,
                message: message,
                variant: variant,
            });
            this.dispatchEvent(evt);
        }
        /* ownerDetailsClick(event) {
             this.propOwnerId = event.target.value;
             this.openOwnerDetails = true;

         }
         closeOwnerModal() {
             this.openOwnerDetails = false;
         }*/

    feedbackClicked(event) {
        this.openFeedbackDetails = true;
        this.feedbackPropertyID = event.target.value;
    }
    closeFeedbackModal() {
        this.openFeedbackDetails = false;
    }
    NavigateToPropDetails(event) {
        this.openPropertyDetails = true;
        this.NavigateToPropDetailsId = event.target.value;
    }
    closePropertyModal() {
        this.openPropertyDetails = false;
    }

    //        console.log('Inside this.propId' + this.propId);
    //        this[NavigationMixin.Navigate]({
    //            type: 'standard__component',
    //            attributes: {
    //                componentName: 'c__MyProperty360View'
    //            },
    //            state: {
    //                c__PropertyId: this.propId
    //            }
    //        });
    //    }
    //@wire(CurrentPageReference) pageRef;
    //connectedCallback() {
    //    registerListener("handelLocFilterChange", this.handelLocFilterChange, this);
    //}
    //disconnectedCallback() {
    //    unregisterAllListeners(this);
    //}
    //handelLocFilterChange(locchange) {
    //    this.locFilter = locchange;
    //    getSearchedProperty({
    //            Location: this.locFilter,
    //            BedRooms: this.bedroomFilter,
    //            Bathrooms: this.bathroomFilter,
    //            maxBudget: this.budgetFilter
    //        })
    //        .then(result => {
    //            this.properties = result;
    //        })
    //        .catch(error => {
    //            this.showToast('ERROR', error.body.message, 'error');
    //        });
    //}


}