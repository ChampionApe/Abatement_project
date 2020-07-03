
$BLOCK M_Tech_in
	E_Tech_in_q[n]$(in_endo[n])..	q[n] =E= sum(nn$(in_map[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-sigma[nn])*q[nn]);
	E_Tech_in_p[n]$(in_agg[n])..	p[n] =E= sum(nn$(in_map[nn,n]), mu[nn,n] * p[nn]**(1-sigma[n]))**(1/(1-sigma[n]));
$ENDBLOCK


$BLOCK M_Tech_out
	E_Tech_out_q[n]$(out_endo[n])..	q[n] =E= sum(nn$(out_map[n,nn]), mu[n,nn]*(p[n]/p[nn])**(-eta_[nn])*q[nn]);
	E_Tech_out_p[n]$(out_agg[n])..	p[n] =E= sum(nn$(out_map[nn,n]), mu[nn,n] * p[nn]**(1-eta_[n]))**(1/(1-eta_[n]));
$ENDBLOCK

