from gams import *
import pandas as pd
from dreamtools.gams_pandas import *
from dreamtools.gamY import Precompiler
import DataBase
import COE
from DB2Gams import *


class abatement_model_with_CET(gams_model_py):
	"""
	Includes an arbitrary combination of input/output nests (e.g. CES-input/CET-outputsplit)
	"""
	def __init__(self,tree,gams_settings=None):
		self.tree=tree
		self.block_components = {}
		super().__init__(self.tree.database,gsettings=gams_settings,blocks_text=None,functions=None,groups={},exceptions=[],exceptions_load=[],components = {},export_files = None)		

	def apply_type(self,type_):
		return eval(f"COE.{type_}()")

	def run_abatement_model(self,repo=os.getcwd(),type_in='CES',type_out='CES',export_settings=False):
		self.define_groups()
		self.define_blocks_in(type_=type_in)
		self.define_blocks_out(type_=type_out)
		self.agg_block_components()
		self.run_default(repo,export_settings=export_settings)

	def agg_block_components(self):
		self.model.blocks = list(self.block_components.keys())
		self.blocks = ""
		for component in self.block_components:
			self.blocks += self.block_components[component]

	# Define groups: 
	def define_groups(self,p='p',q='q',mu='mu',sigma='sigma',eta_='eta_'):
		self.p = p
		self.q = q
		self.mu = mu
		self.sigma = sigma
		self.eta_ = eta_
		if p not in self.database:
			self.database[p] = pd.Series(1,index=self.database[self.tree.setname],name=p)
		if q not in self.database:
			self.database[q] = pd.Series(1,index=self.database[self.tree.setname],name=q)
		if mu not in self.database:
			self.database[mu] = pd.Series(0.5,index=self.database[self.tree.all_map],name=mu)
		if sigma not in self.database:
			self.database[sigma] = pd.Series(0.5, index = self.database[self.tree.in_agg],name=sigma)
		if eta_ not in self.database:
			self.database[eta_] = pd.Series(-0.5, index = self.database[self.tree.out_agg], name=eta_)
		self.group_tech = {sigma: {'conditions': self.database.get(self.tree.in_agg).to_str},
						   eta_ : {'conditions': self.database.get(self.tree.out_agg).to_str},
					       mu	: {'conditions': self.database.get(self.tree.all_map).to_str}}
		self.group_exo = {p: {'conditions': self.database.get(self.tree.inpname).to_str},
						  q: {'conditions': self.database.get(self.tree.outname).to_str}}
		self.group_endo= {p: {'conditions': self.database.get(self.tree.out_endo).to_str+' or '+self.database.get(self.tree.in_agg).to_str},
						  q: {'conditions': self.database.get(self.tree.in_endo).to_str +' or '+self.database.get(self.tree.out_agg).to_str}}
		self.add_group_to_groups(self.group_tech,self.model.name+'_tech')
		self.add_group_to_groups(self.group_exo ,self.model.name+'_exo')
		self.add_group_to_groups(self.group_endo,self.model.name+'_endo')
		self.model.g_endo = [self.model.name+'_endo']
		self.model.g_exo = [self.model.name+'_tech', self.model.name+'_exo']
		n2nn  = {self.tree.setname: self.tree.alias}
		n2nnn = {self.tree.setname: self.tree.alias2}
		nn2n  = {self.tree.alias  : self.tree.setname}
		self.write_vars = { 'q': {'base'  : self.database.get(self.q).to_str,
								  'alias' : self.database.get(self.q,alias_domains=n2nn).to_str,
								  'alias2': self.database.get(self.q,alias_domains=n2nnn).to_str},
							'p': {'base'  : self.database.get(self.p).to_str,
								  'alias' : self.database.get(self.p,alias_domains=n2nn).to_str,
								  'alias2': self.database.get(self.p,alias_domains=n2nnn).to_str},
							'mu':{'base'  : self.database.get(self.mu).to_str,
								  'alias' : self.database.get(self.mu,alias_domains={**n2nn,**nn2n}).to_str,
								  'alias2': self.database.get(self.mu,alias_domains=n2nnn).to_str},
							'sigma':{'base'  : self.database.get(self.sigma).to_str,
									 'alias' : self.database.get(self.sigma,alias_domains=n2nn).to_str,
									 'alias2': self.database.get(self.sigma,alias_domains=n2nnn).to_str},
							'eta' : {'base'  : self.database.get(self.eta_).to_str,
									 'alias' : self.database.get(self.eta_,alias_domains=n2nn).to_str,
									 'alias2': self.database.get(self.eta_,alias_domains=n2nnn).to_str},
							'inputs': { 'base'  : self.tree.setname,
										'alias' : self.tree.alias,
										'alias2': self.tree.alias2},
							'in2aggs_in': {'base'  : self.database.get(self.tree.in_map).to_str,
										   'alias' : self.database.get(self.tree.in_map,alias_domains={**n2nn,**nn2n}).to_str,
										   'alias2': self.database.get(self.tree.in_map,alias_domains=n2nnn).to_str},
							'in2aggs_out':{'base'  : self.database.get(self.tree.out_map).to_str,
										   'alias' : self.database.get(self.tree.out_map,alias_domains={**n2nn,**nn2n}).to_str,
										   'alias2': self.database.get(self.tree.out_map,alias_domains=n2nnn).to_str}}

	def define_blocks_in(self,type_):
		"""
		Equation blocks for CES-input-like part of model:
		"""
		functype = self.apply_type(type_)
		self.block_components['M_'+self.model.name+'_in'] = """
$BLOCK M_{mname}_in
	{demand_equation}
	{price_equation}
$ENDBLOCK

""".format(	mname = self.model.name,
			demand_equation = functype.equation('demand',f"E_{self.model.name}_in_q",
														  self.database.get(self.q).to_string('dom'),
														  self.database.get(self.tree.in_endo).to_str,
														  self.write_vars['p'],self.write_vars['q'],self.write_vars['mu'],
														  self.write_vars['sigma'],self.write_vars['inputs'],self.write_vars['in2aggs_in']),
			price_equation  = functype.equation('price_index',f"E_{self.model.name}_in_p",
														  self.database.get(self.p).to_string('dom'),
														  self.database.get(self.tree.in_agg).to_str,
														  self.write_vars['p'],self.write_vars['q'],self.write_vars['mu'],
														  self.write_vars['sigma'],self.write_vars['inputs'],self.write_vars['in2aggs_in']))

	def define_blocks_out(self,type_):
		"""
		Equation blocks for CET-output-split-like part of model:
		"""
		functype = self.apply_type(type_)
		self.block_components['M_'+self.model.name+'_out'] = """
$BLOCK M_{mname}_out
	{demand_equation}
	{price_equation}
$ENDBLOCK

""".format(	mname = self.model.name,
			demand_equation = functype.equation('demand',f"E_{self.model.name}_out_q",
														  self.database.get(self.q).to_string('dom'),
														  self.database.get(self.tree.out_endo).to_str,
														  self.write_vars['p'],self.write_vars['q'],self.write_vars['mu'],
														  self.write_vars['eta'],self.write_vars['inputs'],self.write_vars['in2aggs_out']),
			price_equation  = functype.equation('price_index',f"E_{self.model.name}_out_p",
														  self.database.get(self.p).to_string('dom'),
														  self.database.get(self.tree.out_agg).to_str,
														  self.write_vars['p'],self.write_vars['q'],self.write_vars['mu'],
														  self.write_vars['eta'],self.write_vars['inputs'],self.write_vars['in2aggs_out']))


