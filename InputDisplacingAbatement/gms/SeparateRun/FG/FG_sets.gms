sets
	n
	alias_set
	alias_map2
;

alias(n,nn,nnn);

sets
	sector_FG[n]
	output_FG[n]
	map_FG[n,nn]
	a_FG[n]
	alias_[alias_set,alias_map2]
	input_FG[n]
;


$GDXIN %FG%
$onMulti
	$load n
	$load alias_set
	$load alias_map2
	$load input_FG
	$load a_FG
	$load sector_FG
	$load output_FG
	$load alias_
	$load map_FG
$GDXIN
$offMulti
