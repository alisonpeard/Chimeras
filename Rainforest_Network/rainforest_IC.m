function y0 = rainforest_IC

%Takes Species-Area Relationships into account to scale initial populations
%to size of fragment
weights = ones(1,22);
weights(1) = 2.3; weights(5) = 2.3; weights(12) = 2.3; weights(16) = 2.3; 
weights(3) = 0.43; weights(4) = 0.43; weights(7) = 0.43; weights(10) = 0.43; weights(11) = 0.43;
weights(14) = 0.43; weights(15) = 0.43; weights(18) = 0.43; weights(21) = 0.43; weights(22) = 0.43;
y = rand*0.4;
y0 = y.*weights;

end