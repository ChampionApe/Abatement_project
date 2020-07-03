
$BLOCK M_ESC
	E_ESC_q[n]$((sec_ESC[n] and not out_ESC[n]))..	q[n] =E= sum(nn$(in_ESC2agg_ESC[n,nn]), exp(-p[n]/sigma[nn])*q[nn]/sum(nnn$(in_ESC2agg_ESC[nnn,nn]), exp(-p[nnn]/sigma[nn])));
	E_ESC_p[n]$((agg_ESC[n]))..	p[n] =E= sum(nn$(in_ESC2agg_ESC[nn,n]), q[nn]*p[nn])/q[n];
$ENDBLOCK

