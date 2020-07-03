sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	all_agg[n]
	all_map[n,nn]
	out_agg[n]
	out_map[n,nn]
	output[n]
	alias_[alias_set,alias_map2]
	in_endo[n]
	in_map[n,nn]
	in_agg[n]
	out_endo[n]
	input[n]
;


$GDXIN %Tech%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load all_agg
	$load out_agg
	$load output
	$load in_endo
	$load in_agg
	$load out_endo
	$load input
	$load alias_
	$load all_map
	$load out_map
	$load in_map
$GDXIN
$offMulti
