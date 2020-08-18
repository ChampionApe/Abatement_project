sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	a_FG[n]
	map_FG[n,nn]
	sector_FG[n]
	input_FG[n]
	alias_[alias_set,alias_map2]
	output_FG[n]
;


$GDXIN %FG%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load input_FG
	$load a_FG
	$load sector_FG
	$load output_FG
	$load map_FG
	$load alias_
$GDXIN
$offMulti
