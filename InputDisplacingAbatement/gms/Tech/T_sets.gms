sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	output_T[n]
	in_map_T[n,nn]
	input_T[n]
	all_map_T[n,nn]
	in_agg_T[n]
	in_endo_T[n]
	out_agg_T[n]
	out_map_T[n,nn]
	alias_[alias_set,alias_map2]
	all_agg_T[n]
	out_endo_T[n]
;


$GDXIN %T%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load output_T
	$load input_T
	$load in_agg_T
	$load in_endo_T
	$load out_agg_T
	$load all_agg_T
	$load out_endo_T
	$load in_map_T
	$load out_map_T
	$load all_map_T
	$load alias_
$GDXIN
$offMulti
