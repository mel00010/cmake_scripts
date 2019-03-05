#!/usr/bin/env python3

import os
import sys
import itertools
from enum import Enum
import shlex

def main():
    
    if len(sys.argv) < 2:
        return
    with open(sys.argv[1], 'r') as resources_file:
#         print("Test")
        args = shlex.split(resources_file.read())
        with open(sys.argv[2], 'w') as out_file:
            out_file.write("#ifndef RESOURCES_HPP_\n")
            out_file.write("#define RESOURCES_HPP_\n\n")
            
            out_file.write("#include <cstddef>\n")
            out_file.write("#include <utility>\n\n")
            
            out_file.write("enum class ResourceID : size_t {\n")
            first_in_list = True
            for i in args[0::3]:
                if not first_in_list:
                    out_file.write(",\n")
                out_file.write("\t\t" + i)
                if first_in_list:
                    out_file.write(" = 0")
                first_in_list = False
    
            out_file.write("\n};\n\n")
            out_file.write("enum class ResourceType : size_t {\n")
            out_file.write("\t\tSHADER,\n")
            out_file.write("\t\tIMAGE,\n")
            out_file.write("\t\tMODEL,\n")
            out_file.write("\t\tOTHER\n")
            out_file.write("};\n\n")
            
            out_file.write("class Resource {\n")
            out_file.write("\tpublic:\n")
            out_file.write("\t\tResourceID id;\n")
            out_file.write("\t\tResourceType type;\n")
            out_file.write("\t\tconst char* file_path;\n")
            out_file.write("};\n\n")
            out_file.write("static constexpr Resource Resources[] = {\n")
            
            class State(Enum):
                ID = 1
                TYPE = 2
                PATH = 3
            
            # ID first, Type second, Path third
            first_in_list = True
            state = State.ID
            for i in args:
                if state == State.ID:
                    if not first_in_list:
                        out_file.write(",\n")
                    out_file.write("\t\t{ResourceID::" + i + ", ")
                    state = State.TYPE
                    continue
                elif state == State.TYPE:
                    out_file.write("ResourceType::" + i + ", \"")
                    state = State.PATH
                    continue
                elif state == State.PATH:
                    out_file.write(i + "\"}")
                    first_in_list = False
                    state = State.ID
                    continue
            out_file.write("\n};\n\n\n")
                
            out_file.write("#endif /* RESOURCES_HPP_ */\n\n")
if __name__ == '__main__':
    main()