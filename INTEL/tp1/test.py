def grupos(w:int, wt:list, n:int, suma:int, package:list):
    if n>0:
        if suma+wt[0] <= w:
            for i in range(n):
                print(i)
                package.append(wt[i])
                suma += wt[i]
                wt.pop(i)
            grupos(w, wt, n-1, suma, package)
        else:
            print("pack:",package)
            grupos(w, wt, n, 0, [])

 
 
wt = [8,7,6,9,5,11,5,9,4,1,1,1,1,3,5]
w = 11
n = len(wt)
grupos(w, wt, n, 0, [])