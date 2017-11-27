import csv
import sys
imena=['Korelirani_R10_N10.csv','Korelirani_R10_N100.csv','Korelirani_R10_N50.csv','Korelirani_R100_N10.csv','Korelirani_R100_N100.csv','Korelirani_R100_N50.csv','Korelirani_R100_N1000.csv','Korelirani_R1000_N10.csv','Korelirani_R1000_N100.csv','Korelirani_R1000_N50.csv','Korelirani_R100_N5000.csv','Nekorelirani_R10_N10.csv','Nekorelirani_R10_N100.csv','Nekorelirani_R10_N50.csv','Nekorelirani_R100_N10.csv','Nekorelirani_R100_N100.csv','Nekorelirani_R100_N50.csv','Nekorelirani_R1000_N10.csv','Nekorelirani_R1000_N100.csv','Nekorelirani_R1000_N50.csv','Nekorelirani_R100_N1000.csv','Nekorelirani_R100_N5000.csv','Nekorelirani_R1000_N1000.csv','Nekorelirani_R1000_N5000.csv']


def MCMKP_MIP(C,P,W):
    from time import time
    s = time()
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
    
    resitev = program.get_values(vzamemo)
    koncniC = sum(resitev[i] * w for i, w in enumerate(W))
    
    t = time()
    trajanje = t-s # trajanje v sekundah
    #če bi želeli dodati še seznam predmetov, ki smo jih vzeli damo v return še program.get_values(vzamemo)
    return (program.solve(),trajanje,koncniC)

seznamresitev = []
for i in imena:
    f = open(i, 'rt')
    reader = csv.reader(f,delimiter = ';')
    M = matrix([[RR(a),RR(b),RR(c)] for a,b,c in reader])
    W, P = M.column(1), M.column(2)
    f.close()
    C=round((sum(W)*75)/100,0) #vzamemo 75% teže vseh predmetov
    seznamresitev.append(MCMKP_MIP(C,P,W))
seznamresitev









