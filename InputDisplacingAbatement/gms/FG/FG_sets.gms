sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	agg_FG[n]
	out_FG[n]
	sec_FG[n]
	alias_[alias_set,alias_map2]
	in_FG2agg_FG[n,nn]
	in_FG[n]
;


$GDXIN %FG%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load sec_FG
	$load out_FG
	$load in_FG
	$load agg_FG
	$load in_FG2agg_FG
	$load alias_
$GDXIN
$offMulti
