#define PY_SSIZE_T_CLEAN
#include <Python.h>


int main(int argc, char *argv[]) {
  PyConfig config;
  PyConfig_InitPythonConfig(&config);

  /* Set the program name. Implicitly preinitialize Python. */
  PyStatus status = PyConfig_SetString(&config, &config.program_name,
                                       L"/path/to/my_program");
  if (PyStatus_Exception(status)) goto end;

  status = Py_InitializeFromConfig(&config);
  if (PyStatus_Exception(status)) goto end;

  PyRun_SimpleString("from time import time,ctime\n"
                     "print('Today is', ctime(time()))\n");

  PyObject* pName = PyUnicode_DecodeFSDefault((char*)"mymod");
  if (!pName) {
    printf("Failed to decode decoded name\n");
    goto end;
  }
  int res = PyRun_SimpleString("import sys; sys.path.insert(0, '.')");
  if (res < 0) {
    printf("Failed to set import path.\n");
    goto end;
  }

  /* res = PyRun_SimpleString("import mymod"); */
  /* if (res < 0) { */
  /*   printf("Failed to import mymod.\n"); */
  /*   goto end; */
  /* } */

  PyObject* pModule = PyImport_Import(pName);
  if (!pModule) {
    printf("Failed to import module");
    goto end;
  }
  printf("Loaded module.\n");

  PyObject* pFunc = PyObject_GetAttrString(pModule, "my_func");
  if (!pFunc) {
    printf("Failed to getattr module");
    goto end;
  }
  printf("Got attr.\n");
  if (!PyCallable_Check(pFunc)) {
    printf("Attr is not callable.");
    goto end;
  }
  PyObject* pArgs = PyTuple_New(0);
  PyObject* pValue = PyObject_CallObject(pFunc, pArgs);
  if (pValue != NULL) {
    printf("Func return value %ld.\n", PyLong_AsLong(pValue));
  } else {
    printf("Failed to call function.\n");
  }

 end:
  PyConfig_Clear(&config);
  if (status.exitcode) Py_ExitStatusException(status);
  return 0;
}
