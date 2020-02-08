function Simi = computeSimi(data)
D = pdist(data); %
Simi=squareform(D); %
end