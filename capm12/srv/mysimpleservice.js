const mysrvdemo = function(srv){
    srv.on('somesrv', (req) => {
        return "hey " + req.data.msg;
    });
}

module.exports = mysrvdemo;