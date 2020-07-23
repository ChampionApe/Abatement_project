$GROUP T_tech
	sigma[n]$((in_agg_T[n])) ""
	eta_[n]$((out_agg_T[n])) ""
	mu[n,nn]$((all_map_T[n,nn])) ""
;

$GROUP T_exo
	p[n]$((input_T[n])) ""
	q[n]$((output_T[n])) ""
;

$GROUP T_endo
	p[n]$((out_endo_T[n] or in_agg_T[n])) ""
	q[n]$((in_endo_T[n] or out_agg_T[n])) ""
;

@load_level(T_endo,%qmark%%T%");
@load_fixed(T_tech,%qmark%%T%");
@load_fixed(T_exo,%qmark%%T%");
