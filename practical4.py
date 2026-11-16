
import ast

tree = ast.parse(input("Enter expression: "), mode="eval")

def show(n, p=0):
    name = getattr(n, "id", getattr(n, "value", type(n).__name__))
    print("  " * p + str(name))
    for x in ast.iter_child_nodes(n):
        if not isinstance(x, ast.expr_context):
            show(x, p+1)

print("\nAST Tree:")
show(tree)

