'use strict';
const app = require('../../server/server')
const fs = require('fs');
const getData = require('../services/dataservice')

module.exports = function (Sortbyevent) {
  Sortbyevent.geterrorsort = function (plant, status, level, cb) {
    let sql = fs.readFileSync('server/picEvent.sql', "utf8");
    sql = sql.replace(new RegExp("Plant"), plant);
    sql = sql.replace(new RegExp("Status"), status);
    sql = sql.replace(new RegExp("Level"), level);
    getData(sql, cb);
  };

  Sortbyevent.remoteMethod('geterrorsort', {
    http: {
      path: '/errorsort',
      verb: 'get',
    },
    accepts: [{
      arg: 'plant',
      type: 'string',
      required: false,
      http: {
        source: 'query'
      },
    },
    {
      arg: 'status',
      type: 'string',
      required: false,
      http: {
        source: 'query'
      }
    },
    {
      arg: 'level',
      type: 'string',
      required: false,
      http: {
        source: 'query'
      }
    }],
    returns: {
      arg: 'res',
      type: 'Object',

    },
    description: '获取總異常項目以数量排序',
  });


  Sortbyevent.geteventstatus = function (pic, plant = "F232','F236','F237','F2C1','F7B1','WKS", status = "0','3','4", level = "L4','L3','L2','L1", cb) {
    let sql = fs.readFileSync('server/status.sql', "utf8");
    sql = sql.replace(new RegExp("user"), pic);
    sql = sql.replace(new RegExp("Plant"), plant);
    sql = sql.replace(new RegExp("Status"), status);
    sql = sql.replace(new RegExp("Level"), level);
    getData(sql, cb);
  };

  Sortbyevent.remoteMethod('geteventstatus', {
    http: {
      path: '/eventstatus',
      verb: 'get',
    },
    accepts: [{
        arg: 'pic',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },
      {
        arg: 'plant',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },
      {
        arg: 'status',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },
      {
        arg: 'level',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      }
    ],
    returns: {
      arg: 'res',
      type: 'Object',

    },
    description: '获取總異常項目状态信息',
  });

  Sortbyevent.geteventtype = function (type,pic, plant, status, level, cb) {
    let sql = fs.readFileSync('server/event.sql', "utf8");
    sql = sql.replace(new RegExp("EventTime"), type);
    sql = sql.replace(new RegExp("user"), pic);
    sql = sql.replace(new RegExp("Plant"), plant);
    sql = sql.replace(new RegExp("StatuS"), status);
    sql = sql.replace(new RegExp("Level"), level);
    getData(sql, cb);
  };

  Sortbyevent.remoteMethod('geteventtype', {
    http: {
      path: '/eventtype',
      verb: 'get',
    },
    accepts: [{
        arg: 'type',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },{
        arg: 'pic',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },
      {
        arg: 'plant',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },
      {
        arg: 'status',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      },
      {
        arg: 'level',
        type: 'string',
        required: false,
        http: {
          source: 'query'
        }
      }
    ],
    returns: {
      arg: 'res',
      type: 'Object',

    },
    description: '获取總異常項目详细信息',
  });

};
