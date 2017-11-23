import csv
import sys

f = open('example.csv', 'rt')
reader = csv.reader(f)
M = matrix([[RR(a),RR(b),RR(c)] for a,b,c in reader])
I, W, P = M.column(0), M.column(1), M.column(2)
f.close()
C=sum(W)
def MCMKP_MIP(C,P,W):
    program = MixedIntegerLinearProgram(maximization=False,solver="GLPK")
    vzamemo = program.new_variable(binary=True)
    P= [3,4,6,2,1]
    I=range(C)
    program.set_objective(sum(P[i] * vzamemo[i] for i in I))


    W = [1,1,2,3,4]
    C=5

    Csez = [C-x for x in W]

    #Določimo indeks kritičnega predmeta
    indeks= 0
    vsota= 0
    while(vsota<= C):
        indeks=indeks + 1
        vsota=vsota+ I[W[indeks]]
    end
    kriticen=indeks

    #Dodamo omejitve algoritma
    program.add_constraint(sum(W[i] * vzamemo[i] for i in I) <= C)
    for i in range(kriticen+1):
        program.add_constraint(sum(min(W[j],Csez[i]+1)*vzamemo[j] for j in I if i!=j) + min(W[kriticen],Csez[i]+1)*vzamemo[i] >= Csez[i]+1)

    #solve nam vrne optimalno rešitev OPT, get_values nam vrne seznam 1 n 0, ki povedo katere predmete smo vzeli
    %time program.solve()          #time nam meri čas, ki ga algoritem porabi za delovanje
    program.get_values(vzamemo)
    program.show()                 #zapiše celoten program na bolj pregleden način
return (program[0],program[1],program[2])




