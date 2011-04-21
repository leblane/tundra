-- Copyright 2010 Andreas Fredriksson
--
-- This file is part of Tundra.
--
-- Tundra is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- Tundra is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Tundra.  If not, see <http://www.gnu.org/licenses/>.

module(..., package.seeall)

local native = require "tundra.native"

function apply(env, options)
	-- load the generic C toolset first
	tundra.boot.load_toolset("generic-cpp", env)

	local vbcc_root = assert(native.getenv("VBCC"), "VBCC environment variable must be set")

	env:set_many {
		["NATIVE_SUFFIXES"] = { ".c", ".cpp", ".cc", ".cxx", ".a", ".o" },
		["OBJECTSUFFIX"] = ".o",
		["LIBPREFIX"] = "",
		["LIBSUFFIX"] = ".a",
		["CC"] = vbcc_root .. "/bin/vc",
		["LIB"] = vbcc_root .. "/bin/vlink",
		["LD"] = vbcc_root .. "/bin/vc",
		["_OS_CCOPTS"] = "",
		["_OS_CXXOPTS"] = "",
		["CCOPTS"] = "",
		["CXXOPTS"] = "",
		["CCCOM"] = "$(CC) $(_OS_CCOPTS) -c $(CPPDEFS:p-D) $(CPPPATH:f:p-I) $(CCOPTS) $(CCOPTS_$(CURRENT_VARIANT:u)) -o $(@) $(<)",
		["PROGOPTS"] = "",
		["PROGCOM"] = "$(LD) $(PROGOPTS) $(LIBPATH:p-L) $(LIBS:p-l) -o $(@) $(<)",
		["PROGPREFIX"] = "",
		["LIBOPTS"] = "",
		["LIBCOM"] = "$(LIB) -r $(LIBOPTS) -o $(@) $(<)",
	}
end
