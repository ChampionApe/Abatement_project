
$BLOCK M_ESC
	E_ESC_q[n]$((sector_ESC[n] and not output_ESC[n]))..	q[n] =E= sum(nn$(map_ESC[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]/sum(nnn$(map_ESC[nnn,nn]), mu[nnn,nn]*(p[nnn]/p[nn])**(-sigma[nn])));
	E_ESC_p[n]$((a_ESC[n]))..	p[n] =E= sum(nn$(map_ESC[nn,n]), q[nn]*p[nn])/q[n];
$ENDBLOCK

