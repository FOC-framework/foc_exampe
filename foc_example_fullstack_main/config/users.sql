select u."NAME", u."FULL_NAME", u."Phone", g."NAME", m."NAME", k."NAME" from "FUSER" u 
left join "FGROUP" g on u."GRP_REF"=g."REF"
left join "Municipality" m on m."REF"=u."Municipality_REF"
left join "Kadaa" k on k."REF"=m."Kadaa_REF"
;