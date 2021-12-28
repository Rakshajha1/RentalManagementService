import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class MyPropertyEnquiery extends LightningElement {
    @api objectApiName;
    @api propertyId;
    @api recordId;

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Enquiry Submitted",
            message: "Success",
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}