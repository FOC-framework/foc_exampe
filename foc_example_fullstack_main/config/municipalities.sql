select 
m."NAME" as municipality,
k."NAME" as makaa,
z."NAME" as mouhafaza
from "Municipality" m
left join "Kadaa" k on k."REF" = m."Kadaa_REF" 
left join "Mouhafaza" z on z."REF" = k."Mouhafaza_REF"; 