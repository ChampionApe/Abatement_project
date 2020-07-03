$GROUP Tech_tech
	sigma[n]$((in_agg[n])) ""
	eta_[n]$((out_agg[n])) ""
	mu[n,nn]$((all_map[n,nn])) ""
;

$GROUP Tech_exo
	p[n]$((input[n])) ""
	q[n]$((output[n])) ""
;

$GROUP Tech_endo
	p[n]$((out_endo[n] or in_agg[n])) ""
	q[n]$((in_endo[n] or out_agg[n])) ""
;

@load_level(Tech_endo,%qmark%%Tech%");
@load_fixed(Tech_tech,%qmark%%Tech%");
@load_fixed(Tech_exo,%qmark%%Tech%");
