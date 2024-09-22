
#define PY_SSIZE_T_CLEAN
#include <Python.h>

int main(int argc, char *argv[]) {
    int i;

    if (argc < 3) {
        fprintf(stderr,"Usage: call pythonfile funcname [args]\n");
        return 1;
    }

    wchar_t *program = Py_DecodeLocale(argv[0], NULL);
    if (program == NULL) {
        fprintf(stderr, "Fatal error: cannot decode argv[0]\n");
        exit(1);
    }
    PyConfig config;
    PyConfig_InitPythonConfig(&config);

    PyStatus status = PyConfig_SetString(&config, &config.program_name, program);
    if (PyStatus_Exception(status)) goto exception;

    printf("Loading module name: %s\n", argv[1]);
    /* PyObject* pName = PyUnicode_DecodeFSDefault(argv[1]); */
    PyRun_SimpleString("print('hello')");
    PyObject* pName = PyUnicode_DecodeFSDefault((char*)"mymod");
    printf("Decoded module name.");

    if (!pName) {
        printf("Failed to decode.");
        return 1;
    }

    PyObject* pModule = PyImport_Import(pName);
    printf("Loaded module.\n");
    Py_DECREF(pName);


    if (pModule != NULL) {
        PyObject* pFunc = PyObject_GetAttrString(pModule, argv[2]);
        /* pFunc is a new reference */

        if (pFunc && PyCallable_Check(pFunc)) {
            PyObject* pArgs = PyTuple_New(argc - 3);
            PyObject *pValue;
            for (i = 0; i < argc - 3; ++i) {
                pValue = PyLong_FromLong(atoi(argv[i + 3]));
                if (!pValue) {
                    Py_DECREF(pArgs);
                    Py_DECREF(pModule);
                    fprintf(stderr, "Cannot convert argument\n");
                    return 1;
                }
                /* pValue reference stolen here: */
                PyTuple_SetItem(pArgs, i, pValue);
            }
            pValue = PyObject_CallObject(pFunc, pArgs);
            Py_DECREF(pArgs);
            if (pValue != NULL) {
                printf("Result of call: %ld\n", PyLong_AsLong(pValue));
                Py_DECREF(pValue);
            }
            else {
                Py_DECREF(pFunc);
                Py_DECREF(pModule);
                PyErr_Print();
                fprintf(stderr,"Call failed\n");
                return 1;
            }
        }
        else {
            if (PyErr_Occurred())
                PyErr_Print();
            fprintf(stderr, "Cannot find function \"%s\"\n", argv[2]);
        }
        Py_XDECREF(pFunc);
        Py_DECREF(pModule);
    }
    else {
        PyErr_Print();
        fprintf(stderr, "Failed to load \"%s\"\n", argv[1]);
        return 1;
    }
    if (Py_FinalizeEx() < 0) {
        return 120;
    }
    return 0;
exception:
    PyConfig_Clear(&config);
    Py_ExitStatusException(status);
    return 1;
}
