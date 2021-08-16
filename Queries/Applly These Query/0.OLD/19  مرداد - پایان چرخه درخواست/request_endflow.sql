alter table ta_request add request_EndFlow bit

update TA_Request
set request_EndFlow=1
where
request_id in (SELECT isnull(reqStat_RequestID,0) FROM TA_RequestStatus where reqStat_EndFlow=1)

