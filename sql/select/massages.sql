-- Select all massages by response_id
SELECT massage_text, massage_timestamp, viewed, sender_id, recipient_id
FROM massages
WHERE response_id = $response_id
ORDER BY massage_timestamp ASC;