sets
	alias_map2
	alias_set
	n
;

alias(n,nnn,nn);

sets
	q2p[n,nn]
	p_all[n]
	alias_[alias_set,alias_map2]
	q_all[n]
	map_ES_base[n,nn]
	input_ES_base[n]
	a_ES_base[n]
	n2nn_agg[n]
	output_ES_base[n]
	n2nn[n,nn]
	sector_ES_base[n]
;


$GDXIN %ES_base%
$onMulti
$load alias_map2
$load alias_set
$load n
$load q_all
$load p_all
$load input_ES_base
$load a_ES_base
$load n2nn_agg
$load output_ES_base
$load sector_ES_base
$load map_ES_base
$load n2nn
$load alias_
$load q2p
$GDXIN
$offMulti
