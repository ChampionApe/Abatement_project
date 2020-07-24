$GROUP Tbase_tech
	sigma[n]$((a_Tbase[n])) ""
	mu[n,nn]$((map_Tbase[n,nn])) ""
;

$GROUP Tbase_exo
	p[n]$((input_Tbase[n])) ""
	q[n]$((output_Tbase[n])) ""
;

$GROUP Tbase_endo
	p[n]$((a_Tbase[n])) ""
	q[n]$((sector_Tbase[n] and not output_Tbase[n])) ""
;

@load_level(Tbase_endo,%qmark%%Tbase%");
@load_fixed(Tbase_exo,%qmark%%Tbase%");
@load_fixed(Tbase_tech,%qmark%%Tbase%");
