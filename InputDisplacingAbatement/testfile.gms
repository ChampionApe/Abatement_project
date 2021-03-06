sets
	l2
	l1
;


sets
	loop3[l1,l2]
;


$GDXIN %shock%
$onMulti
$load l2
$load l1
$load loop3
$GDXIN
$offMulti
 parameters
	p3[l1,l2]
	p1[l1]
	p2[l2]
;

$GDXIN %shock%
$onMulti
$load p3
$load p1
$load p2
$offMulti
 parameter
	sol_q[l1, l2, n]
;

 loop( (l1, l2)$(loop3[l1,l2]), 	p.fx[n]$(sameAs(n,"F1")) = p1[l1];
	p.fx[n]$(sameAs(n,"F2")) = p2[l2];


solve FG_ES_ESC_ES_base_T using CNS;
sol_q[l1, l2, n]$(n2nn_agg[n]) = q.l[n];

)
		