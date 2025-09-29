
def restrict(rel, dom):
   return set([(x,y) for x,y in rel if x in dom and y in dom])

# maybe should more specifically be , when there's multiple next ones, take the one who's maximal branch is smallest, i.e. if x,y,z are initial, how long can you go picking more things below x but not below y,z. 
def Sort(branch, order):
   sort = []
   unsorted = copy.deepcopy(branch)
   while len(unsorted) > 0:
      inserting = []
      for x in unsorted:
         if all([(x,y) not in order for y in unsorted]):
            inserting.append(x)
      for x in inserting:
         unsorted.remove(x)
         sort.append(x)
   return list(reversed(sort))


def TransitiveClosure(a):
    closure = set(a)
    while True:
        new_relations = set((x,w) for x,y in closure for q,w in closure if q == y)
        closure_until_now = closure | new_relations
        if closure_until_now == closure:
            break
        closure = closure_until_now
    return closure

def TotalRelation(domain, relation):
   total = True
   for x in domain:
      for y in domain:
         if not ((x,y) in relation or (y,x) in relation or x==y):
            total = False
            print(x,y)
   return total
   
def AntisymmetricRelation(domain, relation):
   anti= True
   for (x,y) in relation:
      if (y,x) in relation:
         anti=False
         print(x,y)
   return anti


def TestOrder(branch, order):
   if not AntisymmetricRelation(branch, order):
      print('Input order not Antisymmetric!!')
   order = TransitiveClosure(order)
   if not AntisymmetricRelation(branch, order):
      print('Closure not Antisymmetric!!')
   TotalRelation(branch, order)

#Assumes transitive(?)
#can take a guy who's before everyone , not a guy who's after everyone
def Sort(branch, order):
   if not AntisymmetricRelation(branch, order):
      print("Sort failed, order not antisymmetric")
      return None
   if not TotalRelation(branch, order):
      print('Warning: sorting partial order')
   sort = []
   unsorted = copy.deepcopy(branch)
   while len(unsorted) > 0:
      inserting = []
      for x in unsorted:
         if all([(x,y) not in order for y in unsorted]):
            inserting.append(x)
      for x in inserting:
         unsorted.remove(x)
         sort.append(x)
   return list(reversed(sort))


# could be quadratically smaller by not duplicating the set everywhere, but needs interface... otoh maybe it already is like this because of pass by referency stuff..??
def SymmetricReflexiveTransitive(dom, rel):
   equivalents = {x: set([x]) for x in dom}
   for (x,y) in rel:
      s = equivalents[x] | equivalents[y]
      for z in s:
         equivalents[z] = s
   return equivalents
   

# could be made faster if it matters. could start eliminations with the original generating links, which should be a covering set. would have to do when taking closure
#... yeah that's just much better isn't it? TODO
#def orderinfo(a):
#   rels=set(a)
#   dom = set([x for (x,y) in rels] + [y for (x,y) in rels])
#   leftwards = {}
#   for x in dom:
#      leftwards[x] = Leftwards(x, dom, rels)
#   reverserels = set([(y,x) for (x,y) in rels])
#   rightwards = {}
#   for x in dom:
#      rightwards[x] = Leftwards(x, dom, reverserels)
#   leftsuccessors = {}
#   for x in dom:
#      leftsuccessors[x] = copy.deepcopy(leftwards[x])
#      eliminated = {}
#      for y in leftsuccessors[x]:
#         eliminated[y] = False
#      for y in leftsuccessors[x]:
#         if not eliminated[y]:
#            for z in leftwards[y]:
#






# Assume closed
def Leftwards(x, dom, rel):
   return set([y for y in dom if (y,x) in rel])
   
# Assume closed
def Rightwardset(x, dom, rel):
   return [y for y in dom if (x,y) in rel]

def LeftwardSuccessors(x, dom, rel):
   lefts = Leftwards(x, dom, rel)
   return [z for z in lefts if all([(z,y) not in rel for y in lefts])]

def isTree(dom, rel):
   for x in dom:
      if not TotalRelation(Pastwardset(x, dom, rel), rel):
         print('not tree because of ', x)
#         return False
#   return True
# 
#Coglangs = ['en', 'de', 'la', 'grc', 'es', 'fr']
#def Initials(dom, rel):
#   inits = []
#   for x in dom:
#      if all([ not ((x,y) in rel and y[1] in Coglangs) for y in dom]):
#         inits.append(x)
#   return inits
#
