#include <stdio.h>
#include <string.h>
#include <emacs-module.h>

#define __ECHO__(...) __VA_ARGS__
#define __NOECHO__(...)
#define __PICK__(COND) __ ## COND ## ECHO__
#define __VA_NOOPT__(VALUE, ...) __PICK__(__VA_OPT__(NO))(VALUE)

#define ELEVENTH_ARGUMENT(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...) a11
#define COUNT_ARGUMENTS(...) ELEVENTH_ARGUMENT(dummy, ## __VA_ARGS__, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

#define _SYM(name) (env->intern(env, #name))
#define SYM(name) _SYM(name)

#define ARGS
#define FUNCALL(name, ...) \
  env->funcall(\
    env, \
    SYM(name), \
    COUNT_ARGUMENTS(__VA_ARGS__), \
    __VA_NOOPT__(NULL, __VA_ARGS__)__VA_OPT__((emacs_value[]){__VA_ARGS__}))


#define STR(value) (env->make_string(env, value, strlen(value)))

/* Declare mandatory GPL symbol.  */
int plugin_is_GPL_compatible;

emacs_value my_function (emacs_env *env, ptrdiff_t nargs, emacs_value *args, void *data) {
  return NULL;
}

int emacs_module_init (struct emacs_runtime *runtime) {
  // Compatible emacs executable
  if (runtime->size < sizeof (*runtime)) return 1;

  // Compatible module API
  emacs_env *env = runtime->get_environment(runtime);
  if (env->size < sizeof (*env)) return 2;

  FUNCALL(message, STR("mymod: Loading complete"));
  return 0;
}

int main() {
  // printf() displays the string inside quotation
  printf("Hello, World!");
  return 0;
}
