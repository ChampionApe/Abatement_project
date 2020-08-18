$GROUP ES_tech
	sigma[n]$((a_ES[n])) ""
	mu[n,nn]$((map_ES[n,nn])) ""
;

$GROUP ES_exo
	p[n]$((input_ES[n])) ""
	q[n]$((output_ES[n])) ""
;

$GROUP ES_endo
	p[n]$((a_ES[n])) ""
	q[n]$((sector_ES[n] and not output_ES[n])) ""
;

@load_level(ES_endo,%qmark%%ES%");
@load_fixed(ES_tech,%qmark%%ES%");
@load_fixed(ES_exo,%qmark%%ES%");
