note
	description: "[
		Mock representation of a {LK_CLIENT}.
		]"

class
	MOCK_CLIENT

inherit
	LK_CLIENT

create
	make_with_uuid,
	make_from_string

feature -- Access

	uuid_string: STRING
			-- <Precursor>
		attribute
			Result := uuid.out
		end

end
