set(latex_count 8)
while(1)
	execute_process(
		COMMAND "egrep -s 'Rerun (LaTeX|to get cross-references right)' refman.log"
		RESULT_VARIABLE egrep_output
	)
	
	if( egrep_output OR NOT latex_count)
		break()
	endif()
	
	execute_process(COMMAND pdflatex refman)
	math(EXPR latex_count "${latex_count}-1")
endwhile()

