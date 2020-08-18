
$BLOCK M_ES
	E_ES_q[n]$((sector_ES[n] and not output_ES[n]))..	q[n] =E= sum(nn$(map_ES[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]/sum(nnn$(map_ES[nnn,nn]), mu[nnn,nn]*(p[nnn]/p[nn])**(-sigma[nn])));
	E_ES_p[n]$((a_ES[n]))..	p[n] =E= sum(nn$(map_ES[nn,n]), q[nn]*p[nn])/q[n];
$ENDBLOCK

