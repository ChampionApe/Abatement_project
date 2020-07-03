sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	out_ES[n]
	in_ES[n]
	sec_ES[n]
	alias_[alias_set,alias_map2]
	agg_ES[n]
	in_ES2agg_ES[n,nn]
;


$GDXIN %ES%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load sec_ES
	$load in_ES
	$load out_ES
	$load agg_ES
	$load alias_
	$load in_ES2agg_ES
$GDXIN
$offMulti
