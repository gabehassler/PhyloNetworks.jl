# test for the optimization of branch lengths
# with Case g
# Claudia January 2015

## include("../case_g_example.jl");
## q1 = Quartet(1,["6","7","4","8"],[0.5,0.4,0.1]);
## q2 = Quartet(2,["6","7","10","8"],[0.5,0.4,0.1]);
## q3 = Quartet(3,["10","7","4","8"],[0.5,0.4,0.1]);
## q4 = Quartet(4,["6","10","4","8"],[0.5,0.4,0.1]);
## q5 = Quartet(5,["6","7","4","10"],[0.5,0.4,0.1]);

## d = DataCF([q1,q2,q3,q4,q5]);
## extractQuartet!(net,d)

## df = writeExpCF(d.quartet)
## writetable("CaseG_output.csv",df)

include("../types.jl")
include("../functions.jl")

df = readtable("CaseG_output.csv")
d2 = readDataCF(df)

tree = "((((6,4)1,(7)11#H1:::0.8)5,(11#H1:::0.2,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

net.ht
realht = [0.1,0.2,0.1,1.0]

@time fmin,xmin=optBL(net,d2)
#got 5.33118 at [0.247,0.18076,0.12026,0.2956] after 81 iterations (returned FTOL_REACHED)
#elapsed time: 8.654081812 seconds (8624832 bytes allocated)
#(5.331178696104555,[0.246999,0.180762,0.120265,0.295604])

@allocated fmin,xmin=optBL(net,d2)

# -------- different starting point ------

# (0.12,1.,1.,1.)
tree = "((((6,4)1,(7)11#H1:::0.88)5,(11#H1:::0.12,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

@time fmin,xmin=optBL(net,d2)


# (0.1,1.,1.,1.)
tree = "((((6,4)1,(7)11#H1)5,(11#H1,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

@time fmin,xmin=optBL(net,d2)


# (0.05,1.,1.,1.)
tree = "((((6,4)1,(7)11#H1:::0.95)5,(11#H1:::0.05,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

@time fmin,xmin=optBL(net,d2)


# (0.15,1.,1.,1.)
tree = "((((6,4)1,(7)11#H1:::0.85)5,(11#H1:::0.15,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

@time fmin,xmin=optBL(net,d2)


# (0.35,1.,1.,1.)
tree = "((((6,4)1,(7)11#H1:::0.65)5,(11#H1:::0.35,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

@time fmin,xmin=optBL(net,d2)


# (0.24,1.,1.,1.)
tree = "((((6,4)1,(7)11#H1:::0.75)5,(11#H1:::0.25,8)),10);" # Case G different starting branch lengths
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)
printNodes(net)

@time fmin,xmin=optBL(net,d2)

# ==================================================================================================

# test optBL with Case H
# Claudia January 2015


## include("../case_h_example.jl");
## q1 = Quartet(1,["6","7","4","8"],[0.5,0.4,0.1]);
## q2 = Quartet(2,["6","7","10","8"],[0.5,0.4,0.1]);
## q3 = Quartet(3,["10","7","4","8"],[0.5,0.4,0.1]);
## q4 = Quartet(4,["6","10","4","8"],[0.5,0.4,0.1]);
## q5 = Quartet(5,["6","7","4","10"],[0.5,0.4,0.1]);

## d = DataCF([q1,q2,q3,q4,q5]);
## extractQuartet!(net,d)

## df = writeExpCF(d.quartet)
## writetable("CaseH_output.csv",df)

include("../types.jl")
include("../functions.jl")

df = readtable("CaseH_output.csv")
d2 = readDataCF(df)

# starting ht (gamma,t3,t5,t7)
ht = [0.2,1.,1.,1.]

tree = string("((((6:0.1,4:1.5):",string(ht[2]),",#H1:::",string(ht[1]),"),7:0.2):",string(ht[4]),",(8)#H1:::",string(1-ht[1]),",10:0.1);") # Case H
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

