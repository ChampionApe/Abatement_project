sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	a_FG[n]
	input_FG[n]
	output_FG[n]
	alias_[alias_set,alias_map2]
	map_FG[n,nn]
	sector_FG[n]
;


$GDXIN %FG%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load sector_FG
	$load output_FG
	$load input_FG
	$load a_FG
	$load alias_
	$load map_FG
$GDXIN
$offMulti
