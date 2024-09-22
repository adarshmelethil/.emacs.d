#ifndef EMBEDEDPYTHON_H_
#define EMBEDEDPYTHON_H_

#include <stdio.h>
#include <string.h>
#include <emacs-module.h>


/* Helper Macros *************************************************************/
#define __ECHO__(...) __VA_ARGS__
#define __NOECHO__(...)
#define __PICK__(COND) __ ## COND ## ECHO__
#define __VA_NOOPT__(VALUE, ...) __PICK__(__VA_OPT__(NO))(VALUE)

#define ELEVENTH_ARGUMENT(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...) a11
#define COUNT_ARGUMENTS(...) ELEVENTH_ARGUMENT(dummy, ## __VA_ARGS__, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)


/* Emacs Interop Macros ******************************************************/
#define _Eintern(name) (env->intern(env, #name))
#define Eintern(name) _Eintern(name)

#define Esym(name) (env->intern(env, name))
#define Estr(value) (env->make_string(env, value, strlen(value)))

#define FUNCALL(name, ...) \
  (env->funcall(\
    env, \
    Eintern(name), \
    COUNT_ARGUMENTS(__VA_ARGS__), \
    __VA_NOOPT__(NULL, __VA_ARGS__)__VA_OPT__((emacs_value[]){__VA_ARGS__})))

#define Emessage(fstr, ...) FUNCALL(message, Estr(fstr)__VA_OPT__(,) __VA_ARGS__)
#define _Eprovide(feat) FUNCALL(provide, Esym(feat))
#define Eprovide(feat) FUNCALL(provide, Eintern(feat))

#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)


int plugin_is_GPL_compatible; // Declare mandatory GPL symbol.

#endif // EMBEDEDPYTHON_H_
