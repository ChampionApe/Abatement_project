sets
	alias_map2
	alias_set
	n
;

alias(n,nnn,nn);

sets
	sector_FG[n]
	p_all[n]
	alias_[alias_set,alias_map2]
	input_FG[n]
	q2p[n,nn]
	q_all[n]
	n2nn_agg[n]
	map_FG[n,nn]
	n2nn[n,nn]
	a_FG[n]
	output_FG[n]
;


$GDXIN %FG%
$onMulti
$load alias_map2
$load alias_set
$load n
$load sector_FG
$load p_all
$load q_all
$load input_FG
$load n2nn_agg
$load a_FG
$load output_FG
$load map_FG
$load n2nn
$load alias_
$load q2p
$GDXIN
$offMulti
