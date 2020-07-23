
$BLOCK M_Tbase
	E_Tbase_q[n]$((sec_Tbase[n] and not out_Tbase[n]))..	q[n] =E= sum(nn$(in_Tbase2agg_Tbase[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]);
	E_Tbase_p[n]$((agg_Tbase[n]))..	p[n] =E= sum(nn$(in_Tbase2agg_Tbase[nn,n]), mu[nn,n] * p[nn]**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK

