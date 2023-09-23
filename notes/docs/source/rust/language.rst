Language Fundamentals
=====================

Formating
---------

Formating is used to print/write formated strings.

**Macros**

* **format!**: write formatted text to String
* **print!**: same as format! but the text is printed to the console (io::stdout).
* **println!**: same as print! but a newline is appended.
* **eprint!**: same as print! but the text is printed to the standard error (io::stderr).
* **eprintln!**: same as eprint! but a newline is appended.

**Traits** 

* **fmt::Debug**: Uses the {:?} marker. Format text for debugging purposes.
* **fmt::Display**: Uses the {} marker. Format text in a more elegant, user friendly fashion.

To generate **Debug** automatic use **#[derive(Debug)]**.
**Display** trait implement **to_string()** method and must be implemented for custom types.

.. code-block::  rust

    use std::fmt;

    struct Point {
        x: i32,
        y: i32,
    }

    impl fmt::Display for Point {
        fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
            write!(f, "({}, {})", self.x, self.y)
        }
    }

    let origin = Point { x: 0, y: 0 };

    assert_eq!(format!("The origin is: {origin}"), "The origin is: (0, 0)");





Enums
-----

Enums in rust are stored like unions in C, so an enum has a **tag** (integer number for id) and **data**.
Memory is allocated for the largest enum value and represented as **[TAG:DATA]**

To get **data** from enum use **match**.

.. code-block::  rust

    enum ExampleEnum{
        NoData,
        DataTupleLike(i32,i64),
        DataStructLike{a: i32, b: i64}
    }

    let mut exe = ExampleEnum::NoData;

    match exe {
        ExampleEnum::NoData =>  exe = ExampleEnum::DataTupleLike(5_i32, 10_i64),
        ExampleEnum::DataTupleLike(_, _) => ExampleEnum::DataStructLike{a: 5_i32, b: 10_i64}
    }



Enums can be use to create recursive data structures like linked lists and trees using box: 

.. code-block::  rust

    enum List<T>{
        Nil,
        Node{value: T, next: Box<List<T>>},
    }

The memory allocated for **tag** for Enum in Rust can be optimized out if the Enum has
two variants where one has no data and zero represents an invalid value.
This is called **null pointer optimization**. This pattern can be used with pointers inside 
enums considering that prt must not be null. The idea is that for the variant with no data, 
set it to all zeros. The size of this enum is the same size of the data. Examples of enum with this pattern: 

.. code-block::  rust

    pub enum WithNullPtrOptimization{
        A,
        B(String),
    }

    pub enum WithoutNullPtrOptimization{
        A,
        B(u32),
    }

    fn main()  {
        println!("{} {}", std::mem::size_of::<WithNullPtrOptimization>(), std::mem::size_of::<String>()); // 24 24
        println!("{} {}", std::mem::size_of::<WithoutNullPtrOptimization>(), std::mem::size_of::<u32>()); // 8 4
    }

Ownership and References
------------------------

Sometimes, is needed to get the value pointed by a mutable reference without moving it. 
The workaround for it is to replace the pointed value with another valid value and get 
the old one. To do that use **std::mem::replace**. This is the same as an assigment a new
but new value to the data pointed by mut reference but returning the old value.

.. code-block:: rust 


    enum List {
        Empty,
        Next(Box<ListNode<i32>>),
    }

    struct ListNode<i32> {
        data: i32,
        next: List,
    }

    impl List {
        pub fn new() -> Self {
            List::Empty
        }

        pub fn push(&mut self, data: i32) {
            match self {
                List::Empty => {
                    *self = List::Next(Box::new(ListNode {
                        data,
                        next: List::Empty,
                    }))
                }
                List::Next(_) => {
                    *self = List::Next(Box::new(ListNode {
                        data,
                        next: std::mem::replace(self, List::Empty),
                    }))
                }
            }
        }
    }


**Todo**: Using reference counted values **Rc<T>** and **Arc<T>**.


Generics and Traits
-------------------

Used to implement polymorphism in rust.

Traits are like interfaces and abstract classes in other languages. 
Traits are implemented by types.
To define a trait just create one with its signatures methods.
 

.. code-block:: rust 

    trait Write {
        fn write(&mut self, buf: &[u8]) -> Result<usize>;
        fn flush(&mut self) -> Result<()>;
        n write_all(&mut self, buf: &[u8]) -> Result<()> { ... }
        ...
    }

To implemet a trait do: 

.. code-block:: rust 

    trait MyCustomTrait {
        fn write_custom(&mut self, buf: &[u8]) -> Result<usize>;
        fn read(&mut self) -> Result<()>;
        n bye(&mut self, buf: &[u8]) -> Result<()> { ... }
        ...
    }

    struct MyCustomType {} 

    impl MyCustomTrait for MyCustomType {}

Default behaviour can be implememented in trait definition:


.. code-block:: rust 

    trait Write {
        fn write(&mut self, buf: &[u8]) -> Result<usize>;
        fn flush(&mut self) -> Result<()>;
        
        fn write_all(&mut self, buf: &[u8]) -> Result<()> { 
            let mut bytes_written = 0;
            while bytes_written < buf.len() {
                bytes_written += self.write(&buf[bytes_written..])?;
            }
            Ok(())       
        }
        
    }

A trait object defined **dyn Error** means any type that implements the **Error** 
trait. Trait object are virtual functions and implement **dynamic dispatch** \
(runtime polymorphism). Trait objects can't be used on their because the size of 
the type is not know on compile type. Always use them with a pointer (reference, Box). 

.. code-block:: rust 

    fn set(obj: &mut dyn Error, value: i32) 
    {
        /// ...
    }

