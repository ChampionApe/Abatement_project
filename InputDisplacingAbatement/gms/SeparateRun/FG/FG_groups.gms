$GROUP FG_tech
	sigma[n]$((a_FG[n])) ""
	mu[n,nn]$((map_FG[n,nn])) ""
;

$GROUP FG_exo
	p[n]$((input_FG[n])) ""
	q[n]$((output_FG[n])) ""
;

$GROUP FG_endo
	p[n]$((a_FG[n])) ""
	q[n]$((sector_FG[n] and not output_FG[n])) ""
;

@load_level(FG_endo,%qmark%%FG%");
@load_fixed(FG_tech,%qmark%%FG%");
@load_fixed(FG_exo,%qmark%%FG%");
