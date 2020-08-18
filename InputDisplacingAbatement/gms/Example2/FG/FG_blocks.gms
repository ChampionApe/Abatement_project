
$BLOCK M_FG
	E_FG_q[n]$((sector_FG[n] and not output_FG[n]))..	q[n] =E= sum(nn$(map_FG[n,nn]), mu[n,nn]*(sum(nnn$(q2p[n,nnn]), p[nnn])/p[nn])**(-sigma[nn])*q[nn]);
	E_FG_p_CD[n]$(a_FG[n] and sigma.l[n]=1)..	p[n] =E= prod(nn$(map_FG[nn,n]), sum(nnn$(q2p[nn,nnn]), p[nnn])**(mu[nn,n]));
	E_FG_p[n]$(a_FG[n] and sigma.l[n] <> 1)..	p[n] =E= sum(nn$(map_FG[nn,n]), mu[nn,n] * sum(nnn$(q2p[nn,nnn]), p[nnn])**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK

