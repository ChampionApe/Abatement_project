sets
	alias_set
	n
	alias_map2
;

alias(n,nnn,nn);

sets
	i_map_T[n,nn]
	o_endo_T[n]
	i_agg_T[n]
	output_T[n]
	input_T[n]
	o_map_T[n,nn]
	i_endo_T[n]
	a_map_T[n,nn]
	o_agg_T[n]
	a_agg_T[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %T%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load o_endo_T
	$load output_T
	$load input_T
	$load i_endo_T
	$load o_agg_T
	$load a_agg_T
	$load i_agg_T
	$load i_map_T
	$load a_map_T
	$load o_map_T
	$load alias_
$GDXIN
$offMulti
