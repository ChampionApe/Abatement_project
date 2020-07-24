sets
	alias_set
	n
	alias_map2
;

alias(n,nnn,nn);

sets
	input_Tbase[n]
	a_Tbase[n]
	output_Tbase[n]
	map_Tbase[n,nn]
	sector_Tbase[n]
	alias_[alias_set,alias_map2]
;


$GDXIN %Tbase%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load a_Tbase
	$load output_Tbase
	$load input_Tbase
	$load sector_Tbase
	$load map_Tbase
	$load alias_
$GDXIN
$offMulti
