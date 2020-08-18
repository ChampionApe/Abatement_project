sets
	alias_map2
	alias_set
	n
;

alias(n,nnn,nn);

sets
	map_ESC[n,nn]
	alias_[alias_set,alias_map2]
	input_ESC[n]
	sector_ESC[n]
	output_ESC[n]
	a_ESC[n]
;


$GDXIN %ESC%
$onMulti
$load alias_map2
$load alias_set
$load n
$load output_ESC
$load input_ESC
$load a_ESC
$load sector_ESC
$load map_ESC
$load alias_
$GDXIN
$offMulti
