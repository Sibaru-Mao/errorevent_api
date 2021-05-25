SELECT 
DATE_FORMAT(FROM_UNIXTIME(round(A.stime / 1000)), '%Y/%m/%d %H:%i') occurrence,
concat(ROUND((unix_timestamp(NOW()) * 1000 - A.STime) / 1000 / 3600, 0),
"H") duration,
A.plant situation,A.eventId eventId,B.eventName picgroup,A.shortMessage content,
case
when A.STATUS = 0 then
"Open"
when A.STATUS = 3 then
"On-Going"
when A.STATUS = 4 then
"Pending"
ELSE
"Error"
END eventstatus,
A.level level,
A.eventTime eventtime
FROM DMC_events A LEFT join DMC_eventList B on A.eventId=B.eventId AND A.IssueType=B.IssueType
WHERE A.alertType <> 1
AND TRIM(A.PIC) LIKE 'user%'
AND A.plant IN ('Plant')
AND A.STATUS IN ('Status')
AND A.LEVEL IN ('Level')
AND A.todmc <> 0
AND FROM_UNIXTIME(round(A.STime/1000,0))>=date_format('2021-05-10','%Y-%m-%d')
ORDER BY A.STATUS, A.LEVEL, A.STime