
import ast

t = 0

def gen(n):
    global t
    if isinstance(n, ast.BinOp):
        x, y = gen(n.left), gen(n.right)
        t += 1
        op = {ast.Add:"+", ast.Sub:"-", ast.Mult:"*", ast.Div:"/"}[type(n.op)]
        print(f"t{t} = {x} {op} {y}")
        return f"t{t}"
    return n.id

s = input("Enter expression: ")
a, e = s.split("=")
print(a, "=", gen(ast.parse(e, mode="eval").body))
