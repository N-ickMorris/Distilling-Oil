set P; #set of products
set C; #set of chemicals
set O; #set of crude oils bought
set D; #set of distilled oils made
set R; #set of cracked oils made

param l{C,P}; 		#min octane level in products
param q{O}; 		#cost of each crude oil per day
param m{O}; 		#max barr of each crude oil that can be bought per day
param u; 			#max barr of crude oils that can be processed into distilled oils per day
param b;			#max barr of distilled oils that can be process into cracked oils per day
param j{O}; 		#cost per barr to process crude oil into distilled oils
param n{D};			#cost per barr to process distilled oil into cracked oils
param z{C,D};		#octane level in distilled oils
param y{C,R};		#octane level in cracked oils
param s{P};			#sale per barr of products
param w{P};			#min barr of products to be made
param v{D,O};		#num of barr of distilled oils made from each barr of crude oil
param t{R,D};		#num of barr of cracked oils made form each barr of distilled oil
param k{D,P};		#num of barr of each distilled oil that make barr of each product
param i{R,P};		#num of barr of each cracked oil that make barr of each product

var a{O} >= 0;		#barr of each crude oil bought
var f{D} >= 0;		#barr of each distilled oil to be cracked
var g{D,P} >= 0;	#barr of each distilled oil to each product
var h{R,P} >= 0;	#barr of each cracked oil to each product

maximize Profit: sum{d in D, p in P}(s[p]*k[d,p]*g[d,p]) + sum{r in R, p in P}(s[p]*i[r,p]*h[r,p]) - sum{o in O}(q[o]*a[o]) - sum{o in O}(j[o]*a[o]) - sum{d in D}(n[d]*f[d]);
s.t. ProductBarr{p in P}: sum{d in D}g[d,p] + sum{r in R}h[r,p] >= w[p];
s.t. CrudeLimit{o in O}: a[o] <= m[o];
s.t. DistilledLimit: sum{o in O}a[o] <= u;
s.t. CrackedLimit: sum{d in D}f[d] <= b;
s.t. DistilledBarr{d in D}: sum{o in O}v[d,o]*a[o] - f[d] - sum{p in P}g[d,p] = 0;
s.t. CrackedBarr{r in R}: sum{d in D}t[r,d]*f[d] - sum{p in P}h[r,p] = 0;
s.t. OctaneLevel{p in P}: sum{d in D, c in C}z[c,d]*k[d,p]*g[d,p] - sum{d in D, c in C}l[c,p]*k[d,p]*g[d,p] + sum{r in R, c in C}y[c,r]*i[r,p]*h[r,p] - sum{r in R, c in C}l[c,p]*i[r,p]*h[r,p] >= 0;
