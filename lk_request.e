note
	description: "[
		Abstract notion of a {LK_REQUEST}.
		]"

deferred class
	LK_REQUEST [G -> LK_REGISTRY create default_create end]

inherit
	LK_ANY

	FW_UU_IDENTIFIED
		rename
			uuid as item_type_id
		end

feature {NONE} -- Initialization

	make (a_client_id, a_item_type_id: like item_type_id; a_item_number: like item_number)
			-- `make' with `a_item_id'.
		require
			registered: registry.items.has (a_item_type_id.out)
		do
			client_id := a_client_id
			set_from_uuid (a_item_type_id)
			item_number := a_item_number
		ensure
			item_id_set: item_type_id ~ a_item_type_id
			client_id_dset: client_id ~ a_client_id
			item_number_set: item_number = a_item_number
		end

feature -- Access

	item_number: INTEGER_64
			-- `item_number' of `item_type_id' for `client_id'.

	client_id: UUID
			-- `client_id' of Current {LK_REQUEST}.

feature {NONE} -- Implementation

	registry: G
			-- `registry' for internal use.
		once ("object")
			create {G} Result
		end

	uuid_string: STRING
			-- <Precursor>
		attribute
			Result := item_type_id.out
		end

;note
	design: "[
		Every item needing to be locked within a system has unique "type".
		Within each type are instances of items, which must have a unique
		`item_number'. The requested lock is always issued by some Client,
		where the Client has a unique `client_id'.
		]"

end
