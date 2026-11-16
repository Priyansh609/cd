
n = int(input("Enter productions: "))
g = {}

for _ in range(n):
    a, b = input().replace(" ", "").split("=")
    g[a] = b.split("|")

# Remove indirect and direct left recursion
for i, a in enumerate(list(g)):
    for b in list(g)[:i]:
        g[a] = [x.replace(b, y, 1) if x.startswith(b) else x
                for x in g[a] for y in g[b]]

    p = g[a]
    x = [r[1:] for r in p if r.startswith(a)]
    y = [r for r in p if not r.startswith(a)]

    if x:
        b = a + "'"
        g[a] = [r+b for r in y]
        g[b] = [r+b for r in x] + ['#']

# Left factoring
for a in list(g):
    p = g[a]
    for x in p:
        for y in p:
            if x != y:
                k = 0
                while k < min(len(x),len(y)) and x[k] == y[k]:
                    k += 1
                if k:
                    b = a + "'"
                    g[a] = [r for r in p if not r.startswith(x[:k])] + [x[:k]+b]
                    g[b] = [r[k:] or '#' for r in p if r.startswith(x[:k])]
                    break
        else:
            continue
        break

print("\nOptimized Grammar:")
for a, p in g.items():
    print(a, "->", " | ".join(p))
