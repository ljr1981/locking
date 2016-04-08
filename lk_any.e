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
		
		Locking is a semantic. It locks an idea for a purpose. It is
		unlike simplistic database locking (pessimistic or optimistic).
		Locking more akin to queue of customers being served in a line
		at the bank. Only one customer can be served at a time. The
		nature of the queue is: Next-in-line-is-Next-served. The bank
		teller is the resource; where business is transacted.
		
		The customer being served can:
		
		(1) Complete the transaction against the resource.
		(2) Abandon the transaction against the resource.
		
		The customer being served may also be on a time-limit with the
		resource. They may be allowed to renew their lock on the resource.
		They may renew indefinitely or within limits. The time may
		grow or shrink, depending on the design needs.
		
		The customers in line can dequeue--that is--get out of line.
		The customers in line can communicate with each other and
		opt to trade places in line by cooperation and agreement.
		Customers in line can be bypassed by an overriding authority.
		
		Contention and Deadlock
		=======================
		If the Locking mechanism is treated as a queue, then whoever
		arrives first has precedence. This is possible, because the
		controlling authority over "place-in-line" and the line itself
		is an external mechanism (e.g. a database). The mechanical
		behavior of this mechanism is that clients of the mechanism
		do not control the writing of the queue and the writing is
		performed in a particular order. This reality results in "locks"
		(e.g. place-in-line) being written in whatever order they
		arrive. Contention and deadlocking are mitigated by the
		controlling authority over the queue.
		
		Writing of "place-in-line" is where the controlling authority
		ends. Customers in the queue (line) have a simple instruction:
		"Check myself to see if my place-in-line is next".
		
		Determination of this `is_first_in_line' is simple: "Is my
		place-in-line entry the oldest unserviced entry?" Entries
		are either older or younger in terms of order (as measured
		by an auto-incrementing ID or record number).
		
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
