##### Collection Of Equations (COE): Collection of popular functions used in gams codes #####

class CES:
	"""
	Collection of CES functions. Note that simply using a negative sigma value implies the CET format here.
	"""
	def equation(self,return_var,equi_name,domains,conditions,p,q,mu,sigma,inputs,in2aggs):
		return f"""{equi_name}{domains}$({conditions})..	{CES.variable(return_var,p,q,mu,sigma,inputs,in2aggs)}"""

	@staticmethod
	def variable(return_var,p,q,mu,sigma,inputs,in2aggs):
		if return_var=='price_index':
			return CES.price(p['base'],p['alias'],mu['alias'],sigma['base'],in2aggs['alias'],inputs['alias'])
		elif return_var=='demand':
			return CES.demand(q['base'],q['alias'],p['base'],p['alias'],mu['base'],sigma['alias'],in2aggs['base'],inputs['alias'])

	@staticmethod
	def demand(q,q_alias,p,p_alias,mu,sigma_alias,in2agg,input_alias):
		return """{q} =E= sum({nn}$({map_}), {mu}*({p}/{p_a})**(-{sigma_a})*{q_a});""".format(
			q	  	= q,
			q_a		= q_alias,
			p 		= p,
			p_a 	= p_alias,
			mu 		= mu,
			sigma_a = sigma_alias,
			map_ 	= in2agg,
			nn		= input_alias)

	@staticmethod
	def price(p,p_alias,mu_alias,sigma,in2agg_alias,input_alias):
		return """{p} =E= sum({nn}$({map_a}), {mu_a} * {p_a}**(1-{sigma}))**(1/(1-{sigma}));""".format(
			p		= p,
			p_a		= p_alias,
			mu_a 	= mu_alias,
			sigma   = sigma,
			nn 		= input_alias,
			map_a	= in2agg_alias
			)

class normalized_CES:
	"""
	Collection of normalized CES functions; Note that simply using a negative sigma value implies the CET format here.
	"""
	def equation(self,return_var,equi_name,domains,conditions,p,q,mu,sigma,inputs,in2aggs):
		return f"""{equi_name}{domains}$({conditions})..	{normalized_CES.variable(return_var,p,q,mu,sigma,inputs,in2aggs)}"""

	@staticmethod
	def variable(return_var,p,q,mu,sigma,inputs,in2aggs):
		if return_var=='price_index':
			return normalized_CES.price(q['base'],q['alias'],p['base'],p['alias'],in2aggs['alias'],inputs['alias'])
		elif return_var=='demand':
			return normalized_CES.demand(q['base'],q['alias'],p['base'],p['alias'],p['alias2'],mu['base'],mu['alias2'],sigma['alias'],in2aggs['base'],in2aggs['alias2'],inputs['alias'],inputs['alias2'])

	@staticmethod
	def demand(q,q_alias,p,p_alias,p_alias2,mu,mu_alias2,sigma_alias,in2agg,in2agg_alias2,input_alias,input_alias2):
		return """{q} =E= sum({nn}$({map_}), {mu}*({p}/{p_a})**(-{sigma_a})*{q_a}/sum({nnn}$({map_a2}), {mu_a2}*({p_a2}/{p_a})**(-{sigma_a})));""".format(
			q		= q,
			q_a		= q_alias,
			p 		= p,
			p_a 	= p_alias,
			p_a2 	= p_alias2,
			mu 		= mu,
			mu_a2	= mu_alias2,
			sigma_a = sigma_alias,
			map_ 	= in2agg,
			map_a2  = in2agg_alias2,
			nn 		= input_alias,
			nnn		= input_alias2
			)
	@staticmethod
	def price(q,q_alias,p,p_alias,in2agg_alias,input_alias):
		return """{p} =E= sum({nn}$({map_a}), {q_a}*{p_a})/{q};""".format(
			q		= q,
			q_a		= q_alias,
			p		= p,
			p_a 	= p_alias,
			map_a 	= in2agg_alias,
			nn 		= input_alias
			)

class MNL:
	"""
	Collection of multinomial-logit-like demand structure. This MNL structure has (-p) as an element.
	Using negative values of sigma implies the appropriate output-split version.
	"""
	def equation(self,return_var,equi_name,domains,conditions,p,q,mu,sigma,inputs,in2aggs):
		return f"""{equi_name}{domains}$({conditions})..	{MNL.variable(return_var,p,q,mu,sigma,inputs,in2aggs)}"""

	@staticmethod
	def variable(return_var,p,q,mu,sigma,inputs,in2aggs):
		if return_var=='price_index':
			return MNL.price(q['base'],q['alias'],p['base'],p['alias'],in2aggs['alias'],inputs['alias'])
		elif return_var=='demand':
			return MNL.demand(q['base'],q['alias'],p['base'],p['alias2'],sigma['alias'],in2aggs['base'],in2aggs['alias2'],inputs['alias'],inputs['alias2'])

	@staticmethod
	def demand(q,q_alias,p,p_alias2,sigma_alias,in2agg,in2agg_alias2,input_alias,input_alias2):
		return """{q} =E= sum({nn}$({map_}), exp(-{p}/{sigma_a})*{q_a}/sum({nnn}$({map_a2}), exp(-{p_a2}/{sigma_a})));""".format(
			q		= q,
			q_a		= q_alias,
			p 		= p,
			p_a2 	= p_alias2,
			sigma_a = sigma_alias,
			map_ 	= in2agg,
			map_a2  = in2agg_alias2,
			nn 		= input_alias,
			nnn		= input_alias2
			)

	@staticmethod
	def price(q,q_alias,p,p_alias,in2agg_alias,input_alias):
		return """{p} =E= sum({nn}$({map_a}), {q_a}*{p_a})/{q};""".format(
			q		= q,
			q_a		= q_alias,
			p		= p,
			p_a 	= p_alias,
			map_a 	= in2agg_alias,
			nn 		= input_alias
			)


