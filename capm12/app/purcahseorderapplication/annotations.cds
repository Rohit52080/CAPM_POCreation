using { CatalogService } from '../../srv/CatalogService';

//First screen with Search Field and Table Columns

annotate CatalogService.POs with @(
    UI: {
        //To get the deafult filters when application loads
        SelectionFields: [
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_CODE
        ],
        // to get the default columns when application loads
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'Boost',
                Action : 'CatalogService.boost',
                Inline : true
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_CODE
            },
            {
                $Type : 'UI.DataField',
                Value :  PARTNER_GUID.COMPANY_NAME  
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
                Criticality : Criticality,
                CriticalityRepresentation : #WithIcon
            }
        ],

        // to get the details on next page (after navigation) on the Header
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '{i18n>PurchaseOrder}',
            TypeNamePlural : '{i18n>PurchaseOrders}',
            Title : {
                Label: '{i18n>POID}',
                Value : PO_ID
            },
            Description : {
                Label : '{i18n>DESC}',
                Value : PARTNER_GUID.COMPANY_NAME
            },
            ImageUrl: 'https://thumbs.dreamstime.com/z/sap-logo-building-wall-brisbane-queensland-australia-st-january-hanging-front-facade-european-multinational-software-170279003.jpg'
        },
        //it will be shows as Tabs in detail page
        Facets  : [{
                $Type: 'UI.ReferenceFacet',
                Label: '{i18n>POGeneralInfo}',
                Target : ![@UI.FieldGroup#HeaderGeneralInformation] // target below field group to show the fiels
            },{
                $Type: 'UI.ReferenceFacet',
                Label : '{i18n>POItemDetails}',
                Target : 'Items/@UI.LineItem'                
            }       
        ],
        // this will be shown as fields in the Tab 
        FieldGroup#HeaderGeneralInformation  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ID
                },
                {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID_NODE_KEY
                },
                {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID.COMPANY_NAME
                },
                {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID.BP_ID
                },
                {
                    $Type : 'UI.DataField',
                    Value : LIFECYCLE_STATUS
                },
                {
                    $Type : 'UI.DataField',
                    Value : CURRENCY_CODE
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT
                },
                                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT
                }
            ]
            
        },
    }
);

    annotate CatalogService.POItems with @(
        UI: {
          LineItem  : [
              {
                  $Type : 'UI.DataField',
                  Value : PO_ITEM_POS
              },
             {
                  $Type : 'UI.DataField',
                  Value : PRODUCT_GUID_NODE_KEY
              },
              {
                  $Type : 'UI.DataField',
                  Value : PRODUCT_GUID.PRODUCT_ID
              },
              {
                  $Type : 'UI.DataField',
                  Value : GROSS_AMOUNT
              },
              {
                  $Type : 'UI.DataField',
                  Value : TAX_AMOUNT
              },
              {
                  $Type : 'UI.DataField',
                  Value : NET_AMOUNT
              },
              {
                  $Type : 'UI.DataField',
                  Value : CURRENCY_CODE
              }
              
          ],
        // to get the details on next page (after navigation) on the Header
          HeaderInfo  : {
              $Type : 'UI.HeaderInfoType',
              TypeName : 'PO Item',
              TypeNamePlural : 'PO Items',
              Title : {
                  $Type : 'UI.DataField',
                  Value : NODE_KEY
              },
              Description : {
                  $Type : 'UI.DataField',
                  Value : PO_ITEM_POS
              }
          },

          Facets  : [
              {
                  $Type : 'UI.ReferenceFacet',
                  Target : '@UI.FieldGroup#LineItemHeader',
                  Label : '{i18n>lineItemHeader}'
              },
              {
                  Label : 'Product Details',
                  $Type : 'UI.ReferenceFacet',
                  Target : 'PRODUCT_GUID/@UI.FieldGroup#ProductDetails'
              }
          ],
          FieldGroup#LineItemHeader  : {
              $Type : 'UI.FieldGroupType',
              Data: [
                  {
                      $Type : 'UI.DataField',
                      Value : PO_ITEM_POS
                  },
                  {
                      $Type : 'UI.DataField',
                      Value : PRODUCT_GUID_NODE_KEY
                  },
                  {
                      $Type : 'UI.DataField',
                      Value : GROSS_AMOUNT
                  },
                  {
                      $Type : 'UI.DataField',
                      Value : TAX_AMOUNT
                  },
                  {
                      $Type : 'UI.DataField',
                      Value : NET_AMOUNT
                  },
                  {
                      $Type : 'UI.DataField',
                      Value : CURRENCY_CODE
                  }
              ]
              
          },
        }


    ) ;

    annotate CatalogService.ProductSet with @(

        UI: {
            HeaderInfo  : {
                $Type : 'UI.HeaderInfoType',
                TypeName : 'Product',
                TypeNamePlural : 'Products',
                Title : {
                    Value : PRODUCT_ID
                },
                Description :{
                    Value : DESCRIPTION
                },
                ImageUrl : 'sap-icon://product'
            },
            FieldGroup#ProductDetails  : {
                $Type : 'UI.FieldGroupType',
                Data : [
                    {
                        $Type : 'UI.DataField',
                        Value : PRODUCT_ID,
                    },
                    {
                        $Type : 'UI.DataField',
                        Value : DESCRIPTION,
                    },
                    {
                        $Type : 'UI.DataField',
                        Value : TYPE_CODE,
                    },
                    {
                        $Type : 'UI.DataField',
                        Value : CATEGORY,
                    },
                    {
                        $Type : 'UI.DataField',
                        Value : SUPPLIER_GUID.COMPANY_NAME,
                    }
                    
                ],
                
            },
        }
    );
    
    
