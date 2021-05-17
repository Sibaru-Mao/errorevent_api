SELECT B.PLANT,
LTRIM(B.PIC) BYPIC,
LTRIM(SUBSTRING_INDEX(B.MPIC, ',', 2)) MPIC,
SUM(B.QTYPIC) QTYEVENTS,
SUM(periods) QTYTIME
FROM (SELECT A.plant,
CASE
WHEN length(A.pic) != char_length(A.piC) THEN
LTRIM(SUBSTRING_INDEX(REPLACE(A.pic, '/', ','), ',', 1))
ELSE
A.PIC
END PIC,
CASE
WHEN length(A.MPIC) != char_length(A.MPIC) AND MPIC RLIKE '\|' then
REPLACE(MPIC, '|', ',')
WHEN length(A.MPIC) != char_length(A.MPIC) AND MPIC LIKE ';' then
REPLACE(MPIC, ';', ',')
WHEN length(A.MPIC) != char_length(A.MPIC) AND
MPIC LIKE '\/' then
REPLACE(MPIC, '/', ',')
WHEN MPIC IS NULL then
" "
WHEN length(A.MPIC) = char_length(A.MPIC) THEN
A.MPIC
ELSE
"Error"
END AS MPIC,
A.QTYPIC,
periods
from (SELECT plant,
CASE
WHEN pic LIKE '%,%' then
LTRIM(SUBSTRING_INDEX(pic, ',', 1))
WHEN pic RLIKE '\|' then
LTRIM(SUBSTRING_INDEX(pic, '\|', 1))
WHEN pic LIKE ';' then
LTRIM(SUBSTRING_INDEX(pic, ';', 1))
when pic IS NULL then
" "
ELSE
"Error"
END AS pic,
COUNT(*) QTYPIC,
group_concat(distinct nullif(MPIC, '')) MPIC,
CASE
WHEN EndingTime IS NULL THEN
SUM(ROUND((unix_timestamp(NOW()) * 1000 - STime) / 1000 / 3600,
0))
ELSE
SUM(ROUND((EndingTime - STime) / 1000 / 3600, 0))
END periods
FROM DMC_events
WHERE plant IN ('Plant')
AND LEVEL IN ('Level')
AND STATUS IN ('Status')
AND alertType <> 1
AND pic <> ""
AND FROM_UNIXTIME(round(STime/1000,0))>=date_format('2021-05-10','%Y-%m-%d')
GROUP BY LTRIM(pic), plant) A) B
GROUP BY PIC
ORDER BY QTYEVENTS DESC, QTYTIME DESC