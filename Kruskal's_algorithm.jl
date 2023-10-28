#Julia 1.6.1

#dfsを用いた閉路判定
function checkLoop(matrix::Array{Int, 2}, x::Int, y::Int, i::Int)
    m = copy(matrix)
    m[x, y] = m[y, x] = i
    start = x
    visited = [start]
    stack = [start]
    row = start
    vSize = size(m)[1]
    
    while true
        for column in 1:vSize
            if m[row, column] >= 1
                m[row, column] = m[column, row] = -1
                
                #閉路が発見されたらFalseを返す
                if column in visited return false end
                
                row = column
                push!(visited, column)
                push!(stack, column)
                break
            end
            
            if column == vSize
                pop!(stack)
                if stack != [] row = stack[end] end
                break
            end
        end
        if stack == [] break end
    end
    
    #閉路が発見されなかったらtrueを返す
    return true
end


function kruskal(matrix::Array{Int, 2})
    
    #頂点の個数
    vSize = size(matrix)[1]

    #答え用の行列
    ansMatrix = zeros(Int, (vSize, vSize))

    #重みの中の最大値
    maxCost = maximum(matrix)

    for i in 1:maxCost
        for x in 1:vSize
            for y in x:vSize
                #新しく見つけた辺を追加しても閉路がないなら
                if matrix[x, y] == i && checkLoop(ansMatrix, x, y, i)
                    #答えの更新
                    ansMatrix[x, y] = ansMatrix[y, x] = i
                end
            end
        end
    end
        
    return ansMatrix
end


#与える行列
matrix = [0 3 0 5 0 0 0 0 0;
          3 0 2 0 1 0 0 0 0;
          0 2 0 0 0 1 0 0 0;
          5 0 0 0 4 0 3 0 0;
          0 1 0 4 0 3 0 3 0;
          0 0 1 0 3 0 0 0 5;
          0 0 0 3 0 0 0 5 0;
          0 0 0 0 3 0 5 0 2;
          0 0 0 0 0 5 0 2 0]

ansMatrix = kruskal(matrix)
allCosts = Int(sum(ansMatrix)/2)
println("総コストは $allCosts です")
