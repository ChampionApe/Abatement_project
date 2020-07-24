sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	a_Tbase[n]
	map_Tbase[n,nn]
	output_Tbase[n]
	input_Tbase[n]
	alias_[alias_set,alias_map2]
	sector_Tbase[n]
;


$GDXIN %Tbase%
$onMulti
	$load alias_set
	$load alias_map2
	$load n
	$load a_Tbase
	$load sector_Tbase
	$load output_Tbase
	$load input_Tbase
	$load alias_
	$load map_Tbase
$GDXIN
$offMulti
