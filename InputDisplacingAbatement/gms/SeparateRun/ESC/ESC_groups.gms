$GROUP ESC_tech
	sigma[n]$((a_ESC[n])) ""
	mu[n,nn]$((map_ESC[n,nn])) ""
;

$GROUP ESC_exo
	p[n]$((input_ESC[n])) ""
	q[n]$((output_ESC[n])) ""
;

$GROUP ESC_endo
	p[n]$((a_ESC[n])) ""
	q[n]$((sector_ESC[n] and not output_ESC[n])) ""
;

@load_level(ESC_endo,%qmark%%ESC%");
@load_fixed(ESC_tech,%qmark%%ESC%");
@load_fixed(ESC_exo,%qmark%%ESC%");
