using { rohit.db.CDSView } from '../db/CDSView';
using { rohit.db.master , rohit.db.transaction } from '../db/datamodel';


service CDSService@(path:'/CDSService') {

    entity POWorklist as projection on CDSView.PoWorkList;
    entity ProductOrders as projection on CDSView.ProductViewSum;
    entity ProductAggregation as projection on CDSView.CProductValuesView;
    

}