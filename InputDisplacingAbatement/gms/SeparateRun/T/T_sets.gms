sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	output_T[n]
	o_agg_T[n]
	o_endo_T[n]
	a_map_T[n,nn]
	input_T[n]
	i_agg_T[n]
	alias_[alias_set,alias_map2]
	i_endo_T[n]
	i_map_T[n,nn]
	o_map_T[n,nn]
	a_agg_T[n]
;


$GDXIN %T%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load output_T
	$load o_agg_T
	$load o_endo_T
	$load i_agg_T
	$load input_T
	$load i_endo_T
	$load a_agg_T
	$load alias_
	$load i_map_T
	$load a_map_T
	$load o_map_T
$GDXIN
$offMulti
