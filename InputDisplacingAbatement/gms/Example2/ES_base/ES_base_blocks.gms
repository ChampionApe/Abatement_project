
$BLOCK M_ES_base
	E_ES_base_q[n]$((sector_ES_base[n] and not output_ES_base[n]))..	q[n] =E= sum(nn$(map_ES_base[n,nn]), mu[n,nn]*(sum(nnn$(q2p[n,nnn]), p[nnn])/p[nn])**(-sigma[nn])*q[nn]);
	E_ES_base_p_CD[n]$(a_ES_base[n] and sigma.l[n]=1)..	p[n] =E= prod(nn$(map_ES_base[nn,n]), sum(nnn$(q2p[nn,nnn]), p[nnn])**(mu[nn,n]));
	E_ES_base_p[n]$(a_ES_base[n] and sigma.l[n] <> 1)..	p[n] =E= sum(nn$(map_ES_base[nn,n]), mu[nn,n] * sum(nnn$(q2p[nn,nnn]), p[nnn])**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK

