def hex2coe(input_hex):
    list = open(input_hex).read().splitlines()
    o = "memory_initialization_radix=16;\nmemory_initialization_vector=\n"

    for line in list:
        o += line + ',\n'

    #out = o[:-2] + ";"
    out = o[:-1]

    return out

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("input_hex")
    parser.add_argument("--output",'-o')
    args=parser.parse_args()
    out=hex2coe(args.input_hex)
    if args.output:
        of=open(args.output,"w")
    else:
        of=sys.stdout
    of.write(out)
