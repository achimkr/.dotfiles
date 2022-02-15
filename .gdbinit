source /home/achim/.gdbinit-gef.py
set auto-load safe-path /

# LIBFIRM GDB FUNCTIONS
set unwindonsignal on

# FIRM

# The following is able to print most important firm datastructures:
# ir_node*, tarval*, ir_type*, ir_mode* and maybe others should work
define irn
print gdb_node_helper($arg0)
end

# Hack to display the length of a firm ARR_F or ARR_D
define arrlen
p array_len($arg0)
end

define dumpg
if $argc == 1
        if is_ir_graph($arg0)
                call dump_ir_graph($arg0, "XXX")
        else
        if is_ir_node($arg0)
                call dump_ir_graph(get_irn_irg($arg0), "XXX")
        else
                printf "Cannot determine graph of given argument\n"
        end
        end
else
        call dump_ir_graph(current_ir_graph, "XXX")
end
end

define firmd
call firm_debug($arg0)
end

define graph
if $argc == 1
        if is_ir_graph($arg0)
                print gdb_node_helper($arg0)
        else
        if is_ir_node($arg0)
                print gdb_node_helper(get_irn_irg($arg0))
        else
                printf "Cannot determine graph of given argument\n"
        end
        end
else
        call dump_ir_graph(current_ir_graph, "XXX")
end
end

define keep
call add_End_keepalive(get_irg_end(get_irn_irg($arg0)), $arg0)
end

# cparser
define cpexpr
call print_expression($arg0), (void)putchar('\n')
end

define cpstmt
call print_statement($arg0)
end

define cptype
call print_type($arg0), (void)putchar('\n')
end

define javadebug
  handle SIGUSR1 nostop pass
  handle SIGSEGV nostop pass
  handle SIGILL  nostop pass
  handle SIGQUIT nostop pass
end
