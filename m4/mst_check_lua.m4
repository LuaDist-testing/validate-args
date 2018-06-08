# serial 1

# MST_CHECK_LUA
#----------------------
AC_DEFUN([MST_CHECK_LUA],
[
  m4_define([_MIN_V],[$1])
  m4_define([_MAX_V],[$2])
  m4_if(_MIN_V, [], [AC_MSG_ERROR([ no minimum Lua library version specified ])])
  m4_if(_MAX_V, [], [AC_MSG_ERROR([ no maximum Lua library version specified ])])


  dnl first check if there's a version specific pkg-config file. if not,
  dnl see if the "lua" package exists with a version in the requested range
  dnl make all results AX_LUA compatible, as it gets run afterwards for sanity checks
  m4_define([_MST_LUA_V_TEST],[lua[]_MIN_V])
  PKG_CHECK_EXISTS(
    [_MST_LUA_V_TEST],
    [PKG_CHECK_MODULES(LUA,[_MST_LUA_V_TEST])
     AC_SUBST([INSTALL_LMOD],[`$PKG_CONFIG --variable INSTALL_LMOD _MST_LUA_V_TEST`])
     AC_SUBST([INSTALL_CMOD],[`$PKG_CONFIG --variable INSTALL_CMOD _MST_LUA_V_TEST`])
     AC_SUBST([LUA_LIB],[$LUA_LIBS])
     AC_SUBST([LUA_INCLUDE],[$LUA_CFLAGS])
     ],
      [
        m4_define([_MST_LUA_V_TEST],[lua >= _MIN_V lua < _MAX_V])

        PKG_CHECK_EXISTS(
                        [ _MST_LUA_V_TEST ],
	                [ PKG_CHECK_MODULES(LUA,[_MST_LUA_V_TEST])
			     AC_SUBST([INSTALL_LMOD],
			      	      [`$PKG_CONFIG --variable INSTALL_LMOD _MST_LUA_V_TEST`]
                             )
 			     AC_SUBST([INSTALL_CMOD],
			              [`$PKG_CONFIG --variable INSTALL_CMOD _MST_LUA_V_TEST`]
                             )
			     AC_SUBST([LUA_LIB],[$LUA_LIBS])
			     AC_SUBST([LUA_INCLUDE],[$LUA_CFLAGS])
			 ],
		       )
      ]
  )

  AX_PROG_LUA(_MIN_V,_MAX_V)
  
  AX_LUA_HEADERS
  AX_LUA_LIBS

  AC_SUBST(LUA_VERSION,`${LUA} -e 'print(_VERSION)' | sed ["s,.*\(@<:@$as_cr_digits@:>@@<:@.@:>@@<:@$as_cr_digits@:>@\),\1,g"]`)

  LUASFX=`expr "$LUA" : '.*lua\(@<:@0-9.@:>@*\)$'`
  AC_PATH_PROG(LUAC,[luac$LUASFX])

  AC_ARG_VAR(lualibdir, [Lua module installation directory [PREFIX/share/lua/LUA_VERSION]])
  AC_ARG_VAR(lualiblcdir, [Lua compiled library installation directory [EXECPREFIX/lib/lua/LUA_VERSION]])

  test "${lualibdir+set}"  = set || lualibdir='${prefix}/share/lua/'${LUA_VERSION}

  test "${lualiblcdir+set}" = set || lualiblcdir='${exec_prefix}/lib/lua/'${LUA_VERSION}

])
