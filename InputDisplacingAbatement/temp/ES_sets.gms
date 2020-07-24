sets
	alias_set
	alias_map2
	n
;

alias(n,nn,nnn);

sets
	input_ES[n]
	sector_ES[n]
	map_ES[n,nn]
	output_ES[n]
	alias_[alias_set,alias_map2]
	a_ES[n]
;


$GDXIN %ES%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load sector_ES
	$load output_ES
	$load a_ES
	$load input_ES
	$load alias_
	$load map_ES
$GDXIN
$offMulti
