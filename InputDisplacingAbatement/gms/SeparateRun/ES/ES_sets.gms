sets
	n
	alias_set
	alias_map2
;

alias(n,nn,nnn);

sets
	a_ES[n]
	sector_ES[n]
	map_ES[n,nn]
	output_ES[n]
	input_ES[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %ES%
$onMulti
	$load n
	$load alias_set
	$load alias_map2
	$load output_ES
	$load a_ES
	$load input_ES
	$load sector_ES
	$load alias_
	$load map_ES
$GDXIN
$offMulti
