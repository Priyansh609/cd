
types = {"a": int, "b": float, "c": str}

values = {"a": 10, "b": 20, "c": "Hello"}

for name, value in values.items():
    if type(value) == types[name]:
        print(name, "Type is Correct")
    else:
        print(name, "Type Error")
