# tests with the 5 taxon networks parameters: net.ht, net.numht
# Claudia January 2015


# types in "types.jl"
include("../types.jl")
include("../functions.jl")

# needed modules:
using Base.Collections # for updateInCycle with priority queue

# test functions

tests = ["C","F","G","H","J","D","E","I"];
wrong = String[];

function whichtree(t::ASCIIString)
    if(t == "tree")
        tree = "(((6:0.1,4:1.5)1:0.2,7:0.2)5:0.1,8:0.1,10:0.1);" # normal tree
    elseif(t == "C")
        tree = "((((6:0.1,4:1.5),(7:0.2)11#H1),11#H1),8:0.1,10:0.1);" # Case C: bad triangle II
    elseif(t == "F")
        tree = "(((6:0.1,(4)11#H1)1:0.2,(11#H1,7))5:0.1,8:0.1,10:0.1);" # Case F: bad diamond I
    elseif(t == "G")
        tree = "((((6:0.1,4:1.5)1:0.2,(7)11#H1)5:0.1,(11#H1,8)),10:0.1);" # Case G
    elseif(t == "H")
        tree = "((((6,4),#H1),7),(8)#H1,10);" # Case H
    elseif(t == "J")
        tree = "((((6)#H1,4),7),8,(#H1,10));" # Case J
    elseif(t == "D")
        tree = "((((6,4))#H1,(#H1,7)),8,10);" # Case D Bad triangle I
    elseif(t == "E")
        tree = "(((((8,10))#H1,7),#H1),6,4);" # Case E Bad triangle I
    elseif(t == "I")
        tree = "((((8,10))#H1,7),6,(4,#H1));" # Case I Bad triangle II
    else
        error("not a known 5 taxon network case")
    end
    return tree
end


function whichtest(t::ASCIIString,net::HybridNetwork)
    if(t == "C")
        all(map(approxEq,net.ht,[exp(-1.)*(1-0.1*(1-exp(-1.))),exp(-1.)*(1-0.9*(1-exp(-1.))),-exp(-2.)*(0.1*(1-exp(-1.))*(1-exp(-1.))*0.9)])) || error("net.ht wrong in case $(t)")
        net.numht == [41,42,43] || error("net.numht wrong in case $(t)")
    elseif(t == "F")
        all(map(approxEq,net.ht,[0.1,0.9*(1-exp(-.2)),0.1*(1-exp(-1.))])) || error("net.ht wrong in case $(t)")
        net.numht == [8,31,32] || error("net.numht wrong in case $(t)")
    elseif(t == "G")
        all(map(approxEq,net.ht,[0.1,0.2,0.1,1.0])) || error("net.ht wrong in case $(t)")
        net.numht == [7,3,6,9] || error("net.numht wrong in case $(t)")
    elseif(t == "H")
        all(map(approxEq,net.ht,[0.1,1.0,1.0,1.0])) || error("net.ht wrong in case $(t)")
        net.numht == [4,3,5,7] || error("net.numht wrong in case $(t)")
    elseif(t == "J")
        all(map(approxEq,net.ht,[0.1,1.0,1.0,1.0])) || error("net.ht wrong in case $(t)")
        net.numht == [8,4,6,10] || error("net.numht wrong in case $(t)")
    elseif(t == "D")
        all(map(approxEq,net.ht,[1.0,0.1*(1-exp(-1.)),0.1*0.1*(1-exp(-1.))+0.9*0.9*(1-exp(-2.))])) || error("net.ht wrong in case $(t)")
        net.numht == [8,31,32] || error("net.numht wrong in case $(t)")
    elseif(t == "E")
        all(map(approxEq,net.ht,[1.0,0.9*(1-exp(-1.)),0.1*0.1*(1-exp(-2.))+0.9*0.9*(1-exp(-1.))])) || error("net.ht wrong in case $(t)")
        net.numht == [8,31,32] || error("net.numht wrong in case $(t)")
    elseif(t == "I")
        all(map(approxEq,net.ht,[0.1,2.0,1.0,1.0])) || error("net.ht wrong in case $(t)")
        net.numht == [9,3,6,10] || error("net.numht wrong in case $(t)")
    else
        error("not a known 5 taxon network case")
    end
    return tree
end


for t in tests
    println("running $(t)")
    net = nothing;
    tree = whichtree(t)
    f = open("prueba_tree.txt","w")
    write(f,tree)
    close(f)
    net = readTopologyUpdate("prueba_tree.txt");
    println("---- Case $(t)")
    println("$(net.ht)")
    println("$(net.numht)")
    try
        whichtest(t,net)
    catch
        println("error in $(t)")
        push!(wrong,t);
    end
end



if(!isempty(wrong))
    for t in wrong
        println("running $(t)")
        net = nothing;
        tree = whichtree(t)
        f = open("prueba_tree.txt","w")
        write(f,tree)
        close(f)
        net = readTopologyUpdate("prueba_tree.txt");
        whichtest(t,net)
    end
else
    println("----------NO ERRORS!----------");
end