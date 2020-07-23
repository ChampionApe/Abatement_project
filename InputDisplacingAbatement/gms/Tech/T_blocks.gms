
$BLOCK M_T_in
	E_T_in_q[n]$(in_endo_T[n])..	q[n] =E= sum(nn$(in_map_T[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]);
	E_T_in_p[n]$(in_agg_T[n])..	p[n] =E= sum(nn$(in_map_T[nn,n]), mu[nn,n] * p[nn]**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK


$BLOCK M_T_out
	E_T_out_q[n]$(out_endo_T[n])..	q[n] =E= sum(nn$(out_map_T[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-eta_[nn])*q[nn]);
	E_T_out_p[n]$(out_agg_T[n])..	p[n] =E= sum(nn$(out_map_T[nn,n]), mu[nn,n] * p[nn]**(1-eta_[n]))**(1/(1-eta_[n]));
$ENDBLOCK

