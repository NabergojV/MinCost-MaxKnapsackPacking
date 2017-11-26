︠2c844eb0-1c78-440f-89d3-ede5d552aae2s︠
import csv
import sys
imena=['Korelirani_R10_N10.csv','Korelirani_R10_N100.csv','Korelirani_R10_N50.csv','Korelirani_R100_N10.csv','Korelirani_R100_N100.csv','Korelirani_R100_N50.csv','Korelirani_R1000_N10.csv','Korelirani_R1000_N100.csv','Korelirani_R1000_N50.csv','Nekorelirani_R10_N10.csv','Nekorelirani_R10_N100.csv','Nekorelirani_R10_N50.csv','Nekorelirani_R100_N10.csv','Nekorelirani_R100_N100.csv','Nekorelirani_R100_N50.csv','Nekorelirani_R1000_N10.csv','Nekorelirani_R1000_N100.csv','Nekorelirani_R1000_N50.csv']

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

    t = time()
    trajanje = t-s # trajanje v sekundah
    #če bi želeli dodati še seznam predmetov, ki smo jih vzeli damo v return še program.get_values(vzamemo)
    return (program.solve(),trajanje)

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
︡6455805e-c58b-4f88-89cd-0dab395761ba︡{"stdout":"[(245.0, 0.0020599365234375), (2147.0, 0.16498804092407227), (851.0, 0.03189897537231445), (220.0, 0.0023200511932373047), (3807.0, 0.25791501998901367), (1872.0, 0.08564901351928711), (3690.0, 0.0025420188903808594), (34945.0, 0.3753180503845215), (17178.0, 0.05631899833679199), (22.0, 0.0021028518676757812), (264.0, 0.14114594459533691), (143.0, 0.03324699401855469), (155.0, 0.002234935760498047), (2467.0, 0.21033501625061035), (1088.0, 0.07308602333068848), (1806.0, 0.0023488998413085938), (17636.0, 0.5011420249938965), (11834.0, 0.09205484390258789)]\n"}︡{"done":true}︡
︠35512b58-6e0d-4afe-a510-4c6a97f6d272︠






