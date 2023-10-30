extends Resource
class_name As

static func demo_usage():
	print("These are booleans: %s %s" 
		% [tf(true), tf(false)])
	print("These are numbers:  %s %s" 
		% [comma_int(1234), comma(1234.567, 2)])
	print("This is scientific:  %s  %s" 
		% [scientific(0.000123), scientific(1234.56)])
	print("This is compact: %s %s" 
		% [compact(1234567.89), compact(1234578.90)])
	print("Call like:  As.comma(234.45)  ")
	
	
static func tf(b: bool):
	return 't' if b else 'f'

static func comma_int(n:int):
	var result := ""
	var i: int = n if n > 0 else -n

	while i > 999:
		result = ",%03d%s" % [i % 1000, result]
		i /= 1000

	return "%s%s%s" % ["-" if n < 0 else "", i, result]

static func scientific(n: float, places:int = 2) -> String:
	if is_nan(n) or is_inf(n):
		return str(n)   # seems like best case
	var e = 0
	while abs(n) < 1.0:
		e -= 1
		n *= 10.0
	while abs(n) >= 10.0:
		e += 1
		n *= 0.1
	# 1 <= na < 10	
	return "%1.*fe%s" % [places, n, comma_int(e)]
	
static func comma(n: float, places:=2) -> String:
	if places == 0:
		return comma_int(int(round(n)))
	else:
		var decimal_part = abs(n) - int(abs(n))  # e.g., .23 in -1.23
		var decimal_str = ("%.*f" % [places, decimal_part]).right(1)
		return comma_int(int(n)) + decimal_str
	
static func compact(n:float, places:=2)-> String:
	# commas from 0.01 to 10 million, else scientific
	var na = abs(n)
	if na == 0 or na >= 0.01 and na < 1e7:
		return comma(n, places)
	else:  # exponent
		return scientific(n, places)
		
static func _co(n, places, expected):
	var o = compact(n, places)
	if o != expected:
		print("for [%f, %d] expected :%s: got :%s:" % [n, places, expected, o])

static func _ci(n, expected):
	var o = comma_int(n)
	if o != expected:
		print("for %d expected :%s: got :%s:" 
			% [n, expected, o])

static func _c(n, p, expected):
	var o = comma(n, p)
	if o != expected:
		print("for (%f,%d) expected :%s: got :%s:"
			% [n, p, expected, o])

static func _s(n, p, expected):
	var o = scientific(n, p)
	if o != expected:
		print("for (%f,%d) expected :%s: got :%s:"
			% [n, p, expected, o])

static func test_As():
	print("start test of As")
	_co(9, 0, "an expected error")
	_co(0, 0, "0")
	_co(0, 2, "0.00")
	_co(0.01, 2, "0.01")
	_co(234, 2, "234.00")
	_co(1234, 2, "1,234.00")
	_co(2000, 0, "2,000")
	_co(1234, 0, "1,234")
	_co(123456, 0, "123,456")
	_co(1234567.899, 0, "1,234,568")
	_co(1234567.899, 2, "1,234,567.90")
	_co(12345678.9, 2, "1.23e7")
	_co(0.00001, 2, "1.00e-5")
	_co(-0.000001288, 2, "-1.29e-6")
	_co(1.236e25, 2, "1.24e25")
	_co(1e25, 2, "1.00e25")
	_co(1e23, 2, "1.00e23")
	_ci(0, "an expected error")
	_ci(1234, "1,234")
	_ci(1004, "1,004")
	_ci(-1004, "-1,004")
	_ci(-123456, "-123,456")
	_c(0.0, 0, "0")
	_c(0.0, 2, "0.00")
	_c(0.123, 2, "0.12")
	_c(-1.238, 2, "-1.24")
	_c(-123456.789, 2, "-123,456.79")
	_s(0.00001234, 2, "1.23e-5")
	_s(log(-2.0), 3, "nan")
	_s(1.0e512, 1, "inf")
	print("done with test As")
	
	
