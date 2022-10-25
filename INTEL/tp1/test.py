packages = []
is_exit = False
max_packages = -1
i = 0

while max_packages <= 0 or max_packages > 20:
    max_packages = int(input("Ingrese la cantidad de paquetes (1-20): "))

while i<=max_packages and not is_exit:
    weight = int(input("Ingrese el peso del paquete nº"+str(i+1)+" (ingrese -1 para terminar de ingresar): "))
    if weight == -1:
        is_exit = True
    else:
        if weight > 11 or weight <= 0:
            print("Peso invalido (1-11)")
        else:
            packages.append(weight)
            i+=1

print(packages)