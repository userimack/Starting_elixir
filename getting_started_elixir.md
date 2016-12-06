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

* keywords lists and maps are associative data structure

		iex> list = [{:a, 1}, {:b, 2}]
		[a: 1, b: 2]
		iex> list == [a: 1, b: 2]
		true
		iex> list[:a]
		1

* a list of tuples and the first item of the tuple (i.e. the key) is an atom, we call it a keyword list

		iex> list = [{:a, 1}, {:b, 2}]
		[a: 1, b: 2]
		iex> list == [a: 1, b: 2]
		true

* all list operations can be performed on keyword lists. ex: ++ operation for adding new element to a list

* In keyword list the first element will be fetched if there is duplicate data.

* Pattern matching on keyword list 

		iex> [a: a] = [a: 1]
		[a: 1]
		iex> a
		1
		iex> [a: a] = [a: 1, b: 2]
		** (MatchError) no match of right hand side value: [a: 1, b: 2]
		iex> [b: b, a: a] = [a: 1, b: 2]
		** (MatchError) no match of right hand side value: [a: 1, b: 2]

**Maps**

* Maps are preferred over keyword lists 

* Map is created using the %{} syntax
		
		iex> map = %{:a => 1 , 2 => :b}
		%{2 => :b, :a => 1}
		iex> map[:a]
		1
		iex> map[2]
		:b
		iex> map[:c]
		nil

* maps allow any value as a key

* maps' keys do not follow any ordering

* Pattern matching in maps is very useful as it matches on subset and empty map matches all maps

		iex> %{} = %{:a => 1, 2 => :b}
		%{2 => :b, :a => 1}
		iex> %{:a => a} = %{:a => 1, 2 => :b}
		%{2 => :b, :a => 1}
		iex> a
		1
		iex> %{:c => c} = %{:a => 1, 2 => :b}
		** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}

* variables can be used in maps in place of values or atoms

* The map module provides api, few are, get , to_list

		iex> Map.get(%{:a => 1, 2 => :b}, :a)
		1
		iex> Map.to_list(%{:a => 1, 2 => :b})
		[{2, :b}, {:a, 1}]

* Maps provide their own syntax for updating accessing atom keys

		iex> map = %{:a => 1, 2 => :b}
		%{2 => :b, :a => 1}

		iex> map.a
		1
		iex> map.c
		** (KeyError) key :c not found in: %{2 => :b, :a => 1}

		iex> %{map | :a => 2}
		%{2 => :b, :a => 2}
		iex> %{map | :c => 3}
		** (KeyError) key :c not found in: %{2 => :b, :a => 1}

**Nested data structures**

