$GROUP ES_tech
	sigma[n]$((agg_ES[n])) ""
	mu[n,nn]$((in_ES2agg_ES[n,nn])) ""
;

$GROUP ES_exo
	p[n]$((in_ES[n])) ""
	q[n]$((out_ES[n])) ""
;

$GROUP ES_endo
	p[n]$((agg_ES[n])) ""
	q[n]$((sec_ES[n] and not out_ES[n])) ""
;

@load_level(ES_endo,%qmark%%ES%");
@load_fixed(ES_tech,%qmark%%ES%");
@load_fixed(ES_exo,%qmark%%ES%");
