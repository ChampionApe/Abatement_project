$GROUP T_tech
	sigma[n]$((i_agg_T[n])) ""
	eta[n]$((o_agg_T[n])) ""
	mu[n,nn]$((a_map_T[n,nn])) ""
;

$GROUP T_exo
	p[n]$((input_T[n])) ""
	q[n]$((output_T[n])) ""
;

$GROUP T_endo
	p[n]$((o_endo_T[n] or i_agg_T[n])) ""
	q[n]$((i_endo_T[n] or o_agg_T[n])) ""
;

@load_level(T_endo,%qmark%%T%");
@load_fixed(T_tech,%qmark%%T%");
@load_fixed(T_exo,%qmark%%T%");
