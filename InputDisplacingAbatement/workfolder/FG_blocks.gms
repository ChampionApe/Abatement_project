
$BLOCK M_FG
	E_FG_q[n]$((sec_FG[n] and not out_FG[n]))..	q[n] =E= sum(nn$(in_FG2agg_FG[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]);
	E_FG_p[n]$((agg_FG[n]))..	p[n] =E= sum(nn$(in_FG2agg_FG[nn,n]), mu[nn,n] * p[nn]**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK

