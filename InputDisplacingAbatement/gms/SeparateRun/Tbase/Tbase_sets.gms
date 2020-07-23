sets
	n
	alias_set
	alias_map2
;

alias(n,nn,nnn);

sets
	sector_Tbase[n]
	input_Tbase[n]
	map_Tbase[n,nn]
	a_Tbase[n]
	output_Tbase[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %Tbase%
$onMulti
	$load n
	$load alias_set
	$load alias_map2
	$load a_Tbase
	$load sector_Tbase
	$load input_Tbase
	$load output_Tbase
	$load alias_
	$load map_Tbase
$GDXIN
$offMulti
