select rule_code,Rule_sprule from rulesetc where Rule_Code in(
SELECT  Rule_sprule
					FROM rulesetc 
					WHERE Rule_sprule is not null and Rule_sprule>0
					)
					
update rulesetc set Rule_sprule =0 where Rule_Code=24					
