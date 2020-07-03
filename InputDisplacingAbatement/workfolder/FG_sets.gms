sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	sec_FG[n]
	agg_FG[n]
	alias_[alias_set,alias_map2]
	in_FG2agg_FG[n,nn]
	in_FG[n]
	out_FG[n]
;


$GDXIN %FG%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load sec_FG
	$load agg_FG
	$load out_FG
	$load in_FG
	$load alias_
	$load in_FG2agg_FG
$GDXIN
$offMulti
