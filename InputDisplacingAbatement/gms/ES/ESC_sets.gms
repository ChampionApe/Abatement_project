sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	in_ESC2agg_ESC[n,nn]
	sec_ESC[n]
	in_ESC[n]
	out_ESC[n]
	alias_[alias_set,alias_map2]
	agg_ESC[n]
;


$GDXIN %ESC%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load agg_ESC
	$load sec_ESC
	$load in_ESC
	$load out_ESC
	$load in_ESC2agg_ESC
	$load alias_
$GDXIN
$offMulti
