
$BLOCK M_FG
	E_FG_q[n]$((sector_FG[n] and not output_FG[n]))..	q[n] =E= sum(nn$(map_FG[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]);
	E_FG_p[n]$((a_FG[n]))..	p[n] =E= sum(nn$(map_FG[nn,n]), mu[nn,n] * p[nn]**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK

