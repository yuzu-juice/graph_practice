#Julia 1.6.1

function prim(matrix::Array{Int, 2})
    
    #頂点の個数
    vSize = size(matrix)[1]
    
    #開始頂点
    s = 1

    #答え用の行列
    ansMatrix = zeros(Int, (vSize, vSize))

    #追加済みの頂点
    T = [s]
    
    #最小コスト
    minCost = Inf

    x = (0, 0)
    flag = false

    #探索
    while length(T) < vSize
        for a in 1:length(T)
            s = T[a]
            for i in 1:vSize
                if in(i, T) #すでに探索済みであれば
                    continue
                end

                u = matrix[s, i]

                #最小値の更新
                if 0 < u < minCost
                    minCost = u
                    x = (s, i)
                    flag = true
                end
            end
        end
        if flag == true
            #追加済みの頂点に追加
            push!(T, x[2])
            flag = false
        end
        #隣接行列の更新
        ansMatrix[x[1], x[2]] = ansMatrix[x[2], x[1]] = minCost
        #最小値のリセット
        minCost = Inf
    end
    return ansMatrix

end

#与える行列
matrix = [0 7 0 21 2 0 0 0 0 0 0 0 0 0;
          7 0 10 0 0 0 0 0 0 0 0 0 0 0;
          0 10 0 0 0 9 19 0 0 0 0 0 0 0;
          21 0 0 0 17 0 0 15 0 0 0 0 0 0;
          2 0 0 17 0 4 0 5 12 0 0 0 0 0;
          0 0 9 0 4 0 14 0 6 22 0 0 0 0;
          0 0 19 0 0 14 0 0 0 11 0 0 0 0;
          0 0 0 15 5 0 0 0 0 0 23 18 0 0;
          0 0 0 0 12 6 0 0 0 0 0 24 1 0;
          0 0 0 0 0 22 11 0 0 0 0 0 3 16;
          0 0 0 0 0 0 0 23 0 0 0 8 0 0;
          0 0 0 0 0 0 0 18 24 0 8 0 20 0;
          0 0 0 0 0 0 0 0 1 3 0 20 0 13;
          0 0 0 0 0 0 0 0 0 16 0 0 13 0]

ansMatrix = prim(matrix)
allCosts = Int(sum(ansMatrix)/2)


#結果の表示
println("総コストは $allCosts です")

for i in 1:size(ansMatrix)[1]
    c = i + 'A' - 1
    s = sum(ansMatrix[i,:])
    println("頂点 $c の次数は $s です")
end
