sets
	alias_set
	n
	alias_map2
;

alias(n,nnn,nn);

sets
	input_ES[n]
	a_ES[n]
	output_ES[n]
	map_ES[n,nn]
	sector_ES[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %ES%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load input_ES
	$load output_ES
	$load a_ES
	$load sector_ES
	$load map_ES
	$load alias_
$GDXIN
$offMulti