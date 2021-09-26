module.exports = cds.service.impl( async function(){

    const {
        EmployeeSet
    } = this.entities;

    this.before('UPDATE', EmployeeSet, (req, res) => {
        if(parseFloat(req.data.salaryAmount) >= 1000000){
            req.error(500, "Salary must be below 1mn")
        }
    });

    this.on('boost', async req => {
        try{
            const ID = req.params[0];
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT : round({ '+=' : 2000}, 2), NOTE: "Boosted!!"
            });
            return "Boost was success";
        }catch (error){
            return "Error " + error.toStrig();
        }
    });

    this.on('largestOrder', async req => {
        try{
            const ID = req.params[0];
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);
            return reply;
              
        }catch (error){
            return "Error " + error.toStrig();
        }
    });
});