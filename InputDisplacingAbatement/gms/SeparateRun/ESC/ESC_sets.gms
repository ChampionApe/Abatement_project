sets
	alias_set
	n
	alias_map2
;

alias(n,nnn,nn);

sets
	sector_ESC[n]
	a_ESC[n]
	input_ESC[n]
	map_ESC[n,nn]
	output_ESC[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %ESC%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load input_ESC
	$load sector_ESC
	$load output_ESC
	$load a_ESC
	$load map_ESC
	$load alias_
$GDXIN
$offMulti
