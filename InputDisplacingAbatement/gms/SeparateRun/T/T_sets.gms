sets
	n
	alias_set
	alias_map2
;

alias(n,nn,nnn);

sets
	a_map_T[n,nn]
	o_map_T[n,nn]
	i_agg_T[n]
	o_endo_T[n]
	input_T[n]
	i_endo_T[n]
	i_map_T[n,nn]
	o_agg_T[n]
	alias_[alias_set,alias_map2]
	output_T[n]
	a_agg_T[n]
;


$GDXIN %T%
$onMulti
	$load n
	$load alias_set
	$load alias_map2
	$load i_agg_T
	$load o_endo_T
	$load input_T
	$load i_endo_T
	$load o_agg_T
	$load output_T
	$load a_agg_T
	$load alias_
	$load a_map_T
	$load i_map_T
	$load o_map_T
$GDXIN
$offMulti
