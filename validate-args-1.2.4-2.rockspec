-- This file was automatically generated for the LuaDist project.

package = 'validate-args'
version = '1.2.4-2'
-- LuaDist source
source = {
  tag = "1.2.4-2",
  url = "git://github.com/LuaDist-testing/validate-args.git"
}
-- Original source
-- source = {
--   url = "https://bitbucket.org/djerius/validate.args/downloads/validate-args-1.2.4.tar.gz"
-- }

description = {
   summary = "Function argument validation",
   detailed = [[
	 validate.args provides validation of function arguments
	 by type, value, and user provided validation functions.
         it can handle named and positional arguments.
   ]],

   license = "GPL-3",

}

dependencies = {
   "lua >= 5.1"
}

build = {

   type = "builtin",

   modules = {
      ["validate.args"] = "validate/args.lua",
      ["validate.inplace"] = "validate/inplace.lua",
   },

   copy_directories = {
   "doc", "tests"
   }

}