
n = 5

if n > 0:
    print("Positive")
else:
    print("Negative")

print("Loop:")
for i in range(1, 6):
    if i == 3:
        continue
    if i == 5:
        break
    print(i)
