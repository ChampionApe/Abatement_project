sets
	alias_set
	n
	alias_map2
;

alias(n,nn,nnn);

sets
	sec_Tbase[n]
	in_Tbase2agg_Tbase[n,nn]
	agg_Tbase[n]
	out_Tbase[n]
	alias_[alias_set,alias_map2]
	in_Tbase[n]
;


$GDXIN %Tbase%
$onMulti
	$load alias_set
	$load n
	$load alias_map2
	$load in_Tbase
	$load sec_Tbase
	$load out_Tbase
	$load agg_Tbase
	$load in_Tbase2agg_Tbase
	$load alias_
$GDXIN
$offMulti
