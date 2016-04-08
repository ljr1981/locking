note
	description: "Tests of {LOCKING}."
	testing: "type/manual"

class
	LOCKING_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

	RANDOMIZER
		undefine
			default_create
		end

	SQLITE_TEST_HELPER
		undefine
			default_create
		end

feature -- Test routines

	sqlite_tests
			-- `sqlite_tests'
		note
			synopsis: "[
				(1) Every SQLite database has a SQLITE_MASTER table that defines the 
				schema for the database. The SQLITE_MASTER table looks like this:

				CREATE TABLE sqlite_master (
				  type TEXT,
				  name TEXT,
				  tbl_name TEXT,
				  rootpage INTEGER,
				  sql TEXT
				);
				]"
		local
			l_modify: SQLITE_MODIFY_STATEMENT
			l_insert: SQLITE_INSERT_STATEMENT
			l_query: SQLITE_QUERY_STATEMENT
			i: INTEGER
		do
			-- Database is already created from {SQLITE_TEST_HELPER}.Database as self-initializing attribute.
			create l_query.make ("SELECT name FROM sqlite_master ORDER BY name;", Database)				-- Query the sqlite_master (see synopsis note clause above)
			across l_query.execute_new as ic_cursor loop												-- Across list of tables in `sqlite_master' table.
				print (" - table: " + ic_cursor.item.string_value (1) + "%N")							-- Print each table name
			end
			create l_modify.make ("DROP TABLE IF EXISTS Example;", Database)							-- Remove any existing "Example" table
			l_modify.execute																			-- Execute removal
			create l_modify.make ("CREATE TABLE Example (Id INTEGER PRIMARY KEY, Text TEXT, Value FLOAT);", Database)	-- Setup creation for a new table
			l_modify.execute																			-- Execute table creation
			create l_insert.make ("INSERT INTO Example (Text, Value) VALUES (?1, :RND_INT);", Database)	-- Create a insert statement with variables
			check l_insert_is_compiled: l_insert.is_compiled end
			Database.begin_transaction (False)															-- Commit handling
			from until i = random_integer_in_range (1 |..| 50) loop										-- Execute the statement multiple (1 .. 50) times
				l_insert.execute_with_arguments ([														-- Execute the INSERT statement with the argument list.
						random_first_last_name, 														-- Using Eiffel object (unnamed variable @ index 1 will replace ?1)
						create {SQLITE_DOUBLE_ARG}.make (":RND_INT", random_integer_in_range (1 |..| 10)) -- Using a named argument (will replace :RND_INT)
					])
				i := i + 1
			end
			Database.commit																				-- Commit changes
			create l_query.make ("SELECT * FROM Example;", Database)									-- Query the contents of the Example table
			l_query.execute (agent process_row) 														-- Prints each row, but we could load an ARRAY as well.
			Database.close																				-- Final close
		end

feature {NONE} -- Implementation

	process_row (ia_row: SQLITE_RESULT_ROW): BOOLEAN
		note
			image: "[
				The image link below shows you how this code iterates over the columns contained
				in the `ia_row' argument.
				
				(1) Print out which row number we're on.
				(2) Go across the row columns, print each one as: [Key_name] ":" [Value_out | "<NULL>"]
				(3) Add a newline character and print the row.
				(4) Result is False by default, which means we print all rows.
				
				You can use the SQLite Studio (3.0.7) to see the results (as shown in the image).
				]"
			EIS: "name=ecma_367_standard", "src=$GITHUB/sav_training/images/sqlite3_example_row_output.png"
		local
			i: NATURAL
			l_row_output: STRING
		do
				-- Empty row output ...
			l_row_output := "> Row " + ia_row.index.out + ": %T"

			across -- Columns in row ...
				create {INTEGER_INTERVAL}.make (1, ia_row.count.as_integer_32) as ic_column
			loop
					-- Set column number ...
				i := ic_column.item.as_natural_32
					-- Column key (name) ...
				l_row_output.append_string (ia_row.column_name (i))
				l_row_output.append_character (':')
					-- Column value ...
				if ia_row.is_null (i) then
					l_row_output.append_string ("<NULL>")
				else
					l_row_output.append_string (ia_row.string_value (i))
				end
				l_row_output.append_character ('%T')
				l_row_output.append_character ('%T')
			end
			l_row_output.remove_tail (1)
			l_row_output.append_character ('%N')
		end

feature {NONE} -- Implementation: SQLite

	Database_name: STRING = "data.sqlite"

end
