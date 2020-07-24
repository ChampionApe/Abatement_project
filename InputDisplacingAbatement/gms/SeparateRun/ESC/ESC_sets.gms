sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	a_ESC[n]
	sector_ESC[n]
	alias_[alias_set,alias_map2]
	map_ESC[n,nn]
	output_ESC[n]
	input_ESC[n]
;


$GDXIN %ESC%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load a_ESC
	$load output_ESC
	$load sector_ESC
	$load input_ESC
	$load alias_
	$load map_ESC
$GDXIN
$offMulti