net.ht
realht = [0.1,0.1,1.,0.1]

@time fmin,xmin=optBL(net,d2)
#got 4.34098 at [0.1,0.10001,0.99999,0.1] after 151 iterations (returned FTOL_REACHED)
#elapsed time: 21.076511672 seconds (21355496 bytes allocated, 0.17% gc time)
#(4.340977085797292,[0.0999962,0.100005,0.999989,0.0999984])

# ==================================================================================================================================

# test optBL with Case J
# Claudia January 2015


## include("../case_j_example.jl");
## q1 = Quartet(1,["6","7","4","8"],[0.5,0.4,0.1]);
## q2 = Quartet(2,["6","7","10","8"],[0.5,0.4,0.1]);
## q3 = Quartet(3,["10","7","4","8"],[0.5,0.4,0.1]);
## q4 = Quartet(4,["6","10","4","8"],[0.5,0.4,0.1]);
## q5 = Quartet(5,["6","7","4","10"],[0.5,0.4,0.1]);

## d = DataCF([q1,q2,q3,q4,q5]);
## extractQuartet!(net,d)

## df = writeExpCF(d.quartet)
## writetable("CaseJ_output.csv",df)

include("../types.jl")
include("../functions.jl")

df = readtable("CaseJ_output.csv")
d2 = readDataCF(df)

# starting ht (gamma,t3,t5,t7)
ht = [0.2,1.,1.,1.]

tree = string("((((6)#H1:::",string(1-ht[1]),",4:1.5):",string(ht[2]),",7:0.2):",string(ht[3]),",8:0.1,(#H1:::",string(ht[1]),",10));") # Case J
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

net.ht
realht = [0.1,0.2,0.1,1.0]

@time fmin,xmin=optBL(net,d2)
#got 5.39161 at [0.09997,0.19999,0.1,1.00061] after 246 iterations (returned FTOL_REACHED)
#elapsed time: 59.297791699 seconds (71939204 bytes allocated, 0.11% gc time)
#(5.3916134028946034,[0.0999661,0.199991,0.0999991,1.00061])


# ==================================================================================================================================

# test optBL with Case F Bad Diamond I
# Claudia January 2015


## include("../case_f_example.jl");
## parameters!(net)
## q1 = Quartet(1,["6","7","4","8"],[0.5,0.4,0.1]);
## q2 = Quartet(2,["6","7","10","8"],[0.5,0.4,0.1]);
## q3 = Quartet(3,["10","7","4","8"],[0.5,0.4,0.1]);
## q4 = Quartet(4,["6","10","4","8"],[0.5,0.4,0.1]);
## q5 = Quartet(5,["6","7","4","10"],[0.5,0.4,0.1]);

## d = DataCF([q1,q2,q3,q4,q5]);
## extractQuartet!(net,d)

## df = writeExpCF(d.quartet)
## writetable("CaseF_output.csv",df)

include("../types.jl")
include("../functions.jl")

df = readtable("CaseF_output.csv")
d2 = readDataCF(df)

# starting ht (gamma,t4,t5,t9)
ht = [0.1,1.,1.,1.]

tree = string("(((6:0.1,(4)11#H1:::",string(1-ht[1]),")1:",string(ht[3]),",(11#H1:::",string(ht[1]),",7))5:",string(ht[4])",8:0.1,10:0.1);") # Case F: bad diamond I
f = open("prueba_tree.txt","w")
write(f,tree)
close(f)
net = readTopologyUpdate("prueba_tree.txt");
printEdges(net)

net.ht
realht = [0.1,0.127,0.0285]

@time fmin,xmin=optBL(net,d2)
#got 5.40235 at [0.1,0.12689,0.02855] after 116 iterations (returned FTOL_REACHED)
#elapsed time: 15.648447251 seconds (17823396 bytes allocated, 0.18% gc time)
#(5.402353356033268,[0.1,0.126887,0.0285486])