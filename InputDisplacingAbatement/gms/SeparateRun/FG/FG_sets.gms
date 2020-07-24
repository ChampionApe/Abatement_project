sets
	alias_set
	n
	alias_map2
;

alias(n,nnn,nn);

sets
	input_FG[n]
	map_FG[n,nn]
	sector_FG[n]
	a_FG[n]
	output_FG[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %FG%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load input_FG
	$load a_FG
	$load output_FG
	$load sector_FG
	$load map_FG
	$load alias_
$GDXIN
$offMulti