* Maps can have maps inside or even keyword lists and so forth. For manipulating nested data structure we have put_in/2 and update_in/2

		iex> users = [
		  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
		  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
		]
		[john: %{age: 27, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
		 mary: %{age: 29, languages: ["Elixir", "F#", "Clojure"], name: "Mary"}]

* To access data, for ex : If we wanted to access the age for john, we could write:

		iex> users[:john].age
		27

* To update a value we can do, the update_in/2 macro is similar but allows us to pass a function that controls how the value changes. for ex: let's remove "Clojure" from Mary's list of language:

		iex> users = put_in users[:john].age, 31
		[john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
		 mary: %{age: 29, languages: ["Elixir", "F#", "Clojure"], name: "Mary"}]

		 iex> users = update_in users[:mary].languages, &List.delete(&1, "Clojure")
		[john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
		 mary: %{age: 29, languages: ["Elixir", "F#"], name: "Mary"}]

  In case of doubt in above program use 
  		iex> h update_in
  		iex h List.delete
 

**Modules**

* to create a module we use "defmodule" macro and we use "def" to define functions in that module 

		iex> defmodule Math do
		...>   def sum(a, b) do
		...>     a + b
		...>   end
		...> end

		iex> Math.sum(1, 2)
		3

* we can  save the code files by extensions 
ex - compiled by: elixirc filename.ex - generates a "Elixir.*.bean" file which is a  bytecode file 

exs - compiled by: elixir filename.exs gives output of the code
		           or
		           iex  filename.exs - open shell for working with the module 


		defmodule Math do
		  def sum(a, b) do
		    a + b
		  end
		end

		$ elixirc math.ex

		iex> Math.sum(1, 2)
		3


or

		defmodule Math do
		  def sum(a, b) do
		    a + b
		  end
		end

		IO.puts Math.sum(1, 2)

		$ elixir math.exs
		3

* **Named functions** : Inside a module we can define functions with def/2 and private functions with defp/2 which can be invoked locally

**Function captuaring**

		$ iex math.exs

		iex> Math.zero?(0)
		true
		iex> fun = &Math.zero?/1
		&Math.zero?/1
		iex> is_function(fun)
		true
		iex> fun.(0)
		true

* Local and importedfunctions can also be captuared without the module

		iex> &is_function/1
		&:erlang.is_function/1
		iex> (&is_function/1).(fun)
		true

* the captuare syntax can be used as a shortcut to create functions

		iex> fun = &(&1 + 1)
		#Function<6.71889879/1 in :erl_eval.expr/5>
		iex> fun.(1)
		2

* The &1 represents the first argument passed into the function. &(&1+1) above is exactly the same as fn x -> x + 1 end. The syntax above is useful for short function definitions.

If you want to capture a function from a module, you can do &Module.function():

		iex> fun = &List.flatten(&1, &2)
		&List.flatten/2
		iex> fun.([1, [[2], 3]], [4, 5])
		[1, 2, 3, 4, 5]

&List.flatten(&1, &2) is the same as writing fn(list, tail) -> List.flatten(list, tail) end which in this case is equivalent to &List.flatten/2.


**Default arguments**

* we can pass default argument to the functions using "\\"

		defmodule Concat do
		  def join(a, b, sep \\ " ") do
		    a <> sep <> b
		  end
		end

		IO.puts Concat.join("Hello", "world")      #=> Hello world
		IO.puts Concat.join("Hello", "world", "_") #=> Hello_world

		defmodule DefaultTest do
		  def dowork(x \\ IO.puts "hello") do
		    x
		  end
		end


		iex> DefaultTest.dowork
		hello
		:ok
		iex> DefaultTest.dowork 123
		123
		iex> DefaultTest.dowork
		hello
		:ok

* During overlapping function, a warning is thrown

defmodule Concat do
  def join(a, b) do
    IO.puts "***First join"
    a <> b
  end

  def join(a, b, sep \\ " ") do
    IO.puts "***Second join"
    a <> sep <> b
  end
end

warning: this clause cannot match because a previous clause at line 2 always matches

 This means during calling the function join the dunciton with 2 arguments will be called whereas the second one will only be invoked when 3 arguments will be passed.


		 $ iex concat.exs

		 iex> Concat.join "Hello", "world"
		***First join
		"Helloworld"

		iex> Concat.join "Hello", "world", "_"
		***Second join
		"Hello_world"


**Recursion**

* Due to immutability, loops in Elixir (as in any functional programming language) are written diferently from imperative languages (i.e C,etc)

		defmodule Recursion do
		  def print_multiple_times(msg, n) when n <= 1 do
		    IO.puts msg
		  end

		  def print_multiple_times(msg, n) do
		    IO.puts msg
		    print_multiple_times(msg, n - 1)
		  end
		end

		Recursion.print_multiple_times("Hello!", 3)
		# Hello!
		# Hello!
		# Hello!

Explanation:

Similar to case, a function may have many clauses. A particular clause is executed when the arguments passed to the function match the clause’s argument patterns and its guard evaluates to true.

When print_multiple_times/2 is initially called in the example above, the argument n is equal to 3.

The first clause has a guard which says “use this definition if and only if n is less than or equal to 1”. Since this is not the case, Elixir proceeds to the next clause’s definition.

The second definition matches the pattern and has no guard so it will be executed. It first prints our msg and then calls itself passing n - 1 (2) as the second argument.

Our msg is printed and print_multiple_times/2 is called again, this time with the second argument set to 1. Because n is now set to 1, the guard in our first definition of print_multiple_times/2 evaluates to true, and we execute this particular definition. The msg is printed, and there is nothing left to execute.

We defined print_multiple_times/2 so that, no matter what number is passed as the second argument, it either triggers our first definition (known as a base case) or it triggers our second definition, which will ensure that we get exactly one step closer to our base case.


**Reduce and map algorithms**

		defmodule Math do
		  def sum_list([head | tail], accumulator) do
		    sum_list(tail, head + accumulator)
		  end

		  def sum_list([], accumulator) do
		    accumulator
		  end
		end

		IO.puts Math.sum_list([1, 2, 3], 0) #=> 6


We invoke sum_list with the list [1, 2, 3] and the initial value 0 as arguments. We will try each clause until we find one that matches according to the pattern matching rules. In this case, the list [1, 2, 3] matches against [head | tail] which binds head to 1 and tail to [2, 3]; accumulator is set to 0.

Then, we add the head of the list to the accumulator head + accumulator and call sum_list again, recursively, passing the tail of the list as its first argument. The tail will once again match [head | tail] until the list is empty, as seen below:

		sum_list [1, 2, 3], 0
		sum_list [2, 3], 1
		sum_list [3], 3
		sum_list [], 6

When the list is empty, it will match the final clause which returns the final result of 6.

The process of taking a list and reducing it down to one value is known as a reduce algorithm and is central to functional programming.



To Double all the values in the list:

		defmodule Math do
		  def double_each([head | tail]) do
		    [head * 2 | double_each(tail)]
		  end

		  def double_each([]) do
		    []
		  end
		end

		iex math.exs

		iex> Math.double_each([1, 2, 3]) #=> [2, 4, 6]

Here we have used recursion to traverse a list, doubling each element and returning a new list. The process of taking a list and mapping over it is known as a map algorithm.

Recursion and tail call optimization are an important part of Elixir and are commonly used to create loops. However, when programming in Elixir you will rarely use recursion as above to manipulate lists.

The Enum module, which we’re going to see in the next chapter, already provides many conveniences for working with lists. For instance, the examples above could be written as

		iex> Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end)
		6
		iex> Enum.map([1, 2, 3], fn(x) -> x * 2 end)
		[2, 4, 6]

