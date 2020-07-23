sets
	n
	alias_set
	alias_map2
;

alias(n,nn,nnn);

sets
	map_ESC[n,nn]
	sector_ESC[n]
	output_ESC[n]
	a_ESC[n]
	alias_[alias_set,alias_map2]
	input_ESC[n]
;


$GDXIN %ESC%
$onMulti
	$load n
	$load alias_set
	$load alias_map2
	$load sector_ESC
	$load output_ESC
	$load input_ESC
	$load a_ESC
	$load alias_
	$load map_ESC
$GDXIN
$offMulti
