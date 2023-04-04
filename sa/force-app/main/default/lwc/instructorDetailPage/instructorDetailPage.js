import { LightningElement,track } from 'lwc';
import getdata from '@salesforce/apex/Instrutorclass.getdata';
import one from '@salesforce/resourceUrl/Like'
import two from '@salesforce/resourceUrl/Share'

export default class InstructorDetailPage extends LightningElement
 {
    @track searchKey;
    @track ismodalopen=false;;
    @track items=[];
    like=one;
    share=two;
    handleKeyChange(event)
    {
        this.searchKey=event.target.value;
        console.log(this.searchKey);
        if(this.searchKey!=null && this.searchKey!='')
        {
            this.getitems();
            this.ismodalopen=true;
        }
        else if(this.searchKey=='')
        {
            this.ismodalopen=false;
        }
       
       

        
    }
    getitems()
    {
        
        getdata({name: this.searchKey})
        .then(result => 
            {
                console.log(result);
                this.items = result;
           })
        .catch( error=>
        {
            console.log(error);
        });

    }
 }