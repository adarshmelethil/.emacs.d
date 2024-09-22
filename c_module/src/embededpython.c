#include "embededpython.h"

emacs_value my_function (emacs_env *env, ptrdiff_t nargs, emacs_value *args, void *data) {
  return NULL;
}

int emacs_module_init (struct emacs_runtime *runtime) {
  // Compatible emacs executable
  if (runtime->size < sizeof (*runtime)) return 1;

  // Compatible module API
  emacs_env *env = runtime->get_environment(runtime);
  if (env->size < sizeof (*env)) return 2;

  const char* filename = __FILENAME__;
  unsigned long basename_len = strlen(filename) - strlen(".c");
  char feature_name[basename_len + 1];
  memcpy(feature_name, filename, basename_len);

  Emessage("Loading %s complete", Estr(feature_name));
  _Eprovide(feature_name);

  return 0;
}