Or, using the capture syntax:

		iex> Enum.reduce([1, 2, 3], 0, &+/2)
		6
		iex> Enum.map([1, 2, 3], &(&1 * 2))
		[2, 4, 6]


**Enumerables and streams**

* Enum module are a used to traverse over a list and map

		iex> Enum.map([1, 2, 3], fn x -> x * 2 end)
		[2, 4, 6]
		iex> Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end)
		[2, 12]

* Renages can be defined by, 1..n

		iex> Enum.map(1..3, fn x -> x * 2 end)
		[2, 4, 6]
		iex> Enum.reduce(1..3, 0, &+/2)
		6

		iex> odd? = &(rem(&1, 2) != 0)
		#Function<6.80484245/1 in :erl_eval.expr/5>
		iex> Enum.filter(1..3, odd?)
		[1, 3]

* Performing multiple operations with enum module, generates intermediate list until we reach the result.

		iex> 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum
		7500000000



* The **Pipe operator (|>)** is used similar to bash (|) pipe operator, to pass values to next operator

		iex> 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum
		7500000000

Above operation if we don't use pipe operator,

		iex> Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))
		7500000000


**Streams**

* To not generate intermediate lists we use streams it act's as a lazy operation

		iex> 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum
		7500000000


** Process**

* Process in elixir are light-weight and they are not same as the os process

* **spawn**: spawn/1 takes a function which it will execute in another process and exit.
 
		iex> pid = spawn fn -> 1 + 2 end
		#PID<0.44.0>
		iex> Process.alive?(pid)
		false


