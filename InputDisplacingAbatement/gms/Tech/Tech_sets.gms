sets
	alias_set
	alias_map2
	n
;

alias(n,nn,nnn);

sets
	in_endo[n]
	in_agg[n]
	alias_[alias_set,alias_map2]
	out_map[n,nn]
	input[n]
	in_map[n,nn]
	out_agg[n]
	all_agg[n]
	all_map[n,nn]
	output[n]
	out_endo[n]
;


$GDXIN %Tech%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load in_endo
	$load in_agg
	$load input
	$load out_agg
	$load all_agg
	$load output
	$load out_endo
	$load out_map
	$load alias_
	$load in_map
	$load all_map
$GDXIN
$offMulti
