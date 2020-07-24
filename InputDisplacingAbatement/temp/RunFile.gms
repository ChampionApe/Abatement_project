$FIX FG_tech, FG_exo, ES_tech, ES_exo;

$UNFIX FG_endo, ES_endo;

$Model FG_ES M_FG, M_ES;

solve FG_ES using CNS;
