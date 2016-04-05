note
	description: "[
		Representation of a {LK_ANY} root class.
		]"
	design: "See notes at the end of this class."

class
	LK_ANY

note
	design: "[
		A root class for the locking library.
		GETTING A LOCK:
		----------------------------
		* Create a locking record for Client ID / Object ID
		* Set lock to status of "Awaiting lock"
		* Wait synch/asynch MS (milliseconds)
		* Scan for other locks
		* First "Awaiting lock" status get the lock.
		* Set that first record to "Locked"
		* Set a lock-expiration (if applicable)

		RELEASING A LOCK:
		--------------------------------
		* Ensure still has-lock and not expired.
		* Set the lock status to "Unlocked"
		* Record date-time of unlocking

		MISCELLANEOUS
		----------------------------
		* Lock contentions are resolved by giving the lock to the first-in-line (FIFO locking)
		* Expirations allows dead-client locks to be removed by subsequent clients.
		* Expirations allow live-clients to keep extending (if alive) their expirations.
		* Expirations allow live-clients with valid memory data sets to auto-save (if desired).
		* Expired expirations allow live-clients to test for merge conflicts and resolve.

		Rules around expirations of data-editing can be built to satisfy even the most discriminating use-cases.

		Another choice is to "Live-edit", where as soon as data item collections become valid, their data is flushed to storage immediately.

		There is also other possibilities:

		1. Showing users the changes that each other is making.
		2. User-chatting with regard to ad-hoc in-memory changes vs. last DB version.
		]"

end
