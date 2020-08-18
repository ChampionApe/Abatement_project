sets
	alias_map2
	alias_set
	n
;

alias(n,nnn,nn);

sets
	output_ES[n]
	map_ES[n,nn]
	alias_[alias_set,alias_map2]
	a_ES[n]
	sector_ES[n]
	input_ES[n]
;


$GDXIN %ES%
$onMulti
$load alias_map2
$load alias_set
$load n
$load output_ES
$load a_ES
$load input_ES
$load sector_ES
$load map_ES
$load alias_
$GDXIN
$offMulti
