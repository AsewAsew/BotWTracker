import { LightningElement, wire } from 'lwc';
import getShrineList from '@salesforce/apex/BotWTrackerHelper.getShrines';
import getRegions from '@salesforce/apex/BotWTrackerHelper.getRegions';

export default class ShrineComp extends LightningElement {
    
    page = 1;
    perPage = 15;
    regionId = "";
    @wire(getRegions) regions;
    @wire(getShrineList, { page: this.page, perPage: this.perPage, regionId: this.regionId}) shrines;
}