$GROUP ES_base_tech
	sigma[n]$((a_ES_base[n])) ""
	mu[n,nn]$((map_ES_base[n,nn])) ""
;

$GROUP ES_base_exo
	p[n]$((input_ES_base[n])) ""
	q[n]$((output_ES_base[n])) ""
;

$GROUP ES_base_endo
	p[n]$((a_ES_base[n])) ""
	q[n]$((sector_ES_base[n] and not output_ES_base[n])) ""
;

@load_level(ES_base_endo,%qmark%%ES_base%");
@load_fixed(ES_base_exo,%qmark%%ES_base%");
@load_fixed(ES_base_tech,%qmark%%ES_base%");
