L = 200*10^-3; 
d = 20*10^-3; 
Z1 = 20*10^-3; 
Z2 = 120*10^-3; 
p = 2*10^-3;
l_123 = (2*L)+Z2; 
l_3 = L; 
l_13 = L+Z2; 
l_23 = l_13;
N123 = l_123/p; 
N3 = l_3/p; 
N13 = l_13/p; 
N23 = l_23/p;
L123 = indhelical(N123,d/2,l_123);
L3 = indhelical(N3,d/2,l_3);
L13 = indhelical(N13,d/2,l_13);
L23 = indhelical(N23,d/2,l_23);
M23 = 0.5*(L123+L3-L13-L23)
 