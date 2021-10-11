using { rohit.db.master, rohit.db.transaction } from '../db/datamodel';


service CatalogService@(path:'/CatalogService')
 {    
 @Capabilities : { Insertable,Updatable,Deletable }
    entity EmployeeSet
    as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    @readonly
    entity BPSet as projection on master.businesspartner;
    
    entity POs @(
        title: '{i18n>poHeader}',
        odata.draft.enabled: true
    ) as projection on transaction.purchaseorder{
        *,
        round(GROSS_AMOUNT,2) as GROSS_AMOUNT: Decimal(15,2),
        case LIFECYCLE_STATUS
        when 'N' then 'New'
        when 'D' then 'Delivered'
        when 'B' then 'Blocked'
        end as LIFECYCLE_STATUS : String(20),

        case LIFECYCLE_STATUS 
        when 'N' then 2 //Orange
        when 'B' then 1 //Red
        when 'D' then 3 //Green
        end as Criticality : Integer, 
        Items: redirected to POItems
    }actions{
        function largestOrder() returns array of POs;
        action boost();
    }

    annotate POs with {
        GROSS_AMOUNT @title: '{i18n>GROSS_AMOUNT}';  
    };
    annotate POs with {
        LIFECYCLE_STATUS @title: '{i18n>LIFECYCLE_STATUS}';  
    };
    

    entity POItems @( title : '{i18n>poItems}' )
    as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }

}