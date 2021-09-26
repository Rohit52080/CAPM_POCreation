using { rohit.db.master, rohit.db.transaction } from '../db/datamodel';


service CatalogSerive@(path:'/CatalogService') {
    @Capabilities : { Insertable, Updatable: true, Deletable }
    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    // entity ProducTexts as projection on master.prodtext;
    entity BPSet as projection on master.businesspartner;


    entity POs @(
        title: '{i18n>poHeader}'
    ) as projection on transaction.purchaseorder{
        *,
        Items: redirected to POItems
    }actions{
        function largestOrder() returns array of POs;
        action boost();
    }

    entity POItems @( title : '{i18n>poItems}' )
    as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }
}