ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `event_arg_0` varchar(100) GENERATED ALWAYS AS (attributes->>'$[0].value') STORED NULL AFTER `attributes`;  

ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `event_arg_1` varchar(100) GENERATED ALWAYS AS (attributes->>'$[1].value') STORED NULL AFTER `event_arg_0`;  

ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `event_arg_2` varchar(100) GENERATED ALWAYS AS (attributes->>'$[2].value') STORED NULL AFTER `event_arg_1`;  

ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `event_arg_3` varchar(100) GENERATED ALWAYS AS (attributes->>'$[3].value') STORED NULL AFTER `event_arg_2`;  

ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `claim_type` varchar(30) GENERATED ALWAYS AS (JSON_UNQUOTE(JSON_EXTRACT(JSON_KEYS(attributes, '$[1].value.claim'), '$[0]'))) STORED NULL AFTER `event_arg_2`;  

ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `claim_scope` varchar(66) GENERATED ALWAYS AS (
	CASE 
    WHEN JSON_UNQUOTE(JSON_EXTRACT(JSON_KEYS(attributes, '$[1].value.claim'), '$[0]')) = 'CustomerDueDiligence' THEN null
    WHEN JSON_UNQUOTE(JSON_EXTRACT(JSON_KEYS(attributes, '$[1].value.claim'), '$[0]')) <> 'Jurisdiction' THEN JSON_UNQUOTE(JSON_EXTRACT(attributes->>'$[1].value.claim[0].*', '$[0]'))
	ELSE JSON_UNQUOTE(JSON_EXTRACT(JSON_EXTRACT(attributes->>'$[1].value.claim[0].*', '$[0]'), '$.col2'))
END) STORED NULL AFTER `claim_type`;  
            
ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `claim_issuer` varchar(66) GENERATED ALWAYS AS (attributes->>'$[1].value.claim_issuer') STORED NULL AFTER `claim_scope`;  

ALTER TABLE `polymesh-harvester`.data_event 
ADD COLUMN `claim_expiry` varchar(15) GENERATED ALWAYS AS (
	CASE
    WHEN attributes->>'$[1].value.expiry' = 'null' THEN null
    ELSE attributes->>'$[1].value.expiry'
    END) STORED NULL AFTER `claim_issuer`;  

CREATE INDEX ix_data_event_event_arg_0 ON `polymesh-harvester`.data_event (event_arg_0); 

CREATE INDEX ix_data_event_event_arg_1 ON `polymesh-harvester`.data_event (event_arg_1); 

CREATE INDEX ix_data_event_event_arg_2 ON `polymesh-harvester`.data_event (event_arg_2); 

CREATE INDEX ix_data_event_claim_type ON `polymesh-harvester`.data_event (claim_type); 

CREATE INDEX ix_data_event_claim_scope ON `polymesh-harvester`.data_event (claim_scope); 

CREATE INDEX ix_data_event_claim_issuer ON `polymesh-harvester`.data_event (claim_issuer); 