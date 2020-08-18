sets
	alias_map2
	alias_set
	n
;

alias(n,nn,nnn);

sets
	output_Tbase[n]
	a_Tbase[n]
	input_Tbase[n]
	map_Tbase[n,nn]
	sector_Tbase[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %Tbase%
$onMulti
	$load alias_map2
	$load alias_set
	$load n
	$load sector_Tbase
	$load input_Tbase
	$load output_Tbase
	$load a_Tbase
	$load map_Tbase
	$load alias_
$GDXIN
$offMulti
