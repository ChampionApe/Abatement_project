import re

def functions_from_file(file):
	with open(file) as infile:
		r = infile.read()
	return functions_from_str(r)

def functions_from_str(string):
	a = re.findall(r"^.*?\$FUNCTION(.*?)\$ENDFUNCTION.*?$",string,re.IGNORECASE | re.DOTALL | re.MULTILINE)
	if a:
		b = ['$FUNCTION' + a[i] + '$ENDFUNCTION' for i in range(len(a))]
		return {function_name_from_str(b[i]): b[i] for i in range(len(b))}
	else:
		return ''

def function_name_from_str(string):
	return re.search(r"^.*?\$FUNCTION(.*?)\(.*?",string,re.IGNORECASE | re.DOTALL | re.MULTILINE).group(1).strip()

def lines_to_string(lines):
	out_str = ''
	for i in range(len(lines)):
		out_str += lines[i]
	return out_str