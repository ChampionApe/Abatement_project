$GROUP FG_tech
	sigma[n]$((agg_FG[n])) ""
	mu[n,nn]$((in_FG2agg_FG[n,nn])) ""
;

$GROUP FG_exo
	p[n]$((in_FG[n])) ""
	q[n]$((out_FG[n])) ""
;

$GROUP FG_endo
	p[n]$((agg_FG[n])) ""
	q[n]$((sec_FG[n] and not out_FG[n])) ""
;

@load_level(FG_endo,%qmark%%FG%");
@load_fixed(FG_tech,%qmark%%FG%");
@load_fixed(FG_exo,%qmark%%FG%");
