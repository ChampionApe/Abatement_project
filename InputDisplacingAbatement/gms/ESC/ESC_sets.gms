sets
	n
	alias_map2
	alias_set
;

alias(n,nnn,nn);

sets
	alias_[alias_set,alias_map2]
	in_ESC2agg_ESC[n,nn]
	in_ESC[n]
	agg_ESC[n]
	out_ESC[n]
	sec_ESC[n]
;


$GDXIN %ESC%
$onMulti
	$load n
	$load alias_map2
	$load alias_set
	$load sec_ESC
	$load agg_ESC
	$load in_ESC
	$load out_ESC
	$load alias_
	$load in_ESC2agg_ESC
$GDXIN
$offMulti
