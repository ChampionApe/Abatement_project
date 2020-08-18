sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	i_agg_T[n]
	o_agg_T[n]
	i_endo_T[n]
	input_T[n]
	o_map_T[n,nn]
	a_agg_T[n]
	output_T[n]
	a_map_T[n,nn]
	o_endo_T[n]
	alias_[alias_set,alias_map2]
	i_map_T[n,nn]
;


$GDXIN %T%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load i_agg_T
	$load o_agg_T
	$load i_endo_T
	$load input_T
	$load a_agg_T
	$load output_T
	$load o_endo_T
	$load alias_
	$load a_map_T
	$load i_map_T
	$load o_map_T
$GDXIN
$offMulti
