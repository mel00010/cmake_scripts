#!/usr/bin/env python3

import os
import sys
import itertools
from enum import Enum
import shlex

def main():
    if len(sys.argv) < 3:
        return
    with open(sys.argv[1], 'r') as resources_file:
        args = shlex.split(resources_file.read())
        with open(sys.argv[2], 'w') as out_file:
            # Add include guard
            out_file.write("#ifndef RESOURCES_HPP_\n")
            out_file.write("#define RESOURCES_HPP_\n\n")
            
            # Add header includes=
            out_file.write("#include <ResourceDefs.hpp>\n")
            out_file.write("\n")
            out_file.write("#include <cstddef>\n")
            out_file.write("#include <utility>\n\n")
            
            # Add namespace declaration
            out_file.write("namespace " + sys.argv[3] + " {\n\n")
            
            # Declare ResourceID enum
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
            
            # Add Resource<ResourceID> array declaration
            out_file.write("static constexpr Resource<ResourceID> Resources[] = {\n")
            
            class State(Enum):
                ID = 1
                TYPE = 2
                PATH = 3
            
            # Add array contents
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
            out_file.write("\n};\n\n")
            
            # Add getResource convenience function
            out_file.write("constexpr inline Resource<ResourceID> getResource(ResourceID id) {\n")
            out_file.write("\treturn Resources[static_cast<size_t>(id)];\n")
            out_file.write("}\n\n")
            out_file.write("} /* namespace " + sys.argv[3] + " */\n\n\n")
            
            out_file.write("#endif /* RESOURCES_HPP_ */\n")
if __name__ == '__main__':
    main()