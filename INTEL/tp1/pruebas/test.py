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


 
wts = [[8,7,6,9,5,11,5,9,4,1,1,1,1,3,5],[2,9,8,5,6,2,4,7,8,5,4,10,10,4,2],[7,9,1,6,4,2,2,6,1,3,8,1,5,9,7]]
mw = 11
for wti in range(len(wts)):
    print("\n---------",wts[wti],"-----------\ORDENADO", wti+1, "Elementos:", len(wts[wti]))
    grupos(mw, sorted(wts[wti]))
    print("\n---------",wts[wti],"-----------\nDESORDENADO", wti+1, "Elementos:", len(wts[wti]))
    grupos(mw, wts[wti])