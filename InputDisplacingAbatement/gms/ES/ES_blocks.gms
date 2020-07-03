
$BLOCK M_ES
	E_ES_q[n]$((sec_ES[n] and not out_ES[n]))..	q[n] =E= sum(nn$(in_ES2agg_ES[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]/sum(nnn$(in_ES2agg_ES[nnn,nn]), mu[nnn,nn]*(p[nnn]/p[nn])**(-sigma[nn])));
	E_ES_p[n]$((agg_ES[n]))..	p[n] =E= sum(nn$(in_ES2agg_ES[nn,n]), q[nn]*p[nn])/q[n];
$ENDBLOCK

