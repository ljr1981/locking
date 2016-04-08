note
	description: "[
		Abstract notion of a {LK_REGISTRY}.
		]"
	purpose: "[
		Items capable of being locked are registered in a
		registry as a key:description pair.
		]"


deferred class
	LK_REGISTRY

inherit
	LK_ANY

feature -- Access

	items: HASH_TABLE [attached like Registration_data_anchor, STRING]
			-- `items' in Current {LK_REGISTRY}.
		once ("object")
			create Result.make_equal (Default_registry_capacity)
			Result := build_registry (Result)
		end

feature {NONE} -- Implementation: Basic Operations

	build_registry (a_items: like items): like items
			-- `build_registry' of `items'.
		note
			design: "[
				In descendents, begin adding items to the registry `items'
				list as-needed.
				]"
		deferred
		end

feature {NONE} -- Implementation: Constants

	Registration_data_anchor: detachable TUPLE [reg_name, reg_description: STRING; reg_uuid: UUID]

	Default_registry_capacity: INTEGER = 1_000
			-- `Default_registry_capacity' for `items'.

;note
	design: "[
		Objects that will be worked on concurrently
		]"

end
