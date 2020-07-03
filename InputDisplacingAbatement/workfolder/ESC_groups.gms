$GROUP ESC_tech
	sigma[n]$((agg_ESC[n])) ""
	mu[n,nn]$((in_ESC2agg_ESC[n,nn])) ""
;

$GROUP ESC_exo
	p[n]$((in_ESC[n])) ""
	q[n]$((out_ESC[n])) ""
;

$GROUP ESC_endo
	p[n]$((agg_ESC[n])) ""
	q[n]$((sec_ESC[n] and not out_ESC[n])) ""
;

@load_level(ESC_endo,%qmark%%ESC%");
@load_fixed(ESC_exo,%qmark%%ESC%");
@load_fixed(ESC_tech,%qmark%%ESC%");