Is possible to declare **Subtraits**. Subtraits are like extensions to a trait.
The syntax **trait MyTraitSecond: YourTraitFirst** means that all **MyTraitSecond** 
are also **YourTraitFirst** and all types that implement **MyTraitSecond** 
must implement **YourTraitFirst**.

.. code-block:: rust 

    trait MyTraitSecond: YourTraitFirst {
        fn position(&self) -> (i32, i32);
        fn facing(&self) -> Direction;
    ...
    }

Trait functions without **self** arguments are called type associated functions.

.. code-block:: rust 

    trait StringSet {
        /// Return a new empty set.
        fn new() -> Self;
        /// Return a set that contains all the strings in `strings`.
        fn from_slice(strings: &[&str]) -> Self;
        /// Find out if this set contains a particular `value`.
        fn contains(&self, string: &str) -> bool;
        /// Add a string to this set.
        fn add(&mut self, string: &str);
    }

Fully qualified methods calls (call the exactly method of the exactly trait and type).


.. code-block:: rust 

    "hello".to_string()
    
    str::to_string("hello")

    ToString::to_string("hello")

    <str as ToString>::to_string("hello")

**TODO**: Associated Types 

**TODO**: Generic Traits 

**TODO**: impl Trait


Generics (Generic Types) are like templates in C++ and 
implement the same behaviour for diferents types.

Generics use Bounds to Limit supported types using syntax **<T: Write + Ord>** that 
means all types T that implement the Write and Ordered traits. 

.. code-block:: rust 

    // Given two values, pick whichever one is less.
    fn min<T: Ord>(value1: T, value2: T) -> T {
        if value1 <= value2 {
            value1
        } else {
            value2
        }
    }

    // Subtrait syntax is just like sintatic sugar for a Bound
    trait Creature where Self: Visible {
    ...
    }

When bounds become to difult to write, is better to use a **where** clause:

.. code-block:: rust 

    fn dot<N>(v1: &[N], v2: &[N]) -> N
        where N: Add<Output=N> + Mul<Output=N> + Default + Copy
    {
        let mut total = N::default();
        for i in 0 .. v1.len() {
            total = total + v1[i] * v2[i];
        }
        total
    }



Match and Patterns
------------------

**TODO**:Using match guards


Error Handling
--------------

Is possible to use **panic!()** macro to abort program. 
Use env var **RUST_BACKTRACE** to show a stack unwinding.


Use results enum **Result<T,E>** to return errors from functions. 
This enum returns the real result value with type **T** using the **Ok(T)** variant and if an error happens,
an error with type **E** as **Err(E)** variant. This notation is 
how rust deal with **generic types**.

.. code-block:: rust 

    enum Result<T,E> { 
        Ok(T),
        Err(E)
    }

Use type aliases in module that returns the same error type 
but diferent values types:

.. code-block:: rust 

    type Result<T> = std::result::Result<T,std::io::Error>

Use the **?** operator to propagate errors. 

When a funtion returns an error type and **?** returns another, the compiler will 
try to convert the return error to the function error using the **From** trait.

.. code-block:: rust 

    use std::fs;
    use std::io;
    use std::path::Path;

    fn move_all(src: &Path, dst: &Path) -> io::Result<()> {
        for entry_result in src.read_dir()? { // opening dir could fail
            let entry = entry_result?;
            // reading dir could fail
            let dst_file = dst.join(entry.file_name());
            fs::rename(entry.path(), dst_file)?; // renaming could fail
        }
        Ok(()) // phew!
    }

To handle diferent error types use one of the ways: 

1. Defines Generic Errors to Handle Any Error.

.. code-block:: rust 

    type GenericError = Box<dyn std::error::Error + Send + Sync + 'static>;
    type GenericResult<T> = Result<T, GenericError>;

2. Define custom module errors that convert other error 
   to the modules error using the **From** trait. 

3. Use crates like **anyhow**.


To ignore errrors, use the **_** operator:

.. code-block:: rust 

    fn my_func(a: i32) -> Result<i32, CustomError> {
        //...
    }

    let _ = my_func(10);


Use **unwrap** and variations to get the real result value. If this value is an 
error, the program will panic:

.. code-block:: rust 

    let num = digits.parse::<u64>().unwrap();

To implement and declare a custom error type, do these steps:

1. Define the error type 

2. Implement the **Display** trait for it 

3. Implement the **Error** trait for it

All std lib error implement the **std::io::Error** trait.

.. code-block:: rust 

    // json/src/error.rs
    #[derive(Debug, Clone)]
    pub struct JsonError {
        pub message: String,
        pub line: usize,
        pub column: usize,
    }

    return Err(JsonError {
        message: "expected ']' at end of array".to_string(),
        line: current_line,
        column: current_column
    });

    use std::fmt;

    // Errors should be printable.
    impl fmt::Display for JsonError {
        fn fmt(&self, f: &mut fmt::Formatter) -> Result<(), fmt::Error> {
            write!(f, "{} ({}:{})", self.message, self.line, self.column)
        }
    }

    // Errors should implement the std::error::Error trait,
    // but the default definitions for the Error methods are fine.
    impl std::error::Error for JsonError { }


4. Or use the **thiserror** crate to automate steps 2 and 3.

.. code-block:: rust 

    use thiserror::Error;
    #[derive(Error, Debug)]
    #[error("{message:} ({line:}, {column})")]
    pub struct JsonError {
        message: String,
        line: usize,
        column: usize,
    }




Interior Mutability
-------------------

Is useful when mutability is need using **shared references** (non mutable).
Use **Cell<T>** and **RefCell<T>**. 

* **Cell<T>** allows to get/set the data without having mutable acces to the data

* **RefCell<T>** is same as above, but let borrowing shared and mutables references to 
  the data. The borrowing rules are still checked, but in runtime instead of  compile 
  time. If the rules are broke, the program panics. 




