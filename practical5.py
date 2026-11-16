
n = int(input("Enter number of productions: "))
g = {}

for _ in range(n):
    a, b = input().replace(" ", "").split("=")
    g[a] = b.split("|")

N = list(g)
first = {a: set() for a in N}
follow = {a: set() for a in N}

def getfirst(s):
    r = set()
    for x in s:
        if x not in N:
            r.add(x)
            break
        r |= first[x] - {'#'}
        if '#' not in first[x]:
            break
    else:
        r.add('#')
    return r

while True:
    old = str(first)
    for a in N:
        for p in g[a]:
            first[a] |= getfirst(p)
    if old == str(first):
        break

follow[N[0]].add('$')

while True:
    old = str(follow)
    for a in N:
        for p in g[a]:
            for i, x in enumerate(p):
                if x in N:
                    f = getfirst(p[i+1:])
                    follow[x] |= f - {'#'}
                    if '#' in f or i == len(p)-1:
                        follow[x] |= follow[a]
    if old == str(follow):
        break

for a in N:
    print("FIRST(", a, ") =", first[a])
    print("FOLLOW(", a, ") =", follow[a])

