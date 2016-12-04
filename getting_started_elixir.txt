**Getting started with elixir**

* type "h" in the shell to print information on how to use
   the shell

**Basic arithmetic, Booleans, Atoms**

* 5/2 : returns float
* supports div, rem
* supports hexadecimal, octal, binary using the notation 0x, 0o, 0b respectively

* Floats in Elixir are 64 bit double precision
* Supports exponent number , ex: 1.0e-10
* supports round() to round of to next higher digit, trunc() to truncate the number

* to compare use  "==" ex: true == true
* predicate functions to check for a value type "is_boolean", "is_integer", "is_float", "is_number"

* atoms are constants where their name is their own value ex:    :hello, :world
		:hello == :world
		iex> false

* the boolean "true" and "false"  are atoms


**Strings**

* Strings in Elixir are inserted between double quotes, and they are encoded in UTF-8:

* Elixir also supports string interpolation:

		iex> "hellö #{:world}"
		"hellö world"

* use escape sequence for line breaks "\n" and IO.puts to print them

* Strings in Elixir are represented internally by binaries which are sequences of bytes:

		iex> is_binary("hellö")
		true

* to get the byte size of a string use and to get string length (i.e number of character) use String.length("hello")

		iex> byte_size("hello") 
		5

* supports String.upcase, String.downcase to convert strings

* String concatenation is done using "<>"

		iex> "foo" <> "bar"
		"foobar"

**Anonymous functions**

* they are defined using the keywords fn and end

		iex> add = fn a, b -> a + b end
		#Function<12.71889879/2 in :erl_eval.expr/5>
		iex> is_function(add)
		true
		iex> is_function(add, 2)
		true
		iex> is_function(add, 1)
		false
		iex> add.(1, 2)
		3

		iex> double = fn a -> add.(a, a) end
		#Function<6.71889879/1 in :erl_eval.expr/5>
		iex> double.(2)
		4

* a variable assigned inside a function does not affect its surrounding environment:

		iex> x = 42
		42
		iex> (fn -> x = 0 end).()
		0
		iex> x
		42

**Lists**

		iex> [1, 2, true, 3]
		[1, 2, true, 3]
		iex> length [1, 2, 3]
		3
* to add or subtract two lists use  ++/2 or --/2

		iex> [1, 2, 3] ++ [4, 5, 6]
		[1, 2, 3, 4, 5, 6]
		iex> [1, true, 2, false, 3, true] -- [true, false]
		[1, 2, 3, true]

* to get head use hd and to get tail use tl of a list

		iex> list = [1, 2, 3]
		iex> hd(list)
		1
		iex> tl(list)
		[2, 3]

* When Elixir sees a list of printable ASCII numbers, 
  Elixir will print that as a char list (literally a list
  of characters),use i/1 to retrieve info about a value 
  retrieve from a  list

		 iex> [11, 12, 13]
		'\v\f\r'
		iex> [104, 101, 108, 108, 111]
		'hello'
		iex> i 'hello'
		Term
		  'hello'
		Data type
		  List
		Description
		  ...

* single-quoted and double-quoted representations are 
not equivalent in Elixir as Single-quotes are char lists,
 double-quotes are strings

	 	iex> 'hello' == "hello"
		false

**Tuples**

* Tuples store elements contiguously in memory

		iex> tuple = {:ok, "hello"}
		{:ok, "hello"}
		iex> elem(tuple, 1)
		"hello"
		iex> tuple_size(tuple)
		2

* put element in a list using put_elem/3 , 
(list name, index,value)

		iex> tuple = {:ok, "hello"}
		{:ok, "hello"}
		iex> put_elem(tuple, 1, "world")
		{:ok, "world"}
		iex> tuple
		{:ok, "hello"}

** Lists or Tuples**

* List accessing linear operation but updating is fast
* tuples accessing is fast by index but updating or adding is costly as it 
requires copying the whole tuple in memory

**Boolean Operators**

* and, or & not for checking condition. They accept boolean value and raise exception if non-boolean is supplied

* Elixir provides ||, && and ! which accept arguments of any type.
* Comparision operators ==, !=, ===, !==, <=, >=, <, and >
* Sorting order number < atom < reference < function < port < pid < tuple < map < list < bitstring


**Pattern matching**

* If an atom is on a tuple/list then that atom must reamin in the value tuple/list otherwise an error will be thrown
* List supports matching on its own head and tail

		iex> [head | tail] = [1, 2, 3]
		[1, 2, 3]
		iex> head
		1
		iex> tail
		[2, 3]


**The Pin operator**

* The pin operator is used to match values if the left side and right side matches then it's ok otherwise it will throw an error

		iex> x = 1
		1
		iex> ^x = 2
		** (MatchError) no match of right hand side value: 2
		iex> {y, ^x} = {2, 1}
		{2, 1}
		iex> y
		2
		iex> {y, ^x} = {2, 2}
		** (MatchError) no match of right hand side value: {2, 2}

* In a list if we don't require any other value except the head then we can bind that value to "_"

		iex> [h | _] = [1, 2, 3]
		[1, 2, 3]
		iex> h
		1

* We cannot use Pattern matching in function calls

**Case, Cond, and If**

