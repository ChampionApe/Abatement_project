sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	in_ES[n]
	agg_ES[n]
	in_ES2agg_ES[n,nn]
	sec_ES[n]
	out_ES[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %ES%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load in_ES
	$load sec_ES
	$load out_ES
	$load agg_ES
	$load in_ES2agg_ES
	$load alias_
$GDXIN
$offMulti
