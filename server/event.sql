SELECT A.uId,
CASE
WHEN alertItem = 1 THEN
'By Time'
WHEN alertItem = 2 THEN
'By Status'
WHEN alertItem = 3 THEN
'By PCS'
ELSE
'ERROR'
END eventtype,
A.PLANT,

FROM_UNIXTIME(round(A.STIME / 1000), '%Y/%m/%d %H:%i:%s') STIME,
case
when length(A.PTIME) <> 13 then
'尚未處理'
ELSE
FROM_UNIXTIME(round(A.PTIME / 1000), '%Y/%m/%d %H:%i:%s')
END ETIME,
case
when length(A.ENDINGTime) =  13 then
FROM_UNIXTIME(round(A.ENDINGTime / 1000), '%Y/%m/%d %H:%i:%s')
ELSE
'尚未解除'
END PTime,
'尚未結案' ENDINGTIME,
A.PIC,
A.MPIC,
A.mPicPhone,
B.eventName,
FROM_UNIXTIME(round(A.L1Time / 1000), '%Y/%m/%d %H:%i:%s') L1Time,FROM_UNIXTIME(round(A.L2Time / 1000), '%Y/%m/%d %H:%i:%s') L2Time,FROM_UNIXTIME(round(A.L3Time / 1000), '%Y/%m/%d %H:%i:%s') L3Time,
A.evtvalue1,A.evtvalue2,A.evtvalue3,A.evtvalue4,A.evtvalue5,A.evtvalue6,A.evtvalue7,A.evtvalue8,A.evtvalue9,A.evtvalue10,A.evtvalue11,A.evtvalue12,A.evtvalue13,A.evtvalue14,A.evtvalue15,
concat(A.replyUserName,'(',A.replyUserId,')') reply,A.actionname,A.comment,A.replyDate,A.reason,A.reasonName
FROM DMC_events A
right join DMC_eventList B
on A.eventId = B.eventId
AND A.IssueType = B.IssueType
WHERE A.eventTime = 'EventTime'
AND TRIM(A.PIC) LIKE 'user%'
AND A.alertType <> 1
AND A.plant  ='Plant'
AND A.STATUS = 'StatuS'
AND A.LEVEL = 'Level'
AND FROM_UNIXTIME(round(A.STime/1000,0))>=date_format('2021-05-10','%Y-%m-%d')