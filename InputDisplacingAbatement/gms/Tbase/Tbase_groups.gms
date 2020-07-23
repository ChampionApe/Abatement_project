$GROUP Tbase_tech
	sigma[n]$((agg_Tbase[n])) ""
	mu[n,nn]$((in_Tbase2agg_Tbase[n,nn])) ""
;

$GROUP Tbase_exo
	p[n]$((in_Tbase[n])) ""
	q[n]$((out_Tbase[n])) ""
;

$GROUP Tbase_endo
	p[n]$((agg_Tbase[n])) ""
	q[n]$((sec_Tbase[n] and not out_Tbase[n])) ""
;

@load_level(Tbase_endo,%qmark%%Tbase%");
@load_fixed(Tbase_exo,%qmark%%Tbase%");
@load_fixed(Tbase_tech,%qmark%%Tbase%");