* We can use self() to get the pid of the current process.

* send : to send msg to a process

* receive : to receive msg from a process

		iex> send self(), {:hello, "world"}
		{:hello, "world"}
		iex> receive do
		...>   {:hello, msg} -> msg
		...>   {:world, msg} -> "won't match"
		...> end
		"world"

===========================

Learn from here,

http://eddwardo.github.io/elixir/links/2015/11/04/links-in-elixir/
=====================================


**IO and file system**

* IO.puts to write to console

* IO.gets to get input from console
		
		iex> IO.puts "hello world"
		hello world
		:ok
		iex> IO.gets "yes or no? "
		yes or no? yes
		"yes\n"

* File module is used to work with files. It has many functions to work with the file system like, File.rm/1 (to remove a file), File.mkdir/1 (to create directories) etc.

* File.open is used to open a file and File.close is used to close a file.

* IO.binwrite/2 and IO.binread/2 are used to write and read a file as files in elixir are opened in binary mode by default.

* File module has two variants, one regualr and one with trailing bang (!).

		iex> File.read "hello"
		{:ok, "world"}
		iex> File.read! "hello"
		"world"
		iex> File.read "unknown"
		{:error, :enoent}
		iex> File.read! "unknown"
		** (File.Error) could not read file unknown: no such file or directory

* The version with trailing bang(!) raises error. The version without is prefered when we want to handle different pattern matching, however the trailing bang version is preferred if we expect the file there.

		case File.read(file) do
		  {:ok, body}      -> # do something with the `body`
		  {:error, reason} -> # handle the error caused by `reason`
		end

* **The Path module**  is used to work with paths.

		iex> Path.join("foo", "bar")
		"foo/bar"
		iex> Path.expand("~/hello")
		"/Users/jose/hello"


** Alias, Require and import**

* Alias allows to set up aliases for any given module name.

		defmodule Math do
		  alias Math.List, as: List
		end

From now on, any reference to List will automatically expand to Math.List. In case one wants to access the original List, it can be done by prefixing the module name with Elixir.:

		List.flatten             #=> uses Math.List.flatten
		Elixir.List.flatten      #=> uses List.flatten
		Elixir.Math.List.flatten #=> uses Math.List.flatten


* Aliases are frequently used to define shortcuts. In fact, calling alias without an :as option sets the alias automatically to the last part of the module name, for example:

		alias Math.List

Is the same as:

		alias Math.List, as: List

Note that alias is lexically scoped, which allows you to set aliases inside specific functions:

		defmodule Math do
		  def plus(a, b) do
		    alias Math.List
		    # ...
		  end

		  def minus(a, b) do
		    # ...
		  end
		end


In the example above, since we are invoking alias inside the function plus/2, the alias will be valid only inside the function plus/2. minus/2 won’t be affected at all.


** require **

* Elixir provides macros as a mechanism for meta-programming (writing code that generates code).

		iex> Integer.is_odd(3)
		** (CompileError) iex:1: you must require Integer before invoking the macro Integer.is_odd/1
		iex> require Integer
		Integer
		iex> Integer.is_odd(3)
		true

* Note that like the alias directive, require is also lexically scoped.

**import **

* We use import whenever we want to easily access functions or macros from other modules without using the fully-qualified name. For instance, if we want to use the duplicate/2 function from the List module several times, we can import it:

		iex> import List, only: [duplicate: 2]
		List
		iex> duplicate :ok, 3
		[:ok, :ok, :ok]

* Note that import is lexically scoped too. This means that we can import specific macros or functions inside function definitions:


		defmodule Math do
		  def some_function do
		    import List, only: [duplicate: 2]
		    duplicate(:ok, 10)
		  end
		end

# Follow doc










Error-log

* MatchError - data type on both side differ, check for specific :atom
* CompileError - Due to syntax error
	- unbound variable : that variable doesn't exists
* CaseClauseError - If no case clause matching

