import time
s = time.time()
a=0
for i in range(1000000):
    a+=1
print(time.time()-s)