class abatement_model(gams_model_py):
	def __init__(self,tree,gams_settings=None):
		self.tree = tree
		super().__init__(self.tree.database,gsettings=gams_settings, blocks_text = None, functions = None, groups = {}, exceptions = [], exceptions_load = [], components = {}, export_files = None)

	def apply_type(self,type_):
		return eval(f"COE.{type_}()")

	def run_abatement_model(self,repo=os.getcwd(),type_='CES',export_settings=False):
		self.define_groups()
		self.define_blocks(type_=type_)
		self.run_default(repo,export_settings=export_settings)

	def define_groups(self,p='p',q='q',mu='mu',sigma='sigma'):
		self.p = p
		self.q = q
		self.mu = mu
		self.sigma = sigma
		if p not in self.database:
			self.database[p] = pd.Series(1,index=self.database[self.tree.setname],name=p)
		if q not in self.database:
			self.database[q] = pd.Series(1,index=self.database[self.tree.setname],name=q)
		if mu not in self.database:
			self.database[mu] = pd.Series(0.5,index=self.database[self.tree.mapname],name=mu)
		if sigma not in self.database:
			self.database[sigma] = pd.Series(0.5, index = self.database[self.tree.aggname],name=sigma)
		self.group_tech = {sigma: {'conditions': self.database.get(self.tree.aggname).to_str},
					       mu	: {'conditions': self.database.get(self.tree.mapname).to_str}}
		self.group_exo = {p: {'conditions': self.database.get(self.tree.inpname).to_str},
						  q: {'conditions': self.database.get(self.tree.outname).to_str}}
		self.group_endo= {p: {'conditions': self.database.get(self.tree.aggname).to_str},
						  q: {'conditions': self.database.get(self.tree.sector).to_str+' and not '+self.database.get(self.tree.outname).to_str}}
		self.add_group_to_groups(self.group_tech,self.model.name+'_tech')
		self.add_group_to_groups(self.group_exo ,self.model.name+'_exo')
		self.add_group_to_groups(self.group_endo,self.model.name+'_endo')
		self.model.g_endo = [self.model.name+'_endo']
		self.model.g_exo = [self.model.name+'_tech', self.model.name+'_exo']
		# Arrange variables in types, with alias' etc. that are used to write equations:
		n2nn  = {self.tree.setname: self.tree.alias}
		n2nnn = {self.tree.setname: self.tree.alias2}
		nn2n  = {self.tree.alias  : self.tree.setname}
		self.write_vars = { 'q': {'base'  : self.database.get(self.q).to_str,
								  'alias' : self.database.get(self.q,alias_domains=n2nn).to_str,
								  'alias2': self.database.get(self.q,alias_domains=n2nnn).to_str},
							'p': {'base'  : self.database.get(self.p).to_str,
								  'alias' : self.database.get(self.p,alias_domains=n2nn).to_str,
								  'alias2': self.database.get(self.p,alias_domains=n2nnn).to_str},
							'mu':{'base'  : self.database.get(self.mu).to_str,
								  'alias' : self.database.get(self.mu,alias_domains={**n2nn,**nn2n}).to_str,
								  'alias2': self.database.get(self.mu,alias_domains=n2nnn).to_str},
							'sigma':{'base'  : self.database.get(self.sigma).to_str,
									 'alias' : self.database.get(self.sigma,alias_domains=n2nn).to_str,
									 'alias2': self.database.get(self.sigma,alias_domains=n2nnn).to_str},
							'inputs': { 'base'  : self.tree.setname,
										'alias' : self.tree.alias,
										'alias2': self.tree.alias2},
							'in2aggs': {'base'  : self.database.get(self.tree.mapname).to_str,
										'alias' : self.database.get(self.tree.mapname,alias_domains={**n2nn,**nn2n}).to_str,
										'alias2': self.database.get(self.tree.mapname,alias_domains=n2nnn).to_str}
							}

	def define_blocks(self,type_):
		functype = self.apply_type(type_)
		self.blocks = """
$BLOCK M_{mname}
	{demand_equation}
	{price_equation}
$ENDBLOCK

""".format(	mname = self.model.name,
			demand_equation = functype.equation('demand',f"E_{self.model.name}_q",
														  self.groups[self.model.name+'_endo'][self.q]['domains'],
														  self.groups[self.model.name+'_endo'][self.q]['conditions'],
														  self.write_vars['p'],self.write_vars['q'],self.write_vars['mu'],
														  self.write_vars['sigma'],self.write_vars['inputs'],self.write_vars['in2aggs']),
			price_equation  = functype.equation('price_index',f"E_{self.model.name}_p",
														  self.groups[self.model.name+'_endo'][self.p]['domains'],
														  self.groups[self.model.name+'_endo'][self.p]['conditions'],
														  self.write_vars['p'],self.write_vars['q'],self.write_vars['mu'],
														  self.write_vars['sigma'],self.write_vars['inputs'],self.write_vars['in2aggs']))
		self.model.blocks = ['M_'+self.model.name]

