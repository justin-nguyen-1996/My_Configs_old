# This file is generated by /feedstock_root/build_artefacts/numpy_1489877172088/work/numpy-1.12.1/setup.py
# It contains system_info results at the time of building this package.
__all__ = ["get_info","show"]

lapack_opt_info={'libraries': ['openblas', 'openblas'], 'library_dirs': ['/home/jhn545/miniconda2/lib'], 'language': 'c', 'define_macros': [('HAVE_CBLAS', None)]}
blas_opt_info={'libraries': ['openblas', 'openblas'], 'library_dirs': ['/home/jhn545/miniconda2/lib'], 'language': 'c', 'define_macros': [('HAVE_CBLAS', None)]}
blis_info={}
openblas_info={'libraries': ['openblas', 'openblas'], 'library_dirs': ['/home/jhn545/miniconda2/lib'], 'language': 'c', 'define_macros': [('HAVE_CBLAS', None)]}
openblas_lapack_info={'libraries': ['openblas', 'openblas'], 'library_dirs': ['/home/jhn545/miniconda2/lib'], 'language': 'c', 'define_macros': [('HAVE_CBLAS', None)]}
lapack_mkl_info={}
blas_mkl_info={}

def get_info(name):
    g = globals()
    return g.get(name, g.get(name + "_info", {}))

def show():
    for name,info_dict in globals().items():
        if name[0] == "_" or type(info_dict) is not type({}): continue
        print(name + ":")
        if not info_dict:
            print("  NOT AVAILABLE")
        for k,v in info_dict.items():
            v = str(v)
            if k == "sources" and len(v) > 200:
                v = v[:60] + " ...\n... " + v[-60:]
            print("    %s = %s" % (k,v))
    