note
	description: "[
		Abstract notion of a SQLite3 Test Helper {SQLITE_TEST_HELPER}.
		]"

deferred class
	SQLITE_TEST_HELPER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do

		end


feature {NONE} -- Implementation

	database: SQLITE_DATABASE
		attribute
			create Result.make_create_read_write (Database_name)
		end

	Database_name: STRING
			-- `database_name' for `database'.
		deferred
		end

end