class nesting_tree_with_CET:
	"""
	Includes CET and CES in the nesting structure. 
	"""
	def __init__(self,name="",tree=None,**kwargs):
		self.name=name
		self.tree=tree
		self.setname = 'n'
		self.alias = 'nn'
		self.alias2 = 'nnn'
		self.in_map = 'in_map'
		self.out_map = 'out_map'
		self.all_map = 'all_map'
		self.in_endo = 'in_endo'
		self.out_endo = 'out_endo'
		self.in_agg = 'in_agg'
		self.out_agg = 'out_agg'
		self.all_agg = 'all_agg'
		self.inpname = 'input'
		self.outname = 'output'
		self.update(kwargs)
		self.database = DataBase.py_db(name=self.name,alias=pd.MultiIndex.from_tuples([(self.setname,self.alias), (self.setname, self.alias2)]))

	def update(self,kwargs):
		for key,value in kwargs.items():
			setattr(self,key,value)

	def write2db(self,db,priority='second'):
		"""
		Merge into database (db).
		"""
		DataBase.py_db.merge_dbs(db,self.database,priority)
		return db

	def run_all(self):
		self.in_map_from_tree()
		self.out_map_from_tree()
		self.all_map_from_maps()
		self.set_from_tree()
		self.in_inputs_from_maps()
		self.out_inputs_from_maps()
		self.inp_from_maps()
		self.out_from_maps()
		self.in_aggregates_from_map()
		self.out_aggregates_from_map()
		self.all_agg_from_aggs()
		self.add_alias()

	# def all_agg_from_aggs(self):
	# 	self.database[self.aggname] = self.database[self.in_aggname].union(self.database[self.out_aggname])
	# 	return self.database[self.aggname]

	def in_inputs_from_maps(self):
		self.database[self.in_endo] = self.database[self.in_map].get_level_values(0).unique()
		return self.database[self.in_endo]

	def out_inputs_from_maps(self):
		self.database[self.out_endo] = self.database[self.out_map].get_level_values(0).unique()
		return self.database[self.out_endo]

	def in_map_from_tree(self):
		temp = []
		for key in self.tree['in']:
			temp += [(value,key) for value in self.tree['in'][key]]
		self.database[self.in_map] = pd.MultiIndex.from_tuples(temp,names=[self.setname, self.alias])
		self.database[self.in_map].name = self.in_map
		return self.database[self.in_map]

	def out_map_from_tree(self):
		temp = []
		for key in self.tree['out']:
			temp += [(value,key) for value in self.tree['out'][key]]
		self.database[self.out_map] = pd.MultiIndex.from_tuples(temp,names=[self.setname, self.alias])
		self.database[self.out_map].name = self.out_map
		return self.database[self.out_map]

	def all_map_from_maps(self):
		self.database[self.all_map] = self.database[self.in_map].union(self.database[self.out_map])
		return self.database[self.all_map]

	def set_from_tree(self):
		temp = []
		for key in self.tree['in']:
			temp += self.tree['in'][key]+[key]
		for key in self.tree['out']:
			temp += self.tree['out'][key]+[key]
		self.database[self.setname] = pd.Index(temp,name=self.setname).unique()
		return self.database[self.setname]

	def inp_from_maps(self):
		self.database[self.inpname] = pd.Index(set(self.database[self.in_map].get_level_values(0).to_list()+self.database[self.out_map].get_level_values(1).to_list())-set(self.database[self.in_map].get_level_values(1).to_list()+self.database[self.out_map].get_level_values(0).to_list()),name=self.setname)
		return self.database[self.inpname]

	def out_from_maps(self):
		self.database[self.outname] = pd.Index(set(self.database[self.in_map].get_level_values(1).to_list()+self.database[self.out_map].get_level_values(0).to_list())-set(self.database[self.in_map].get_level_values(0).to_list()+self.database[self.out_map].get_level_values(1).to_list()),name=self.setname)
		return self.database[self.outname]

	def in_aggregates_from_map(self):
		self.database[self.in_agg] = pd.Index(set(self.database[self.in_map].get_level_values(1)),name=self.setname)
		return self.database[self.in_agg]

	def out_aggregates_from_map(self):
		self.database[self.out_agg] = pd.Index(set(self.database[self.out_map].get_level_values(1)),name=self.setname)
		return self.database[self.out_agg]

	def all_agg_from_aggs(self):
		self.database[self.all_agg] = self.database[self.in_agg].union(self.database[self.out_agg])
		return self.database[self.all_agg]

	def add_alias(self):
		self.database[self.alias] = self.database[self.setname].copy()
		self.database[self.alias].name = self.alias
		self.database[self.alias2]= self.database[self.setname].copy()
		self.database[self.alias2].name = self.alias2


