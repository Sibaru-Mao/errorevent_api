const app = require('../../server/server')

module.exports = function getdata(sql,cb){
  try {
    let ds = app.dataSources.mariaDB; // 获取oracle数据库连接
    let connectionPool = ds.connector.client; // 数据库连接池
    connectionPool.getConnection(function (err, connection) {
      connection.query(sql, {},
        function (err1, results) {
          if (err1) {
            cb(err1, results);
          }
          cb(err1, results);
          process.nextTick(() => {
            connection.release();
          });
        });
    });
  } catch (error) {
    cb(error);
  }
}
