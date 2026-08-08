clear; 
clc;
%% 1. 读取文件数据
txt = fileread('C:\Users\dan\Desktop\package_data.txt');
lines = regexp(txt,'\r\n|\n','split');
addr = {};
w = [];

for i = 1:length(lines)
    L = strtrim(lines{i});
    if isempty(L), continue; end

    parts = regexp(L, ',', 'split');

    a = lower(strtrim(parts{1}));

    kg_str = regexp(parts{2},'\d+','match');
    kg = str2double(kg_str{1});

    addr{end+1} = a;
    w(end+1) = kg;
end

%% 2. 贪心算法分批（<=50kg）
dizhi = {};
current_dizhi = {};
current_zhongliang = 0;

for i = 1:length(w)
    if current_zhongliang + w(i) > 50
        dizhi{end+1} = current_dizhi;
        current_dizhi = {};
        current_zhongliang = 0;
    end
    current_dizhi{end+1} = addr{i};
    current_zhongliang = current_zhongliang + w(i);
end
if ~isempty(current_dizhi)
    dizhi{end+1} = current_dizhi;
end

fprintf("包裹按50kg载重限制共分成 %d 批。\n", length(dizhi));

%% 3. 路径建模

nodeNames = {
's','j1','j2','j3', ...
'jx1','jx2','jx3','jx4','jx5','jx6','jx7', ...
'x1','x2','x3','x4','x5','x6','x7', ...
'jy1','jy2','jy3', ...
'y1','y2','y3','y4','y5','y6', ...
'j3h1','j3h2','j3h3','j3h4','j3h5', ...
'h1','h2','h3','h4','h5'
};

N = length(nodeNames);
INF = 1e12;
A = INF * ones(N);%A为邻接矩阵
for i = 1:N
    A(i,i) = 0;
end

idx = @(name) find(strcmp(nodeNames, name));

function A = addEdge(A, nodeNames, a, b, d)
    a = lower(a); b = lower(b);
    ia = find(strcmp(nodeNames,a));
    ib = find(strcmp(nodeNames,b));
    A(ia,ib) = d;
    A(ib,ia) = d;
end

A = addEdge(A,nodeNames,'j1','j2',300);
A = addEdge(A,nodeNames,'j2','j3',300);
A = addEdge(A,nodeNames,'j3','s',300);

A = addEdge(A,nodeNames,'j1','jx7',50);
A = addEdge(A,nodeNames,'jx7','jx5',50);
A = addEdge(A,nodeNames,'jx5','jx3',50);

A = addEdge(A,nodeNames,'x7','jx7',20);
A = addEdge(A,nodeNames,'x5','jx5',50);
A = addEdge(A,nodeNames,'x3','jx3',50);

A = addEdge(A,nodeNames,'jx1','x1',20);
A = addEdge(A,nodeNames,'jx2','x2',20);
A = addEdge(A,nodeNames,'jx4','x4',20);
A = addEdge(A,nodeNames,'jx6','x5',20);

A = addEdge(A,nodeNames,'jx6','j2',50);
A = addEdge(A,nodeNames,'jx6','jx4',50);
A = addEdge(A,nodeNames,'jx2','jx4',50);
A = addEdge(A,nodeNames,'jx2','jx1',50);

A = addEdge(A,nodeNames,'j3','jy3',50);
A = addEdge(A,nodeNames,'jy1','jy2',50);
A = addEdge(A,nodeNames,'jy2','jy3',50);

A = addEdge(A,nodeNames,'jy1','y1',20);
A = addEdge(A,nodeNames,'jy1','y2',20);
A = addEdge(A,nodeNames,'jy2','y3',20);
A = addEdge(A,nodeNames,'jy2','y4',20);
A = addEdge(A,nodeNames,'jy3','y5',20);
A = addEdge(A,nodeNames,'jy3','y6',20);

A = addEdge(A,nodeNames,'j2','j3h1',800);
A = addEdge(A,nodeNames,'j3h1','h1',20);
A = addEdge(A,nodeNames,'j3h1','j3h2',200);
A = addEdge(A,nodeNames,'j3h2','h2',20);
A = addEdge(A,nodeNames,'j3h2','j3h3',50);
A = addEdge(A,nodeNames,'j3h3','h3',20);
A = addEdge(A,nodeNames,'j3h3','j3h4',50);
A = addEdge(A,nodeNames,'j3h4','h4',20);
A = addEdge(A,nodeNames,'j3h4','j3h5',50);
A = addEdge(A,nodeNames,'j3h5','h5',20);

%% 4. TSP 求解

function route = nearest_neighbor(D)
    n = size(D,1);
    used = false(1,n);
    route = zeros(1,n);
    route(1)=1;
    used(1)=true;
    for i=2:n
        cur=route(i-1);
        dist=D(cur,:);
        dist(used)=inf;
        [~,nxt]=min(dist);
        route(i)=nxt;
        used(nxt)=true;
    end
end

function route = two_opt(route,D)
    improved=true;
    L=length(route);
    while improved
        improved=false;
        for i=2:L-2
            for j=i+1:L-1
                d1 = D(route(i-1),route(i)) + D(route(j),route(j+1));
                d2 = D(route(i-1),route(j)) + D(route(i),route(j+1));
                if d2 < d1
                    route(i:j)=route(j:-1:i);
                    improved=true;
                    break;
                end
            end
            if improved, break; end
        end
    end
end

function total = path_length(route, D)
    total=0;
    for i=1:length(route)-1
        total = total + D(route(i),route(i+1));
    end
end

%% 5. 求每批最短路径 
juli = 0;

for dizhi_num = 1:length(dizhi)
    fprintf("\n========== 第 %d 批 ==========\n", dizhi_num);

    current = dizhi{dizhi_num};
    subnodes = [{'s'}, current];
    m = length(subnodes);

    subD = zeros(m);
    for i=1:m
        for j=1:m
            subD(i,j) = A(idx(subnodes{i}), idx(subnodes{j}));
        end
    end

    r0 = nearest_neighbor(subD);

    r  = two_opt(r0, subD);
    
    dist = path_length(r, subD);

    juli = juli + dist;

    names = subnodes(r);
    fprintf("路线： ");
    for k=1:length(names)
        if k<length(names)
            fprintf("%s -> ", names{k});
        else
            fprintf("%s\n", names{k});
        end
    end
    fprintf("距离 = %.2f 米\n", dist);
end

%% 6. 汇总输出 
fprintf("\n=============================================\n");
fprintf("所有批次总最短路径 = %.2f 米\n", juli);
fprintf("=============================================\n");
