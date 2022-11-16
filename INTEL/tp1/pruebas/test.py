def grupos(mw:int, wt:list):
    n = len(wt)
    i = 0
    suma = 0
    count = 0
    pack = []
    while n > 0:
        while suma < mw and i<len(wt):
            if wt[i] != 0 and suma+wt[i] <= mw:
                suma+=wt[i]
                pack.append(wt[i])
                wt[i] = 0
                n = n-1
            i+=1
        count += 1
        print(count,pack, suma)
        pack = []
        suma = 0
        i = 0


 
wt = [8,7,6,9,5,11,5,9,4,1,1,1,1,3,5]
mw = 11
print("ORDENADO")
grupos(mw, sorted(wt, reverse=True))
print("\nDESORDENADO")
grupos(mw, wt)