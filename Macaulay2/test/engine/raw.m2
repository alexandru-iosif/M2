--		Copyright 1996-2004 by Daniel R. Grayson

-- test engine.d, interface.d, and engine.m2

load "raw-util.m2"
show := s -> << s << " --> " << value s << endl
errorDepth = 0


------------------------
-- Monomial Orderings --
------------------------
rawMonomialOrdering {Position => Up, Lex => 3, LexTiny => 4, GRevLex => {1,2,3}}
rawMonomialOrdering {Lex => 1, LexSmall => 2, LexTiny => 4}
rawMonomialOrdering {GRevLex => {1,1,1}, GRevLexSmall => {2,2}, GRevLexTiny => {4,4,4,4}}
rawMonomialOrdering {GroupLex => 3, NCLex => 4, Weights => {3,4,5}}

makeMonomialOrdering( null, false, 0, {1,2,3,4,5,6,7,8}, {}, {} )
makeMonomialOrdering( null, false, 4, {1,2,3,4,5,6,7,8}, {}, {} )
makeMonomialOrdering( null, false, 10, {1,2,3,4,5,6,7,8}, {}, {} )
makeMonomialOrdering( null, true,  10, {1,2,3,4,5,6,7,8}, {}, {} )
makeMonomialOrdering( null, true,  10, {1,2,3,4,5,6,7,8}, {}, {GRevLex} )
makeMonomialOrdering( null, true,  10, {1,2,3,4,5,6,7,8}, {}, {Lex} )
makeMonomialOrdering( null, true,  10, {1,2,3,4,5,6,7,8}, {}, {Lex=>3} )
makeMonomialOrdering( null, false, 10, {1,2,3,4,5,6,7,8}, {}, {3,4} )
makeMonomialOrdering( null, false, 0, {1,2,3,4,5,6,7,8}, {}, {Lex => 3, Weights => {3,4}, GroupLex => 2, NCLex => 2} )
makeMonomialOrdering( null, false, 0, {1,2,3,4,5,6,7,8}, {}, {GRevLex => 3, 5, Weights => {3,4}, GRevLexTiny => 2} )
makeMonomialOrdering( null, false, 14, {1,2}, {}, {GRevLex => 3, Weights => {3,4}, GRevLexTiny => 2} )
makeMonomialOrdering( null, false, 0, {1,2,3,4,5,6,7,8}, {}, {Eliminate 4} )
makeMonomialOrdering( null, false, 0, {1,2,3,4,5,6,7,8}, {}, {ProductOrder{4,5,6}} )
makeMonomialOrdering( null, false, 0, {1,2,3,4,5,6,7,8}, {3,4,5}, {LexTiny => 3, GRevLexSmall => 3} )
makeMonomialOrdering( null, false, 20, {1,2,3,4,5,6,7,8}, {{3,4,5},{6,7}}, {LexSmall => 3} )



Z = rawZZ()
i = 14_Z

assert( raw 14 === i )
assert( rawToInteger i === 14 )
assert( rawToInteger i === new ZZ from i )

j = 3_Z
j' = 3_Z
k  = 27_Z

3.5_Z

-- not implemented yet:
-- (toBigRR 3.5)_Z

