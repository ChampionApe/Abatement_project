
$BLOCK M_T_in
	E_T_in_q[n]$(i_endo_T[n])..	q[n] =E= sum(nn$(i_map_T[n,nn]), mu[n,nn]*(sum(nnn$(q2p[n,nnn]), p[nnn])/p[nn])**(-sigma[nn])*q[nn]);
	E_T_in_p_CD[n]$(i_agg_T[n] and sigma.l[n]=1)..	p[n] =E= prod(nn$(i_map_T[nn,n]), sum(nnn$(q2p[nn,nnn]), p[nnn])**(mu[nn,n]));
	E_T_in_p[n]$(i_agg_T[n] and sigma.l[n] <> 1)..	p[n] =E= sum(nn$(i_map_T[nn,n]), mu[nn,n] * sum(nnn$(q2p[nn,nnn]), p[nnn])**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK


$BLOCK M_T_out
	E_T_out_q[n]$(o_endo_T[n])..	q[n] =E= sum(nn$(o_map_T[n,nn]), exp(-p[n]/eta[nn])*q[nn]/sum(nnn$(o_map_T[nnn,nn]), exp(-p[nnn]/eta[nn])));
	E_T_out_p[n]$(o_agg_T[n])..	p[n] =E= sum(nn$(o_map_T[nn,n]), q[nn]*p[nn])/q[n];
$ENDBLOCK


$BLOCK M_T_agg
	E_T_agg[n]$((n2nn_agg[n]))..	q[n] =E= sum(nn$(n2nn[nn,n]), q[nn]);
$ENDBLOCK

