import csv
import sys

f = open('example.csv', 'rt',delimiter = ';')
reader = csv.reader(f)
M = matrix([[RR(a),RR(b),RR(c)] for a,b,c in reader])
I, W, P = M.column(0), M.column(1), M.column(2)
f.close()
C=sum(W)

def MCMKP_MIP(C,P,W):
    program = MixedIntegerLinearProgram(maximization=False,solver="GLPK")
    vzamemo = program.new_variable(binary=True)
    I=range(len(W))
    program.set_objective(sum(P[i] * vzamemo[i] for i in I))
    
    Csez = [C-x for x in W]

    #Določimo indeks kritičnega predmeta
    indeks= 0
    vsota= 0
    while(indeks< len(W) and vsota <=C):
        vsota=vsota+ W[indeks]
        indeks=indeks + 1
    kriticen=indeks - 1

    #Dodamo omejitve algoritma
    program.add_constraint(sum(W[i] * vzamemo[i] for i in I) <= C)
    for i in range(kriticen + 1):
        program.add_constraint(sum(min(W[j],Csez[i]+1)*vzamemo[j] for j in I if i!=j) + min(W[kriticen],Csez[i]+1)*vzamemo[i] >= Csez[i]+1)
    #solve nam vrne optimalno rešitev OPT, get_values nam vrne seznam 1 n 0, ki povedo katere predmete smo vzeli
    program.solve()          #time nam meri čas, ki ga algoritem porabi za delovanje
    #program.show()                 #zapiše celoten program na bolj pregleden način


    return (program.solve(),program.get_values(vzamemo),%time MCMKP_MIP(C,P,W))

