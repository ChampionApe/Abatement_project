sets
	alias_map2
	alias_set
	n
;

alias(n,nnn,nn,nnnn);

sets
	o_map_T[n,nn]
	q2p[n,nn]
	q_all[n]
	alias_[alias_set,alias_map2]
	i_agg_T[n]
	p_all[n]
	output_T[n]
	i_endo_T[n]
	n2nn_agg[n]
	i_map_T[n,nn]
	n2nn[n,nn]
	input_T[n]
	o_endo_T[n]
	a_map_T[n,nn]
	o_agg_T[n]
;


$GDXIN %T%
$onMulti
$load alias_map2
$load alias_set
$load n
$load q_all
$load p_all
$load i_agg_T
$load output_T
$load i_endo_T
$load n2nn_agg
$load input_T
$load o_endo_T
$load o_agg_T
$load o_map_T
$load q2p
$load alias_
$load i_map_T
$load n2nn
$load a_map_T
$GDXIN
$offMulti
