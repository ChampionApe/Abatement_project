import numpy as np
import scipy as sp
from scipy import stats
import math
import matplotlib as mpl
import matplotlib.pyplot as plt
import ipywidgets as widgets
from ipywidgets import interact, interact_manual


def draw_sample(T,abate_upper, c_upper, seed):
    np.random.seed(seed)
    draw_c = np.random.uniform(0,1,T)
    draw_q = np.random.uniform(0,1,T)
    sum_c = sum(draw_c)
    sum_q = sum(draw_q)
    c = (draw_c/sum_c)*c_upper
    q = (draw_q/sum_q)*abate_upper
    sample_c = np.cumsum(c)
    sample_q_sum = np.cumsum(q)
    return sample_c, sample_q_sum,q

def plot_stepcurve(sample_c,sample_q,labels):
    # Create samples:
    sample_qnew = np.sort(np.concatenate(([0, 0], sample_q,sample_q)))
    sample_cnew = np.sort(np.concatenate(([0],sample_c, sample_c,[max(sample_c)*1.1])))
    fig = plt.figure(frameon=False, figsize=(6,4), dpi=100)
    ax = fig.add_subplot(1,1,1)
    ax.plot(sample_cnew, sample_qnew, color='blue')
    ax.set_xlim([0, max(sample_cnew)])
    ax.set_xlabel(labels[0])
    # This little code adjusts the level of the y-axis in the plot:
    y_level = len(str(abs(int(max(sample_q))))) # counts the number of digits (before .)
    if max(sample_q)<1:
        ax.set_ylim([0, (math.ceil(10*max(sample_q))/10)])
    else:
        ax.set_ylim([0, (math.ceil(10**(y_level-1)*max(sample_q))/(10**(y_level-1)))])
    ax.set_ylabel(labels[1])
    fig.tight_layout()

def smooth_sample(C,tau,sigma):
    dimX = C.shape[0] # Number of technologies
    dimY = tau.shape[0] # Number of values on grid of tau
    dimZ = sigma.shape[0] # Number of sigma values to test
    log_tau_matrix = np.log(np.matmul(np.ones((dimX,1)), np.array([tau])))
    log_c_matrix = np.log(np.matmul(np.transpose(np.array([C])), np.ones((1,dimY))))
    tau_all = np.reshape(log_tau_matrix, log_tau_matrix.shape + (1,))
    c_all = np.reshape(log_c_matrix, log_c_matrix.shape + (1,))
    log_tau_all = np.tile(tau_all,(1,1,dimZ))
    log_c_all = np.tile(c_all,(1,1,dimZ))
    A_distr = np.empty([dimX,dimY,dimZ])
    C_distr = np.empty([dimX,dimY,dimZ])
    for i in range(0,dimZ):
        A_distr[:,:,i] = stats.norm.cdf((log_tau_all[:,:,i]-log_c_all[:,:,i]+pow(sigma[i],2)/2)/sigma[i])
        C_distr[:,:,i] = stats.norm.cdf((log_tau_all[:,:,i]-log_c_all[:,:,i]-pow(sigma[i],2)/2)/sigma[i])
    return A_distr,C_distr

def find_nearest(array, value):
    array = np.asarray(array)
    idx = (np.abs(array - value)).argmin()
    return array[idx]

def interactive_sigma(A,tau,sigma,sigma_base,label):
    
    def plot_onesigma(sigma_i):
        plot_smooth(A,tau,sigma,sigma_i,sigma_base,label)

    widgets.interact(plot_onesigma,
        sigma_i = widgets.FloatSlider(
            description="$\\sigma$",
            min = np.min(sigma),
            max = np.max(sigma),
            step = sigma[1]-sigma[0],
            value = sigma[sigma_base]
        ))
    
def plot_smooth(A,tau,sigma,sigma_i,sigma_base,label):
    A_base = A[:,sigma_base]
    sigma_val = find_nearest(sigma,sigma_i)
    sigma_index = np.where(sigma == sigma_val)
    fig = plt.figure(frameon=False, figsize=(6,4), dpi=100)
    ax = fig.add_subplot(1,1,1)
    ax.plot(tau,A_base)
    ax.plot(tau,A[:,sigma_index[0]])
    ax.set_xlim(0,tau[-1])
    ax.set_ylim([np.min(A), np.max(A)])
    ax.set_xlabel('$\\tau$')
    ax.set_ylabel(label)
    plt.legend(('Baseline', 'Adjusted $\\sigma$'))
    fig.tight_layout()


