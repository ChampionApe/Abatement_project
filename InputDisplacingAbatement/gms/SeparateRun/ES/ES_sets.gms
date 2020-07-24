sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	output_ES[n]
	map_ES[n,nn]
	input_ES[n]
	alias_[alias_set,alias_map2]
	a_ES[n]
	sector_ES[n]
;


$GDXIN %ES%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load a_ES
	$load input_ES
	$load output_ES
	$load sector_ES
	$load alias_
	$load map_ES
$GDXIN
$offMulti
