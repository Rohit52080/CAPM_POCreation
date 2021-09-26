const cds = require("@sap/cds");
const { employees} = cds.entities("rohit.db.master");
const mysrvdemo = function(srv){
    srv.on('somesrv', (req) => {
        return "hey " + req.data.msg;
    });
srv.on("READ", "ReadEmployeeSrv", async(req, res) => {
    var results = [];
    // results.push({
    //     "ID":"909038238928-9209203-0909",
    //     "nameFirst": "Rohit",
    //     "nameLast": "Shuklaa"

    // });

    //CDS-Query Language(i am not coupling my query to databse. It will run no matter what database is)
    //results = await cds.tx(req).run(SELECT.from(employees).limit(5));

    //CDS Query to read single records with where clause
    //results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst": "Susan"}));

    //CDS Query if user pass key like /Entity/key
    var whereCondition = req.data;
    console.log(whereCondition);
    if(whereCondition.hasOwnProperty("ID")){
        results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));

    }else{
        results = await cds.tx(req).run(SELECT.from(employees).limit(1));
    }
    return results;

    //
});

srv.on("INSERT", "InsertEmployeeSrv", async(req, res) => {
    console.log(req.data);
    let returnData = await cds.transaction(req).run([
        INSERT.into(employees).entries([req.data])
    ]).then( (resolve, rejet) => {
        if(typeof(resolve) !== undefined){
            return req.data;
        }else{
            req.error(500, "There was an issue in insert");

        }
    }).catch( err=> {
        req.error(500, "there was an error " + err.toString());
    });
});

srv.on("UPDATE", "UpdateEmployeeSrv", async(req, res) =>{
    let returnData = await cds.transaction(req).run([
        UPDATE(employees).set({
            nameFirst: req.data.nameFirst
        }).where({ ID : req.data.ID}),

        UPDATE(employees).set({
            nameMiddle: req.data.nameMiddle
        }).where({ ID : req.data.ID})

    ]).then((resolve, rejet) => {
        if(typeof(resolve) !== undefined){
            return req.data
        }else{
            req.error(500, "there was an issue in Upadte")
        }
    }).catch( err => {
        req.error(500, "there was nan error " + err.toString)
    });

    return returnData;
})

}

module.exports = mysrvdemo;
