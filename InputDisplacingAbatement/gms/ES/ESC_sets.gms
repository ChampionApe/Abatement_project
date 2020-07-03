sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	sec_ESC[n]
	alias_[alias_set,alias_map2]
	agg_ESC[n]
	out_ESC[n]
	in_ESC2agg_ESC[n,nn]
	in_ESC[n]
;


$GDXIN %ESC%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load in_ESC
	$load agg_ESC
	$load sec_ESC
	$load out_ESC
	$load alias_
	$load in_ESC2agg_ESC
$GDXIN
$offMulti
