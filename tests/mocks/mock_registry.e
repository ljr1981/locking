note
	description: "[
		Mock representation of a {LK_REGISTRY}.
		]"

class
	MOCK_REGISTRY

inherit
	LK_REGISTRY

feature -- Access

	employee: attached like Registration_data_anchor once ("object") Result := ["employee", "Employee", create {UUID}.make_from_string ("15BFF7EC-ED72-4403-9A65-749EFC64D4F0")] end
	doctor: attached like Registration_data_anchor once ("object") Result := ["doctor", "Doctor", create {UUID}.make_from_string ("17E529EE-F41F-41E6-887A-A933BDDBF9C3")] end
	manager: attached like Registration_data_anchor once ("object") Result := ["manager", "Manager", create {UUID}.make_from_string ("A36356FD-155C-4DF2-8516-5E229C8D59E5")] end

feature {NONE} -- Implementation

	build_registry (a_items: like items): like items
			-- <Precursor>
		require else
			empty: a_items.is_empty
		do
			a_items.force (employee, employee.reg_uuid.out)
			a_items.force (doctor, doctor.reg_uuid.out)
			a_items.force (manager, manager.reg_uuid.out)
			Result := a_items
		ensure then
			count: a_items.count = 3
		end

end
