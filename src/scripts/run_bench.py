#!/usr/bin/python

import matplotlib.pyplot as plt
from subprocess import call

AWSRUN = ""#"awsrun"
C_FN_O = "c_output"
J_FN_O = "j_output"

NUM_TRIALS = 10
N = 2**23

def run_c_impl(num_cilkwrks):
  global AWSRUN
  global C_FN_O

  call("cd ../merge/c/; make clean; make", shell=True)
  call(AWSRUN + "export CILK_NWORKERS=%(num_cilkwrks)d && ../merge/c/test > " % locals() \
       + C_FN_O, shell=True)

def read_c_output(d, num_cilkwrks):
  global C_FN_O

  with open(C_FN_O, "r") as f:
    for line in f:
      print line
      if line.startswith("Average"):
        if "Naive Serial Merge Sort" in line:
          d['c']['serial'] = float(line.split(" ")[-1].rstrip("s\n"))
        elif "Optimized Serial Merge Sort" in line:
          d['c']['serial_opt'] = float(line.split(" ")[-1].rstrip("s\n"))
        elif "Optimized Parallel Merge Sort" in line:
          d['c']['parallel'][num_cilkwrks] = float(line.split(" ")[-1].rstrip("s\n"))

def collect_c_data(d):
  for i in range(8):
    run_c_impl(i + 1)
    read_c_output(d, i + 1)

def run_j_impl():
  global J_FN_O

  call("julia ../merge/julia/MyBenchmarks.jl > " + J_FN_O, shell=True)

def read_j_output(d):
  global J_FN_O

  with open(J_FN_O, "r") as f:
    for line in f:
        if "MySerialSort" in line:
          d['j']['serial'] = float(line.split(" ")[-1].rstrip())
        elif "MySerialOptSort" in line:
          d['j']['serial_opt'] = float(line.split(" ")[-1].rstrip())
        elif "MyParallelSort" in line:
          d['j']['parallel_cpy'] = float(line.split(" ")[-1].rstrip())
        elif "MyParallelSASort" in line:
          num_procs = int(line.split(" ")[-2])
          d['j']['parallel'][num_procs] = float(line.split(" ")[-1].rstrip())

def collect_j_data(d):
  run_j_impl()
  read_j_output(d)

def stats_summary(d):
  print d
  for l in ['c']:#, 'j']:
    lang = "Julia" if l == "j" else "C"
    print lang + " Implementation Results"
    l = l.lower()
    for k in d[l].keys():
      if k != 'parallel':
        result = d[l][k]
        print "\t%(k)s : %(result)f" % locals()
      else:
        print "\tParallel Performance by Number of Workers"
        for i in range(1, 9):
          result = d[l][k][i]
          print "\t\t%(i)d : %(result)f" % locals()

def plot_data(d):
  x = range(1,9)
  y1 = [d['c']['parallel'][i] for i in x]
  #y2 = [d['j']['parallel'][i] for i in x]
  
  plt.plot(x, y1, 'bs-', label='C')
  #plt.plot(x, y2, 'g^-', label='Julia')
  plt.title("Parallel Runtime vs. Number of Cores")
  plt.xlabel("Number of Cores")
  plt.ylabel("Runtime (secs)")
  plt.show()

  x = range(1,9)
  y1 = [d['c']['serial_opt'] / d['c']['parallel'][i] for i in x]
  #y2 = [d['j']['serial_opt'] / d['j']['parallel'][i] for i in x]
  plt.plot(x, y1, 'bs-', label='C')
  #plt.plot(x, y2, 'g^-', label='Julia')
  plt.title("Parallel Speedup vs. Number of Cores")
  plt.xlabel("Number of Cores")
  plt.ylabel("Optimized Serial / Parallel Runtime")
  plt.show()

def cleanup():
  global C_FN_O
  global J_FN_O

  call("rm " + C_FN_O + " " + J_FN_O, shell=True)

data = {
  'c' : {
    'serial'     : None,
    'serial_opt' : None,
    'parallel'   : {
      i : None for i in range(1,9)
    }
  },
  'j' : {
    'serial'       : None,
    'serial_opt'   : None,
    'parallel_cpy' : None,
    'parallel'     : {
      i : None for i in range(1,9)
    }
  }
}

if __name__ == "__main__":
  collect_c_data(data)
  #collect_j_data(data)
  stats_summary(data)
  plot_data(data)
  cleanup()
