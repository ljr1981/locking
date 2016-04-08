note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LK_REGISTRY_TEST_SET

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

feature -- Test routines

	mock_registry_creation_tests
			-- `mock_registry_creation_tests'
		local
			l_registry: MOCK_REGISTRY
			l_client_1,
			l_client_2: MOCK_CLIENT
			l_request_1,
			l_request_2: MOCK_REQUEST
		do
			create l_registry
			assert_strings_equal ("employee", "employee", l_registry.employee.reg_name)
			assert_strings_equal ("doctor", "doctor", l_registry.doctor.reg_name)
			assert_strings_equal ("manager", "manager", l_registry.manager.reg_name)
			create l_client_1.make_with_uuid ((create {RANDOMIZER}).uuid)
			assert_32 ("not_empty", not l_client_1.uuid_string.is_empty)
			create l_client_1.make_from_string (client_1_uuid)
			assert_strings_equal ("uuid_1", client_1_uuid, l_client_1.uuid_string)
			create l_client_2.make_from_string (client_2_uuid)
			assert_strings_equal ("uuid_2", client_2_uuid, l_client_2.uuid_string)
			create l_request_1.make (l_client_1.uuid, l_registry.employee.reg_uuid, 1)
			assert_strings_equal ("request_1", l_client_1.uuid_string, l_request_1.client_id.out)
			create l_request_2.make (l_client_2.uuid, l_registry.employee.reg_uuid, 1)
			assert_strings_equal ("request_2", l_client_2.uuid_string, l_request_2.client_id.out)
		end

feature {NONE} -- Implementation: Test Support

	client_1_uuid: STRING = "737269E6-A599-4312-A623-86ACED80136F"
	client_2_uuid: STRING = "D942F740-455F-4D8B-97FC-57D6D672847C"

end


