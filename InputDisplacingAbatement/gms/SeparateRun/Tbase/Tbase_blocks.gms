
$BLOCK M_Tbase
	E_Tbase_q[n]$((sector_Tbase[n] and not output_Tbase[n]))..	q[n] =E= sum(nn$(map_Tbase[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]);
	E_Tbase_p[n]$((a_Tbase[n]))..	p[n] =E= sum(nn$(map_Tbase[nn,n]), mu[nn,n] * p[nn]**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK

