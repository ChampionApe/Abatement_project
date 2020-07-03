$FIX FG_tech, FG_exo;

$UNFIX FG_endo;

$Model FG M_FG;

solve FG using CNS;
