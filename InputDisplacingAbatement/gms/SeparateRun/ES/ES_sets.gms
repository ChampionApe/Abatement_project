sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	output_ES[n]
	map_ES[n,nn]
	a_ES[n]
	sector_ES[n]
	input_ES[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %ES%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load input_ES
	$load sector_ES
	$load a_ES
	$load output_ES
	$load map_ES
	$load alias_
$GDXIN
$offMulti