i+j
i-j
-j
i*j
q = i//j
r = i%j
assert( i != j )
assert( j == j' )
assert( (i+j)*k == i*k + j*k )
assert( q * j + r == i )



-- try single grading

errorDepth = 0
trivial = rawPolynomialRing()

k = rawZZp(101)
3_k
assert( 3_k == 3 )
assert( 3 == 3_k )
assert( 2_k + 7_k == 9_k)
-1_k
assert( 100_k == -1_k )
10 * 10_k
10_k * 10
assert( 10*10_k == -1_k )
assert( 101_k == 0 )
assert( toString ( -1_k ) == "-1" )

1_k // 10_k
assert( 1_k // 10_k == -10 )
assert( 1 // 10_k == -10 )
assert( 1_k // 10 == -10 )
assert( 1_k // 10_k != -1 )

assert( 1_k - 10_k == 92 )
assert( 1 - 10_k == 92 )
assert( 1_k - 10 == 92 )

degs = {{1},{1},{1}}
m' = makeMonomialOrdering( null, false, 3, degs / first, {}, {} )
n' = rawMonoid(m',{"x","y","z"},degring 1,flatten degs)


rawProductMonomialOrdering (m',m',m')
rawProductMonomialOrdering m'
rawProductMonomialOrdering ()


R = rawPolynomialRing(rawZZ(),n')
x = R_0
y = R_1
z = R_2

assert( rawTerm(R, 3_Z, rawVarMonomial(1,4)) === 3*y^4 )

rawRing x
ring x

rawRingVar(R,1,11)
assert( rawRingVar(R,1,11) == y^11 )

degree y^10
assert( try ( degree 0_R ; false ) else true )
rawDegree (x^10+x^3, {4,5,6})
rawDegree (x^2 + x + y^5 + z^10, {1,0,0})
rawDegree (z^10, {4,5,6})

assert( rawIsHomogeneous ( x^2 + y^2 ))
assert( not rawIsHomogeneous ( x^2 + y ))

f = (x+1)^5

assert( someTerms(f,2,2) == 10*x^3+10*x^2 )

assert( size f == 6 )
f' = (x+1)^5
g = (x-1)^6
h = (x^2+x+1)^5
<< "COMMENTED OUT CRASH" << endl;
--q = g // h
--r = g %  h
--assert( g == q*h + r )
assert( f != g )
assert( f == f' )
rawHomogenize(f,2,{1,1,1})
assert( rawHomogenize(f,2,{1,1,1}) == (x+z)^5 )
assert( rawHomogenize(f,2,10,{1,1,1}) == (x+z)^5*z^5 )

leadCoefficient f
leadMonomial f
rawPairs f
assert( 1_Z === leadCoefficient f )
assert( rawVarMonomial(0,5) === leadMonomial f )

assert( ((),()) == rawPairs 0_R )
assert( try ( leadCoefficient 0_R ; false ) else true )
assert( try ( leadMonomial    0_R ; false ) else true )
assert( try ( rawDegree (0_R, {4,5,6}) ; false ) else true )

hash f
hash f'
hash g

F = R^4
assert( F === R^4 )
assert( degrees F === {0, 0, 0, 0})
degs = splice {4:-3,3:5}
P = R^-degs
assert( degrees P === degs )
assert( F =!= P )
assert( rank F == 4 )
assert( rank P == 7 )

f = rawMatrix1(F,2,(x^3,y*z,x,y^2,x^3),0)

<< "rawCoefficients isn't tested correctly here" << endl
entries f
f
mf = rawMonomials((1,2),f)
--rawCoefficients((1,2), mf, f)
show "entries f"
show "f"
show "rawMonomials((1,2),f)"				    -- I don't know what this does
--show "rawCoefficients((0,0),(3,3),f)"			    -- I don't know what this does

assert( F === target f )
assert( R^2 === R^2 )
assert( R^2 =!= R^3 )
degrees source f
assert( {3,2} == degrees source f )
assert( R^{-3,-2} === source f )
<< "f = " << f << endl
<< "f+f = " << f+f << endl
<< "-f = " << -f << endl
<< "f-f = " << f-f << endl
<< "2*f = " << 2*f << endl
<< "x*f = " << x*f << endl

assert( f+f == 2*f )
assert( -f == (-1) * f )
-- assert( f-f == 0 )

-- mutable matrix

assert not rawIsMutable f
h = rawMatrixRemake1 (rawTarget f, f, true, 0)		    -- mutable!
assert rawIsMutable h
<< "h = " << h << endl
assert( f == rawMatrixRemake2(rawTarget h,rawSource h, rawMultiDegree h, h, 0) )
assert( y^2 == rawMatrixEntry(f,1,1) )
assert( x^3 == rawMatrixEntry(f,2,0) )
assert( y^2 == rawMatrixEntry(h,1,1) )
assert( x^3 == rawMatrixEntry(h,2,0) )
rawMatrixEntry(h,1,1,y^4)
<< "h = " << h << endl
assert( y^4 == rawMatrixEntry(h,1,1) )
assert( y^2 != y^4 )

rawMatrixRowChange(h,0,x,1,false)
rawMatrixRowChange(h,0,y,2,false)
<< "h = " << h << endl

rawMatrixColumnChange(h,0,x,1,false)
rawMatrixColumnChange(h,1,-y,0,false)
<< "h = " << h << endl

rawMatrixColumnSwap(h,0,1)
<< "h = " << h << endl

-- fraction ring

stderr << "warning: rawFraction not implemented yet" << endl
-- G = rawFractionRing R
-- r = rawFraction(G,x,y)
-- assert( r == rawFraction(G,x*z,y*z) )
-- assert( toString rawFraction(G,x,y) === "x/y" )
-- assert( r // r == 1_G )
-- assert( rawIsHomogeneous r )
-- assert( degree r == {0} )
-- assert( not rawIsHomogeneous rawFraction(G,x,y+1) )
-- 
-- assert( 11_G === 11_R_G )
-- assert( 11_R === 11_Z_R )
-- assert( 11_G === 11_Z_R_G )

-----------------------------------------------------------------------------

R = rawPolynomialRing(rawZZ(), n')
S = rawWeylAlgebra(R, {1}, {2}, -1)
x = S_0							    -- ../m2/engine.m2:177:26: zero divisor found
                                                            -- this is because the fraction ring code above is
							    -- findin a zero divisor, but an error is not being produced
							    -- then, as it should.  NEEDS TO BE FOUND
y = S_1
z = S_2

y*z
z*y
assert( z*y - y*z == 1 )
assert( x*y == y*x )
assert( x*z == z*x )

(y+z)^5

-----------------------------------------------------------------------------

Q = rawFractionRing Z
x = 21 // 34_Q
y = -4 // 13_Q
z = 13 // -12_Q

assert( (x+y)*z == x*z + y*z )
assert( z^5 == (1//z)^-5 )
assert( numerator x === 21_Z )
assert( denominator x === 34_Z )
assert( fraction(Q,21_Z,34_Z) === x )
assert( fraction(Q,21_Z,34_Z) === fraction(Q,31*21_Z,31*34_Z) )

assert( toString x === "21/34" )

R = rawPolynomialRing(k,n')
T = rawSchurRing R
x = T_0
y = T_1
z = T_2
x*y
y^2

-- try bigrading

degs = {};
doublyGradedOrdering = makeMonomialOrdering( null, false, 2, degs, {}, {GroupLex => 2} )
doublyGraded = rawMonoid(doublyGradedOrdering,{"s","t"},trivial,degs)
doublyGradedRing = rawPolynomialRing(rawZZ(), doublyGraded)

degs = {{2,3}, {1,0}, {1,1}}
m'' = makeMonomialOrdering( null, false, 3, degs / first, {}, {2,1} )
n'' = rawMonoid(m'',{"x","y","z"},doublyGradedRing,flatten degs)

R = rawPolynomialRing(rawZZ(),n'')
x = R_0
y = R_1
z = R_2

assert( degree x == degs_0 )
assert( degree y == degs_1 )
assert( degree z == degs_2 )

assert( 11_Z == rawLift(Z,11_R))
assert( 11_R == 11_Z_R )

-- rawPolynomialRing(K,M)
-- rawSkewPolynomialRing(R, skewvars)
-- rawWeylAlgebra(R, {x=>D_x, h})
-- rawSolvableAlgebra(R, P, Q)
-- rawColon(R,M) -- R is a polynomial ring, skew poly, Weyl or solvable algebra
--   R can be ZZ
--   R can be poly,skew,weyl.  Is the quotient by a 2-sided ideal in these noncomm 
--     cases?
--   R can be associative algebra.  Here the quotient is definitely by a 2-sided ideal.
-- rawFractionRing(R) -- R must be a polynomial or quotient of a poly ring.
-- rawLocalRing(R,P)
-- rawZZ()
-- rawZZp(p)
-- rawGF(R,primelement)
-- rawQQ()
-- rawRR()
-- rawCC()
-- rawBigRR()
-- rawBigCC()
-- rawAssociativeRing(K,noncommM)
-- rawQuiverAlgebra(R,quiver)
-- Other rings to implement:
--   QQclosure
--   blackbox
--   multivariatePolynomialRing -- no quotients allowed.
--   power series rings, Puiseaux expansions?

-- Example rings to add: group rings, quaternions, Clifford algebras
--   blowup ring, exterior algebra of a module, Tor(k,k), ...
--   Lie algebra rings too.

-- flattenRing R
-- flattenIdeal R -- a GB of the quotient ideal, of R in flattenRing R.

P = rawPolynomialRing(rawZZ(), singlemonoid(symbol x, symbol y, symbol z))
x = P_0
y = P_1
z = P_2
x^2

E = rawSkewPolynomialRing(P, {0,1,2})

x = E_0
y = E_1
z = E_2
x*y
y*x
assert(x*y == -y*x)
assert(x*x == 0)
assert(x^2 == 0)

-- Local Variables:
-- compile-command: "M2 -e errorDepth=0 --stop -e 'input \"raw.m2\"' -e 'exit 0' "
-- End:
