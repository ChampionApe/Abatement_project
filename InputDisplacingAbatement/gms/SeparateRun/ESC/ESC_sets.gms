sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	a_ESC[n]
	input_ESC[n]
	sector_ESC[n]
	map_ESC[n,nn]
	alias_[alias_set,alias_map2]
	output_ESC[n]
;


$GDXIN %ESC%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load input_ESC
	$load a_ESC
	$load output_ESC
	$load sector_ESC
	$load alias_
	$load map_ESC
$GDXIN
$offMulti
