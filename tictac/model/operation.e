note
	description: "Summary description for {OPERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OPERATION

feature -- Attributes

	error_present: BOOLEAN

feature
	execute
		deferred
		end

	undo
		deferred
		end

	redo
		deferred
		end

end
