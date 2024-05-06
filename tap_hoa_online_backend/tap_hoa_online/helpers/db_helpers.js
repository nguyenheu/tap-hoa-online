var mysql = require('mysql')
var config = require('config')
var dbConfig = config.get('dbConfig')
var db = mysql.createConnection(dbConfig);
var helper = require('./helpers')

// Kiểm tra nếu có tính năng tùy chọn 'detail' trong cấu hình
if(config.has('optionalFeature.detail')) {
    var detail = config.get('optionalFeature.detail');
    helper.Dlog('config: ' + detail);
}

reconnect(db, () => {});

function reconnect(connection, callback) {
    helper.Dlog("\n Kết nối mới ... (" + helper.serverYYYYMMDDHHmmss() + ")" )

    connection = mysql.createConnection(dbConfig);
    connection.connect((err) => {
        if(err) {
            helper.ThrowHtmlError(err);

            setTimeout(() => {
                helper.Dlog('----------------- Lỗi Tái kết nối DB (' + helper.serverYYYYMMDDHHmmss() + ') ....................' );

                reconnect(connection, callback);
            }, 5 * 1000);
        }else{
            helper.Dlog('\n\t ----- Kết nối mới với cơ sở dữ liệu đã được thiết lập. -------');
            db = connection;
            return callback();
        }
    } )

    // Xử lý sự kiện lỗi kết nối
    connection.on('error', (err) => {
        helper.Dlog('----- Ứng dụng gặp sự cố kết nối với DB Helper (' + helper.serverYYYYMMDDHHmmss() + ') -------');

        if (err.code === "PROTOCOL_CONNECTION_LOST") {
            helper.Dlog("/!\\ PROTOCOL_CONNECTION_LOST Lỗi kết nối với cơ sở dữ liệu. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_ENQUEUE_AFTER_QUIT") {
            helper.Dlog("/!\\ PROTOCOL_ENQUEUE_AFTER_QUIT Lỗi kết nối với cơ sở dữ liệu. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR") {
            helper.Dlog("/!\\ PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR Lỗi kết nối với cơ sở dữ liệu. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_ENQUEUE_HANDSHAKE_TWICE") {
            helper.Dlog("/!\\ PROTOCOL_ENQUEUE_HANDSHAKE_TWICE Lỗi kết nối với cơ sở dữ liệu. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "ECONNREFUSED") {
            helper.Dlog("/!\\ ECONNREFUSED Lỗi kết nối với cơ sở dữ liệu. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_PACKETS_OUT_OF_ORDER") {
            helper.Dlog("/!\\ PROTOCOL_PACKETS_OUT_OF_ORDER Lỗi kết nối với cơ sở dữ liệu. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        }  else {
            throw err;
        }
    })

}

module.exports = {
    query: (sqlQuery, args, callback) => {

        if(db.state === 'authenticated' || db.state === "connected") {
            db.query(sqlQuery, args, (error, result) => {
                return callback(error, result);
            })
        }else if ( db.state === "protocol_error" ) {
            //nếu lỗi, thực hiện tái kết nối
            reconnect(db, () => {
                db.query(sqlQuery, args, (error, result) => {
                    return callback(error, result);
                })
            })
        }else{
            reconnect(db, ()=>{
                db.query(sqlQuery, args, (error, result ) => {
                    return callback(error, result);
                } )
            })
        }

    }
}

process.on('uncaughtException', (err) => {

    helper.Dlog('------------------------ App is Crash DB helper (' + helper.serverYYYYMMDDHHmmss() + ')-------------------------' );
    helper.Dlog(err.code);
    helper.ThrowHtmlError(err);
})