class nesting_tree:
	"""
	Small class of nesting tree.
	"""
	def __init__(self,name="",tree=None,**kwargs):
		self.name=name
		self.tree = tree
		self.setname = 'n'
		self.alias = 'nn'
		self.alias2 = 'nnn'
		self.mapname = 'n2nn'
		self.aggname = 'a'
		self.inpname = 'input'
		self.outname= 'output'
		self.sector = 'sector'
		self.update(kwargs)
		self.database = DataBase.py_db(name=self.name,alias=pd.MultiIndex.from_tuples([(self.setname,self.alias), (self.setname, self.alias2)]))

	def update(self,kwargs):
		for key,value in kwargs.items():
			setattr(self,key,value)

	def write2db(self,db,priority='second'):
		"""
		Merge into database (db).
		"""
		DataBase.py_db.merge_dbs(db,self.database,priority)
		return db

	def run_all(self):
		self.mapping_from_tree()
		self.set_from_tree()
		self.aggregates_from_tree()
		self.inputs_from_tree()
		self.outputs_from_tree()
		self.add_alias()
		self.sector_from_tree()

	def sector_from_tree(self):
		self.database[self.sector] = self.database[self.inpname].union(self.database[self.aggname])

	def add_alias(self):
		self.database[self.alias] = self.database[self.setname].copy()
		self.database[self.alias].name = self.alias
		self.database[self.alias2]= self.database[self.setname].copy()
		self.database[self.alias2].name = self.alias2

	def mapping_from_tree(self):
		temp = []
		for key in self.tree:
			temp += [(value,key) for value in self.tree[key]]
		self.database[self.mapname] = pd.MultiIndex.from_tuples(temp,names=[self.setname,self.alias])
		self.database[self.mapname].name = self.mapname

	def set_from_tree(self):
		temp = []
		for key in self.tree:
			temp += self.tree[key]+[key]
		self.database[self.setname] = pd.Index(temp,name=self.setname).unique()

	def aggregates_from_tree(self):
		self.database[self.aggname] = pd.Index(set(self.database[self.mapname].get_level_values(1)),name=self.setname)

	def inputs_from_tree(self):
		self.database[self.inpname] = pd.Index(set(self.database[self.mapname].get_level_values(0))-set(self.database[self.mapname].get_level_values(1)),name=self.setname)

	def outputs_from_tree(self):
		self.database[self.outname] = pd.Index(set(self.database[self.mapname].get_level_values(1))-set(self.database[self.mapname].get_level_values(0)), name=self.setname)