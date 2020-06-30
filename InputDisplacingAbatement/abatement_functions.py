from gams import *
import pandas as pd
from dreamtools.gams_pandas import *
from dreamtools.gamY import Precompiler
import DataBase
from DB2Gams import *

class a_model(gams_model_py):
	"""
	Initiate as a gams_model_py:
	"""
	def __init__(self,tree,gsettings=None,**kwargs):
		self.tree = tree
		self.update_settings(kwargs)
		super().__init__(self.tree.database,gsettings=gsettings)

	def update_settings(self,kwargs):
		for key,value in kwargs.items():
			setattr(self,key,value)

	# Define groups:
	def define_groups(self,p='p',q='q',mu='mu',sigma='sigma'):
		self.p = p
		self.q = q
		self.mu = mu
		self.sigma = sigma
		if p not in self.database:
			self.database[p] = pd.Series(1,index=self.database[self.tree.setname],name=p)
		if q not in self.database:
			self.database[q] = pd.Series(1,index=self.database[self.tree.sector],name=q)
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
		
	# Define blocks (just one block needed here)
	def define_blocks(self):
		self.blocks = """
$BLOCK M_{mname}
	E_{mname}_q{q_domains}${q_conditions}..		{q}	=E= sum({nn}$({mapname}), {mu}*({p}/{p_alias})**(-{sigma_alias})*{q_alias});
	E_{mname}_p{p_domains}${p_conditions}..		{p} =E= sum({nn}$({mapname_alias}), {mu_alias} * {p_alias}**(1-{sigma}))**(1/(1-{sigma}));
$ENDBLOCK
""".format(	mname 		= self.model.name,
			q 			= self.database.get(self.q).to_str,
			q_domains 	= self.groups[self.model.name+'_endo'][self.q]['domains'],
			q_conditions= self.groups[self.model.name+'_endo'][self.q]['conditions'],
			q_alias 	= self.database.get(self.q,alias_domains=[1]).to_str,
			p 			= self.database.get(self.p).to_str,
			p_domains 	= self.groups[self.model.name+'_endo'][self.p]['domains'],
			p_conditions= self.groups[self.model.name+'_endo'][self.p]['conditions'],
			p_alias 	= self.database.get(self.p,alias_domains=[1]).to_str,
			mu			= self.database.get(self.mu).to_str,
			mu_alias	= self.database.get(self.mu,alias_domains=[1,0]).to_str,
			sigma 		= self.database.get(self.sigma).to_str,
			sigma_alias = self.database.get(self.sigma,alias_domains=[1]).to_str,
			nn  		= self.tree.alias,
			mapname		= self.database.get(self.tree.mapname).to_str,
			mapname_alias=self.database.get(self.tree.mapname,alias_domains=[1,0]).to_str
			)
		self.model.blocks = ['M_'+self.model.name]

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