**Case**
* case allows us to compare a value against many patterns until we find a matching one:

		iex> case {1, 2, 3} do
		...>   {4, 5, 6} ->
		...>     "This clause won't match"
		...>   {1, x, 3} ->
		...>     "This clause will match and bind x to 2 in this clause"
		...>   _ ->
		...>     "This clause would match any value"
		...> end
		"This clause will match and bind x to 2 in this clause"

* Clauses also allow extra conditions to be specified via guards

		iex> case {1, 2, 3} do
		...>   {1, x, 3} when x > 0 ->
		...>     "Will match"
		...>   _ ->
		...>     "Would match, if guard condition were not satisfied"
		...> end
		"Will match"


* Note: errors in guards do not leak but instead make the guard fail:

		iex> hd(1)
		** (ArgumentError) argument error
		iex> case 1 do
		...>   x when hd(x) -> "Won't match"
		...>   x -> "Got #{x}"
		...> end
		"Got 1"

* If none of the clauses match, an error is raised:

		iex> case :ok do
		...>   :error -> "Won't match"
		...> end
		** (CaseClauseError) no case clause matching: :ok


* Note anonymous functions can also have multiple clauses and guards:

		iex> f = fn
		...>   x, y when x > 0 -> x + y
		...>   x, y -> x * y
		...> end
		#Function<12.71889879/2 in :erl_eval.expr/5>
		iex> f.(1, 3)
		4
		iex> f.(-1, 3)
		-3

* The no of arguments in each anonymous function clause needs to be the same, otherwise an erro is raised

		iex> f2 = fn
		...>   x, y when x > 0 -> x + y
		...>   x, y, z -> x * y + z
		...> end
		** (CompileError) iex:1: cannot mix clauses with different arities in function definition

**Cond**

* cond is used to check different conditions

		iex> cond do
		...>   2 + 2 == 5 ->
		...>     "This will not be true"
		...>   2 * 2 == 3 ->
		...>     "Nor this"
		...>   1 + 1 == 2 ->
		...>     "But this will"
		...> end
		"But this will"

* A final condition true is added, which will match any condition (just like default)

		iex> cond do
		...>   2 + 2 == 5 ->
		...>     "This is never true"
		...>   2 * 2 == 3 ->
		...>     "Nor this"
		...>   true ->
		...>     "This is always true (equivalent to else)"
		...> end
		"This is always true (equivalent to else)"

* cond considers any value besides nil and false to be true

		iex> cond do
		...>   hd([1, 2, 3]) ->
		...>     "1 is considered as true"
		...> end
		"1 is considered as true"


**if and unless**

* if and unless are macros which are useful for checking one condition 

		iex> if true do
		...>   "This works!"
		...> end
		"This works!"
		iex> unless true do
		...>   "This will never be seen"
		...> end
		nil

* if the condition given to if/2 returns false or nil, the body given between do/end is not executed and instead it returns nil. The opposite happens with unless/2

		iex> if nil do
		...>   "This won't be seen"
		...> else
		...>   "This will"
		...> end
		"This will"

**do/end block**

* If and else can be written as follows

		iex> if true, do: 1 + 2
		3

		iex> if false, do: :this, else: :that
		:that

* we can bind a function call using parenthesis

		iex> is_number(if true do
		...>  1 + 2
		...> end)
		true


**Binaries**

* Binaries are defined using ""<<>>""

		iex> <<0, 1, 2, 3>>
		<<0, 1, 2, 3>>
		iex> byte_size(<<0, 1, 2, 3>>)
		4

* Binaries can be organized in any way even if it doesn't represent a valid string

		iex> String.valid?(<<239, 191, 191>>)
		false

* String concatenation is actually a binary concatenation operator

		iex> <<0, 1>> <> <<2, 3>>
		<<0, 1, 2, 3>>

* To see the binary representation of a string concate null(<<0>>) to the string

		iex> "hełło" <> <<0>>
		<<104, 101, 197, 130, 197, 130, 111, 0>>

*  pattern matching can be used with binaries

		iex> <<0, 1, x>> = <<0, 1, 2>>
		<<0, 1, 2>>
		iex> x
		2
		iex> <<0, 1, x>> = <<0, 1, 2, 3>>
		** (MatchError) no match of right hand side value: <<0, 1, 2, 3>>


* to match binary of unknown size use binary modifier

		iex> <<0, 1, x :: binary>> = <<0, 1, 2, 3>>
		<<0, 1, 2, 3>>
		iex> x
		<<2, 3>>

* Similar thing can be achieved in string concatenation

		iex> "he" <> rest = "hello"
		"hello"
		iex> rest
		"llo"

**Char Lists**
* double quotes represent string and single quotes represent char list

* A char lists is nothing more than a list of code points. Char lists may be created with single- quoted literals

		iex> 'hełło'
		[104, 101, 322, 322, 111]
		iex> is_list 'hełło'
		true
		iex> 'hello'
		'hello'
		iex> List.first('hello')
		104

*  We can convert a char list or anything to a string using to_string/1 or to convert string or anything to char list use to_charlist/1

		iex> to_charlist "hełło"
		[104, 101, 322, 322, 111]
		iex> to_string 'hełło'
		"hełło"
		iex> to_string :hello
		"hello"
		iex> to_string 1
		"1"

**keywords lists and maps**

** keywords lists and maps are associative data structure









Error-log

* MatchError - data type on both side differ, check for specific :atom
* CompileError - Due to syntax error
	- unbound variable : that variable doesn't exists
* CaseClauseError - If no case clause matching

