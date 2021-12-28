import { LightningElement, wire } from 'lwc';
import fetchFooterContent from '@salesforce/apex/footerComponentLWCservice.fetchFooterContent';
export default class FooterComponents extends LightningElement {

    footerContents;
    errors;

    @wire(fetchFooterContent)
    wiredData({ error, data }) {
        if (data) {
            console.log('footerContents', data);
            this.footerContents = data;
            this.errors = undefined;
        } else if (error) {
            console.error('Error:', error);
            this.footerContents = undefined;
            this.errors = error;
        }
    }
}