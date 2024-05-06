var helper = require('./../helpers/helpers')
var db = require('./../helpers/db_helpers')

module.exports.controller = (io, socket_list) => {
    var response = '';

    const msg_success = "Thành công";
    const msg_invalidUser = "Tên người dùng hoặc mật khẩu không hợp lệ";

    // Xử lý sự kiện kết nối từ các client tới server thông qua socket.io
    io.on('connection', (client) => {
        client.on('UpdateSocket', (data) => {
            helper.Dlog('UpdateSocket :- ' + data);
            var jsonObj = JSON.parse(data);

            helper.CheckParameterValidSocket(client, "UpdateSocket",  jsonObj, ['user_id'], () => {
                db.query("SELECT `user_id`, `email` FROM `user_detail` WHERE `user_id` = ?;", [jsonObj.user_id], (err, result) => {

                    if(err) {
                        helper.ThrowSocketError(err, client, "UpdateSocket")
                        return;
                    }

                    if(result.length > 0) {
                        socket_list['us_' + jsonObj.user_id] = { 'socket_id': client.id}

                        helper.Dlog(socket_list);
                        response = { "success": "true", "status": "1", "message": msg_success }
                    }else{
                        response = {"success":"false", "status":"0", "message": msg_invalidUser}
                    }
                    client.emit('UpdateSocket', response) // Gửi phản hồi về client thông qua sự kiện 'UpdateSocket'
                })
            })

        })
    })
}